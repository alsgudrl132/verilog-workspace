`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2025 02:29:27 PM
// Design Name: 
// Module Name: controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fnd_cntr(
    input clk, reset_p,
    input [15:0] fnd_value,
    input hex_bcd,
    output [7:0] seg_7,
    output [3:0] com);
    
    wire [15:0] bcd_value;
    bin_to_dec bcd(.bin(fnd_value[11:0]), .bcd(sec_bcd));
    
    reg [16:0] clk_div;
    always @(posedge clk)clk_div = clk_div + 1;
    
    anode_selector ring_com(
        .scan_count(clk_div[16:15]), .an_out(com));
    reg [3:0] digit_value; 
    wire [15:0] out_value;
    assign out_value = hex_bcd ? fnd_value : bcd_value;   
    always @(posedge clk or posedge reset_p)begin
        if(reset_p)begin
            digit_value = 0;
        end
        else begin
            case(com)
                4'b1110 : digit_value = out_value[3:0];
                4'b1101 : digit_value = out_value[7:4];
                4'b1011 : digit_value = out_value[11:8];
                4'b0111 : digit_value = out_value[15:12];
            endcase
        end
    end
    seg_decoder dec(.digit_in(digit_value), .seg_out(seg_7));
endmodule

module debounce (
    input clk,
    input btn_in,
    output reg btn_out
);

    reg [15:0] count;
    reg btn_sync_0, btn_sync_1;
    wire stable = (count == 16'hFFFF);

    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;
    end

    always @(posedge clk) begin
        if(btn_sync_1 == btn_out) begin
            count <= 0;
        end else begin
            count <= count + 1;
            if(stable)
                btn_out <= btn_sync_1;
        end
    end

endmodule

module btn_cntr(
    input clk, reset_p,
    input btn,
    output btn_pedge, btn_nedge);
    wire debounced_btn;
    debounce btn_0(.clk(clk), .btn_in(btn), .btn_out(debounced_btn));
    
    edge_detector_p btn_ed(
        .clk(clk), .reset_p(reset_p), .cp(debounced_btn),
        .p_edge(btn_pedge), .n_edge(btn_nedge));

endmodule

//===================================================
// DHT11 Controller
//===================================================
module dht11_cntr(
    input clk, reset_p,          // 시스템 클럭, 리셋
    inout dht11_data,            // DHT11 데이터 핀 (양방향)
    output reg [7:0] humidity,   // 습도 값
    output reg [7:0] temperature,// 온도 값
    output [15:0] led            // 디버깅용 LED 출력
);

    //===================================================
    // 상태 정의 (FSM)
    //===================================================
    localparam S_IDLE       = 6'b00_0001;  // 대기 상태
    localparam S_LOW_18MS   = 6'b00_0010;  // MCU → DHT11 Start 신호 (18ms Low)
    localparam S_HIGH_20US  = 6'b00_0100;  // MCU → High 유지 (20us)
    localparam S_LOW_80US   = 6'b00_1000;  // DHT11 응답 Low (80us)
    localparam S_HIGH_80US  = 6'b01_0000;  // DHT11 응답 High (80us)
    localparam S_READ_DATA  = 6'b10_0000;  // 데이터 읽기 상태

    // 데이터 읽기 서브 상태
    localparam S_WAIT_PEDGE = 2'b01;       // 상승 엣지 대기
    localparam S_WAIT_NEDGE = 2'b10;       // 하강 엣지 대기
    
    //===================================================
    // 마이크로초(us) 단위 타이밍 카운터
    //===================================================
    wire clk_usec_nedge;
    clock_div_100 us_clk(
        .clk(clk), 
        .reset_p(reset_p),
        .nedge_div_100(clk_usec_nedge)     // 1us 단위 네거티브 엣지 펄스
    );
    
    reg [21:0] count_usec; // 마이크로초 카운터
    reg count_usec_e;      // 카운터 enable

    always @(negedge clk, posedge reset_p) begin
        if(reset_p)
            count_usec = 0;  // 리셋 시 카운터 초기화
        else if(clk_usec_nedge && count_usec_e)
            count_usec = count_usec + 1;  // enable 상태에서 카운트 증가
        else if(!count_usec_e)
            count_usec = 0;  // enable=0이면 카운터 초기화
    end
    
    //===================================================
    // DHT11 데이터 핀 엣지 검출
    //===================================================
    wire dht_nedge, dht_pedge;
    edge_detector_p dht_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(dht11_data),
        .p_edge(dht_pedge),  // 상승 엣지
        .n_edge(dht_nedge)   // 하강 엣지
    );
        
    reg dht11_buffer;        // 출력 버퍼
    reg dht11_data_out_e;    // 출력 enable
    assign dht11_data = dht11_data_out_e ? dht11_buffer : 'bz; // 삼상 버퍼
    
    //===================================================
    // FSM 상태 변수
    //===================================================
    reg [5:0] state, next_state;
    assign led[5:0] = state; // 현재 상태를 LED로 표시
    reg [1:0] read_state;
    
    always @(negedge clk, posedge reset_p) begin
        if(reset_p) 
            state = S_IDLE;
        else 
            state = next_state;
    end
    
    //===================================================
    // 데이터 수신
    //===================================================
    reg [39:0] temp_data;   // 수신 데이터 버퍼 (40bit)
    reg [5:0] data_count;   // 수신된 비트 수
    assign led[11:6] = data_count;
    
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            next_state = S_IDLE;
            temp_data = 0;
            data_count = 0;
            dht11_data_out_e = 0;
            read_state = S_WAIT_PEDGE;
        end
        else begin
            case(state)
                //---------------------------------------------------
                // 초기 대기 상태 (약 3초)
                //---------------------------------------------------
                S_IDLE: begin
                    if(count_usec < 22'd3_000_000) begin // 3초 대기
                        count_usec_e = 1;
                        dht11_data_out_e = 0;
                    end
                    else begin
                        count_usec_e = 0;
                        next_state = S_LOW_18MS;
                    end
                end
                
                //---------------------------------------------------
                // MCU → Start 신호 (18ms Low)
                //---------------------------------------------------
                S_LOW_18MS: begin
                    if(count_usec < 22'd18_000) begin
                        count_usec_e = 1;
                        dht11_data_out_e = 1;
                        dht11_buffer = 0;
                    end
                    else begin
                        count_usec_e = 0;
                        next_state = S_HIGH_20US;
                        dht11_data_out_e = 0;
                    end
                end
                
                //---------------------------------------------------
                // MCU → High 유지 (20us)
                //---------------------------------------------------
                S_HIGH_20US: begin
                    count_usec_e = 1;
                    if(count_usec > 22'd100_100) begin
                        count_usec_e = 0;
                        next_state = S_IDLE;
                    end
                    if(dht_nedge) begin
                        next_state = S_LOW_80US;
                        count_usec_e = 0;
                    end
                end
                
                //---------------------------------------------------
                // DHT11 응답 Low (80us)
                //---------------------------------------------------
                S_LOW_80US: begin
                    count_usec_e = 1;
                    if(count_usec > 22'd100_100) begin
                        count_usec_e = 0;
                        next_state = S_IDLE;
                    end
                    if(dht_pedge) begin
                        next_state = S_HIGH_80US;
                        count_usec_e = 0;
                    end
                end
                
                //---------------------------------------------------
                // DHT11 응답 High (80us)
                //---------------------------------------------------
                S_HIGH_80US: begin
                    count_usec_e = 1;
                    if(count_usec > 22'd100_100) begin
                        count_usec_e = 0;
                        next_state = S_IDLE;
                    end
                    if(dht_nedge) begin
                        next_state = S_READ_DATA;
                        count_usec_e = 0;
                    end
                end
                
                //---------------------------------------------------
                // DHT11 데이터 수신 (40bit)
                //---------------------------------------------------
                S_READ_DATA: begin
                    case(read_state)
                        // 상승 엣지 대기
                        S_WAIT_PEDGE: begin
                            if(dht_pedge) 
                                read_state = S_WAIT_NEDGE;
                            count_usec_e = 0;
                        end
                        // 하강 엣지 대기
                        S_WAIT_NEDGE: begin
                            if(dht_nedge) begin
                                read_state = S_WAIT_PEDGE;
                                data_count = data_count + 1;
                                // '0' or '1' 판별 (펄스 폭 기준)
                                if(count_usec < 50) 
                                    temp_data = {temp_data[38:0], 1'b0};
                                else 
                                    temp_data = {temp_data[38:0], 1'b1};
                            end
                            else begin
                                count_usec_e = 1;
                                if(count_usec > 22'd100_000) begin
                                    count_usec_e = 0;
                                    next_state = S_IDLE;
                                    data_count = 0;
                                    read_state = S_WAIT_PEDGE;
                                end
                            end
                        end
                    endcase
                    // 데이터 40bit 수신 완료
                    if(data_count >= 40) begin
                        next_state = S_IDLE;
                        data_count = 0;
                        if(temp_data[39:32] + temp_data[31:24] + temp_data[23:16] + temp_data[15:8] == temp_data[7:0]) begin
                            humidity = temp_data[39:32];
                            temperature = temp_data[23:16];
                        end
                    end
                end
                default: 
                    next_state = S_IDLE;
            endcase
        end
    end
endmodule

// ============================================
// HC-SR04 거리 측정 모듈 (FND용)
// ============================================
module hc_sr04_cntr(
    input clk,
    input reset_p,
    input echo,                  // HC-SR04 Echo 입력
    output reg trig,             // HC-SR04 Trig 출력
    output reg [7:0] distance_cm,// 측정된 거리 (cm)
    output [15:0] led            // 디버깅용 LED 출력
);
    // FSM 상태 정의
    localparam S_IDLE   = 4'b0001; // 대기 상태
    localparam S_SEND   = 4'b0010; // Trig 신호 송신
    localparam S_RECIVE = 4'b0100; // Echo 신호 수신
    localparam S_END    = 4'b1000; // 거리 계산
    
    // 1us 단위 클럭 생성
    wire clk_usec_pedge;
    clock_div_100 us_clk(
        .clk(clk),
        .reset_p(reset_p),
        .nedge_div_100(clk_usec_pedge)
    );
    
    reg [21:0] count_usec;    // 마이크로초 카운터
    reg count_usec_e;         // 카운터 enable
    
    // 마이크로초 카운터
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) count_usec <= 0;
        else if(clk_usec_pedge && count_usec_e) count_usec <= count_usec + 1;
        else if(!count_usec_e) count_usec <= 0;
    end
    
    // FSM 상태 레지스터
    reg [3:0] state, next_state;
    reg [21:0] echo_width;    // Echo 신호 폭 저장
    
    assign led[3:0] = state;  // 하위 4비트: 상태 표시
    assign led[15] = echo;    // Echo 입력 상태 표시
    assign led[14] = trig;    // Trig 출력 상태 표시
    
    // 상태 전이
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) state <= S_IDLE;
        else state <= next_state;
    end
    
    // FSM 동작
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            next_state <= S_IDLE;
            trig <= 0;
            count_usec_e <= 0;
            distance_cm <= 0;
        end
        else begin
            case(state)
                S_IDLE: begin
                    trig <= 0;
                    count_usec_e <= 1;
                    if(count_usec > 22'd60_000) begin   // 60ms 대기
                        count_usec_e <= 0;
                        next_state <= S_SEND;
                    end
                end
                S_SEND: begin
                    trig <= 1;
                    count_usec_e <= 1;
                    if(count_usec > 22'd12) begin       // 12us Trig 신호
                        trig <= 0;
                        count_usec_e <= 0;
                        next_state <= S_RECIVE;
                    end
                end
                S_RECIVE: begin
                    if(count_usec > 22'd100_000) begin  // 100ms 타임아웃
                        next_state <= S_IDLE;
                    end
                    if(echo) count_usec_e <= 1;         // Echo 신호 High
                    else if(!echo && count_usec_e) begin// Echo 신호 Low
                        echo_width <= count_usec;
                        count_usec_e <= 0;
                        next_state <= S_END;
                    end 
                end
                S_END: begin
                    // 거리 계산 (cm) : echo_width / 58
                    if(echo_width < 22'd23200)          // 4m 이하만 유효
                        distance_cm <= echo_width / 58;
                    next_state <= S_IDLE;
                end
                default: next_state <= S_IDLE;
            endcase
        end
    end
endmodule



















































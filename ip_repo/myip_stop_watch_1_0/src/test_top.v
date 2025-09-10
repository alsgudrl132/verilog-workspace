`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2025 11:23:59 AM
// Design Name: 
// Module Name: test_top
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


module ring_counter_led_top(
    input clk, reset_p,
    output reg [15:0] led);
    
    reg [20:0] clk_div;
    always @(posedge clk)clk_div = clk_div + 1;
    wire clk_div_18;
    edge_detector_p clk_div_edge(
        .clk(clk), .reset_p(reset_p), .cp(clk_div[18]),
        .p_edge(clk_div_18));
    
    always @(posedge clk or posedge reset_p)begin
        if(reset_p)led = 16'b0000_0000_0000_0001;
        else if(clk_div_18)led = {led[14:0], led[15]};
    end
    
endmodule

module watch(
    input clk, reset_p,
    input btn_mode, inc_sec, inc_min,
    output reg [7:0] sec, min,
    output reg set_watch);

    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            set_watch = 0;
        end
        else if(btn_mode)begin
            set_watch = ~set_watch;
        end
    end

    reg [26:0] cnt_sysclk;
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;
        end
        else begin
            if(set_watch)begin
                if(inc_sec)begin
                    if(sec >= 59)sec = 0;
                    else sec = sec + 1;
                end
                if(inc_min)begin
                    if(min >= 59)min = 0;
                    else min = min + 1;
                end
            end
            else begin
                if(cnt_sysclk >= 27'd99_999_999)begin
                    cnt_sysclk = 0;
                    if(sec >= 59)begin
                        sec = 0;
                        if(min >= 59)min = 0;
                        else min = min + 1;
                    end
                    else sec = sec + 1;
                end
                else cnt_sysclk = cnt_sysclk + 1;
            end
        end
    end

endmodule

module watch_top(
    input clk, reset_p,
    input [2:0] btn,
    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led);
    
    wire btn_mode, inc_sec, inc_min;
    wire [7:0] sec, min;
    wire set_watch;
    wire [15:0] sec_bcd, min_bcd;
    assign led[0] = set_watch;
    btn_cntr mode_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[0]), .btn_pedge(btn_mode));
    btn_cntr inc_sec__btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[1]), .btn_pedge(inc_sec));
    btn_cntr inc_min_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[2]), .btn_pedge(inc_min));
    
    watch watch_instance(.clk(clk), .reset_p(reset_p),
        .btn_mode(btn_mode), .inc_sec(inc_sec), .inc_min(inc_min),
        .sec(sec), .min(min), .set_watch(set_watch));
    
    bin_to_dec bcd_sec(.bin(sec), .bcd(sec_bcd));
    bin_to_dec bcd_min(.bin(min), .bcd(min_bcd));
    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
        .fnd_value({min_bcd[7:0], sec_bcd[7:0]}), .hex_bcd(1),
        .seg_7(seg_7), .com(com));

endmodule

module cook_timer(
    input clk, reset_p,
    input btn_mode, inc_sec, inc_min, alarm_off,
    output reg [7:0] sec, min,
    output reg alarm,
    output reg start_set);

    reg set_flag;
    
    wire [15:0] cur_time = {min, sec};
    reg [7:0] set_sec, set_min;
    reg [26:0] cnt_sysclk = 0;
    
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            start_set = 0;
            alarm = 0;
        end
        else if(btn_mode && cur_time != 0 && start_set == 0)begin
            start_set = 1;
            set_sec = sec;
            set_min = min;
        end
        else if(start_set && btn_mode)begin
            start_set = 0;
        end
        else if(start_set && min == 0 && sec == 0)begin
            start_set = 0;
            alarm = 1;
        end
        else if(alarm && (alarm_off || inc_sec || inc_min || btn_mode))begin
            alarm = 0;
            set_flag = 1;
        end
        else if(cur_time != 0)set_flag = 0;
    end
    
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;        
        end
        else begin
            if(start_set)begin
                if(cnt_sysclk >= 99_999_999)begin
                    cnt_sysclk = 0;
                    if(sec == 0)begin
                        if(min)begin
                            sec = 59;
                            min = min - 1;
                        end
                    end
                    else sec = sec - 1;
                end
                else cnt_sysclk = cnt_sysclk + 1;
            end
            else begin
                if(inc_sec)begin
                    if(sec >= 59) sec = 0;
                    else sec = sec + 1;
                end
                else if(inc_min)begin
                    if(min >= 99)min = 0;
                    else min = min + 1;
                end
                if(set_flag)begin
                    sec = set_sec;
                    min = set_min;
                end
            end
        end
    end


endmodule

module cook_timer_top(
    input clk, reset_p,
    input [3:0] btn,
    output [7:0] seg_7,
    output [3:0] com,
    output alarm,
    output [15:0] led);
    
    wire start_set;
    assign led[0] = start_set;
    assign led[15] = alarm;
    
    wire [7:0] sec, min;
    
    wire btn_mode, inc_sec, inc_min, alarm_off;
    wire [7:0] sec_bcd, min_bcd;    
    
    btn_cntr mode_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[0]), .btn_pedge(btn_mode));
    btn_cntr inc_sec__btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[1]), .btn_pedge(inc_sec));
    btn_cntr inc_min_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[2]), .btn_pedge(inc_min));
    btn_cntr alarm_off_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[3]), .btn_pedge(alarm_off));
    
    cook_timer cook_timer_instance(.clk(clk), .reset_p(reset_p),
        .btn_mode(btn_mode), .inc_sec(inc_sec), 
        .inc_min(inc_min), .alarm_off(alarm_off),
        .sec(sec), .min(min),
        .alarm(alarm), .start_set(start_set));

    bin_to_dec bcd_sec(.bin(sec), .bcd(sec_bcd));
    bin_to_dec bcd_min(.bin(min), .bcd(min_bcd));
    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
        .fnd_value({min_bcd[7:0], sec_bcd[7:0]}), .hex_bcd(1),
        .seg_7(seg_7), .com(com));
    
endmodule

module stop_watch(
    input clk, reset_p,
    input start_stop, lap, clear,            // 제어 레지스터
    output reg [7:0] sec, csec, min, lap_sec, lap_csec, lap_min);     // 데이터 레지스터
    
    wire lap_pedge, clear_pedge;
    edge_detector_p lap_ed(.clk(clk), .reset_p(reset_p),
     .cp(lap), .p_edge(lap_pedge));
     
    edge_detector_p clear_ed(.clk(clk), .reset_p(reset_p),
     .cp(clear), .p_edge(clear_pedge));
    
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            lap_sec = 0;
            lap_csec = 0;
            lap_min = 0;
        end
        else if(lap_pedge)begin
            lap_sec = sec;
            lap_csec = csec;
            lap_min = min;
        end
        else if(clear_pedge)begin
            lap_sec = 0;
            lap_csec = 0;
            lap_min = 0;
        end
    end
    
    reg [26:0] cnt_sysclk;
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            sec = 0;
            csec = 0;
            cnt_sysclk = 0;
        end
        else begin
            if(start_stop)begin
                if(cnt_sysclk >= 999_999)begin
                    cnt_sysclk = 0;
                    if(csec >= 99)begin
                        csec = 0;
                        if(sec >= 59) begin
                            sec = 0;
                            if(min >= 59) begin
                                min = 0;
                            end
                            else min = min + 1;
                        end
                        else sec = sec + 1;
                    end
                    else csec = csec + 1;
                end
                else cnt_sysclk = cnt_sysclk + 1;
            end
            if(clear_pedge)begin
                sec = 0;
                csec = 0;
                cnt_sysclk = 0;
            end
        end
    end
endmodule

module stop_watch_top(
    input clk, reset_p,
    input [2:0] btn,
    output [7:0] seg_7, 
    output [3:0] com,
    output [15:0] led);

    wire btn_start, btn_lap, btn_clear;
    wire [7:0] fnd_sec, fnd_csec;
    wire lap, start_stop;
    assign led[0] = start_stop;
    assign led[1] = lap;
    
    btn_cntr start_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[0]), .btn_pedge(btn_start));
    btn_cntr lap__btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[1]), .btn_pedge(btn_lap));
    btn_cntr clear_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[2]), .btn_pedge(btn_clear));
    
    stop_watch stop_watch_instance(.clk(clk), .reset_p(reset_p),
        .btn_start(btn_start), .btn_lap(btn_lap), .btn_clear(btn_clear),
        .fnd_sec(fnd_sec), .fnd_csec(fnd_csec),
        .lap(lap), .start_stop(start_stop));
            
    wire [7:0] sec_bcd, csec_bcd;
    bin_to_dec bcd_sec(.bin(fnd_sec), .bcd(sec_bcd));
    bin_to_dec bcd_csec(.bin(fnd_csec), .bcd(csec_bcd));
    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
        .fnd_value({sec_bcd, csec_bcd}), .hex_bcd(1),
        .seg_7(seg_7), .com(com));
endmodule

module multifunction_watch_top(
    input clk, reset_p,
    input [3:0] btn,
    input alarm_off,
    output [7:0] seg_7,
    output [3:0] com,
    output alarm,
    output [15:0] led);
    
    localparam WATCH = 0;
    localparam COOK_TIMER = 1;
    localparam STOP_WATCH = 2;
    
    reg [1:0] mode;
    assign led[1:0] = mode;
    assign led[15] = alarm;
    wire btn_mode;
    btn_cntr mode_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[0]), .btn_pedge(btn_mode));
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)mode = WATCH;
        else if(btn_mode)begin
            if(mode == WATCH)      mode = COOK_TIMER;
            else if(mode == COOK_TIMER) mode = STOP_WATCH;
            else if(mode == STOP_WATCH) mode = WATCH;
        end
    end    
    reg [2:0] watch_btn, cook_btn, stop_btn;
    wire [7:0] watch_seg_7, cook_seg_7, stop_seg_7;
    wire [3:0] watch_com, cook_com, stop_com;
    always @(*)begin
        case(mode)
            WATCH:begin
                watch_btn = btn[3:1];
                cook_btn = 0;
                stop_btn = 0;
            end
            COOK_TIMER:begin
                watch_btn = 0;
                cook_btn = btn[3:1];
                stop_btn = 0;
            end
            STOP_WATCH:begin
                watch_btn = 0;
                cook_btn = 0;
                stop_btn = btn[3:1];
            end
        endcase
    end
    
    watch_top watch(.clk(clk), .reset_p(reset_p),
        .btn(watch_btn), .seg_7(watch_seg_7), .com(watch_com));
    
    
    cook_timer_top timer(.clk(clk), .reset_p(reset_p),
        .btn({alarm_off, cook_btn}), .seg_7(cook_seg_7), .com(cook_com), 
        .alarm(alarm));
    
    stop_watch_top stop(.clk(clk), .reset_p(reset_p),
        .btn(stop_btn), .seg_7(stop_seg_7), .com(stop_com));
        
    assign seg_7 = mode == WATCH ? watch_seg_7 :
                   mode == COOK_TIMER ? cook_seg_7 :
                   mode == STOP_WATCH ? stop_seg_7 :  watch_seg_7;             
    assign com = mode == WATCH ? watch_com :
                   mode == COOK_TIMER ? cook_com :
                   mode == STOP_WATCH ? stop_com :  watch_com; 

endmodule

module multifunction_watch_top_v2(
    input clk, reset_p,
    input [3:0] btn,
    input alarm_off,
    output [7:0] seg_7,
    output [3:0] com,
    output alarm,
    output [15:0] led);
    
    localparam WATCH = 0;
    localparam COOK_TIMER = 1;
    localparam STOP_WATCH = 2;
    
    reg [1:0] mode;
    assign led[1:0] = mode;
    assign led[15] = alarm;
    wire btn_mode;
    btn_cntr mode_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[0]), .btn_pedge(btn_mode));
    
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)mode = WATCH;
        else if(btn_mode)begin
            if(mode == WATCH)      mode = COOK_TIMER;
            else if(mode == COOK_TIMER) mode = STOP_WATCH;
            else if(mode == STOP_WATCH) mode = WATCH;
        end
    end
    wire [2:0] debounced_btn_pedge; 
    btn_cntr mode_btn1(
        .clk(clk), .reset_p(reset_p), .btn(btn[1]), .btn_pedge(debounced_btn_pedge[0]));
    btn_cntr mode_btn2(
        .clk(clk), .reset_p(reset_p), .btn(btn[2]), .btn_pedge(debounced_btn_pedge[1]));
    btn_cntr mode_btn3(
        .clk(clk), .reset_p(reset_p), .btn(btn[3]), .btn_pedge(debounced_btn_pedge[2]));    
    
    reg [2:0] watch_btn, cook_btn, stop_btn;
    always @(*)begin
        case(mode)
            WATCH:begin
                watch_btn = debounced_btn_pedge;
                cook_btn = 0;
                stop_btn = 0;
            end
            COOK_TIMER:begin
                watch_btn = 0;
                cook_btn = debounced_btn_pedge;
                stop_btn = 0;
            end
            STOP_WATCH:begin
                watch_btn = 0;
                cook_btn = 0;
                stop_btn = debounced_btn_pedge;
            end
        endcase
    end
    wire [7:0] watch_sec, watch_min, cook_sec, cook_min, stop_sec, stop_csec;
    wire set_watch;
    assign led[4] = set_watch;
    watch watch_instance(.clk(clk), .reset_p(reset_p),
        .btn_mode(watch_btn[0]), .inc_sec(watch_btn[1]), .inc_min(watch_btn[2]),
        .sec(watch_sec), .min(watch_min), .set_watch(set_watch));
    wire start_set;
    assign led[6] = start_set;
    cook_timer cook_timer_instance(.clk(clk), .reset_p(reset_p),
        .btn_mode(cook_btn[0]), .inc_sec(cook_btn[1]), 
        .inc_min(cook_btn[2]), .alarm_off(alarm_off),
        .sec(cook_sec), .min(cook_min),
        .alarm(alarm), .start_set(start_set));
    wire lap, start_stop;
    assign led[8] = start_stop;
    assign led[9] = lap;    
    stop_watch stop_watch_instance(.clk(clk), .reset_p(reset_p),
        .btn_start(stop_btn[0]), .btn_lap(stop_btn[1]), .btn_clear(stop_btn[2]),
        .fnd_sec(stop_sec), .fnd_csec(stop_csec),
        .lap(lap), .start_stop(start_stop));
    
    wire [7:0] bin_low, bin_high;
    wire [7:0] fnd_value_low, fnd_value_high;
    wire [15:0]fnd_value = {fnd_value_high, fnd_value_low}; 
    assign bin_low = mode == WATCH ? watch_sec :
                   mode == COOK_TIMER ? cook_sec :
                   mode == STOP_WATCH ? stop_csec :  watch_sec;             
    assign bin_high = mode == WATCH ? watch_min :
                   mode == COOK_TIMER ? cook_min :
                   mode == STOP_WATCH ? stop_sec :  watch_min;
    
    bin_to_dec bcd_low(.bin(bin_low), .bcd(fnd_value_low));
    bin_to_dec bcd_high(.bin(bin_high), .bcd(fnd_value_high));   
    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
        .fnd_value(fnd_value),
        .hex_bcd(1),
        .seg_7(seg_7), .com(com));

endmodule

module dht11_top(
    input clk, reset_p,
    inout dht11_data,
    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led
);

    wire [7:0] humidity, temperature;

    dht11_cntr dht11(
        clk, reset_p,
        dht11_data,                        
        humidity, temperature , led                       
    );
    
    wire [7:0] humi_bcd, tmpr_bcd;
    
    bin_to_dec bcd_humi(.bin(humidity), .bcd(humi_bcd));
    bin_to_dec bcd_tmpr(.bin(temperature), .bcd(tmpr_bcd));   
    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
        .fnd_value({humi_bcd, tmpr_bcd}),
        .hex_bcd(1),
        .seg_7(seg_7), .com(com));
    

endmodule


// ============================================
// HC-SR04 Top 모듈 (FND 출력용)
// ============================================
module hc_sr04_top(
    input clk,
    input reset_p,
    input echo,
    output trig,
    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led
);

    wire [7:0] distance_cm;
    hc_sr04_cntr hcsr04(
        .clk(clk),
        .reset_p(reset_p),
        .echo(echo),
        .trig(trig),
        .distance_cm(distance_cm),
        .led(led)
    );
    
    wire [15:0] distance_bcd;
    bin_to_dec bcd_ultra_sonic(
        .bin({4'b0000, distance_cm}),
        .bcd(distance_bcd)           
    );
    
    fnd_cntr fnd(
        .clk(clk),
        .reset_p(reset_p),
        .fnd_value(distance_bcd), 
        .hex_bcd(1),
        .seg_7(seg_7),
        .com(com)
    );

endmodule

module keypad_top(
    input clk, reset_p,
    input [3:0] row,
    output [3:0] column,
    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led);

    wire [3:0] key_value;
    wire key_valid;
    assign led[0] = key_valid;
    keypad_cntr key_pad(clk, reset_p, row, column, key_value, key_valid);
    
    fnd_cntr fnd(
        .clk(clk),
        .reset_p(reset_p),
        .fnd_value(key_value), 
        .hex_bcd(1),
        .seg_7(seg_7),
        .com(com)
    );
    
endmodule

module i2c_txtlcd_top(
    input clk, reset_p,        // 시스템 클럭, 리셋
    input [3:0] btn,           // 버튼 입력 (4개)
    input [3:0] row,           // 키패드 row
    output[3:0] column,        // 키패드 column
    output scl, sda,           // I2C 신호
    output [15:0] led);        // 상태 확인용 LED

    // 버튼의 상승엣지 검출
    wire [3:0] btn_pedge;
    btn_cntr btn0(clk, reset_p, btn[0], btn_pedge[0]);
    btn_cntr btn1(clk, reset_p, btn[1], btn_pedge[1]);
    btn_cntr btn2(clk, reset_p, btn[2], btn_pedge[2]);
    btn_cntr btn3(clk, reset_p, btn[3], btn_pedge[3]);
    
    // LCD 초기화를 위한 지연 카운터
    integer cnt_sysclk;
    reg count_clk_e;
    always @(negedge clk, posedge reset_p) begin
        if(reset_p) cnt_sysclk = 0;
        else if(count_clk_e) cnt_sysclk = cnt_sysclk + 1;
        else cnt_sysclk = 0;
    end
    
    // I2C LCD 전송용 신호
    reg [7:0] send_buffer;   // 보낼 데이터
    reg send, rs;            // send: 송신 트리거, rs: 명령/데이터 선택
    wire busy;               // I2C 동작중 여부

    // LCD로 바이트 단위 송신
    i2c_lcd_send_byte send_byte(
        clk, reset_p, 7'h27, send_buffer, send, rs, 
        scl, sda, busy, led
    );

    // 키패드 제어
    wire [3:0] key_value;   // 입력된 키 값
    wire key_valid;         // 키 입력 유효 여부
    keypad_cntr keypad(clk, reset_p, row, column, key_value, key_valid);
    
    assign led[15] = key_valid;   // 키 유효 여부 LED 표시
    assign led[3:0] = row;        // 디버깅용 row 출력
    
    // 키 유효 신호의 상승엣지 검출
    wire key_valid_pedge;
    edge_detector_p key_valid_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(key_valid),
        .p_edge(key_valid_pedge));
    
    // FSM 상태 정의
    localparam IDLE                 = 6'b00_0001;
    localparam INIT                 = 6'b00_0010;
    localparam SEND_CHARACTER       = 6'b00_0100;
    localparam SHIFT_RIGHT_DISPLAY  = 6'b00_1000;
    localparam SHIFT_LEFT_DISPLAY   = 6'b01_0000;
    localparam SEND_KEY             = 6'b10_0000;

    // 현재 상태, 다음 상태
    reg [5:0] state, next_state;
    always @(negedge clk, posedge reset_p) begin
        if(reset_p) state = IDLE;
        else state = next_state;
    end
    
    // LCD 초기화 및 데이터 송신 관리
    reg init_flag;          // 초기화 완료 여부
    reg [10:0] cnt_data;    // 전송 데이터 인덱스
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            next_state = IDLE;
            init_flag = 0;
            count_clk_e = 0;
            send = 0;
            send_buffer = 0;
            rs = 0;
            cnt_data = 0;
        end
        else begin
            case(state)
                // 대기 상태
                IDLE: begin
                    if(init_flag) begin
                        // 버튼/키 입력에 따라 상태 전환
                        if(btn_pedge[0]) next_state = SEND_CHARACTER;
                        if(btn_pedge[1]) next_state = SHIFT_RIGHT_DISPLAY;
                        if(btn_pedge[2]) next_state = SHIFT_LEFT_DISPLAY;
                        if(key_valid_pedge) next_state = SEND_KEY;
                    end
                    else begin
                        // 전원 인가 후 LCD 초기화 지연
                        if(cnt_sysclk <= 32'd80_000_00) begin
                            count_clk_e = 1;
                        end
                        else begin
                            next_state = INIT;
                            count_clk_e = 0;
                        end
                    end
                end

                // LCD 초기화 (데이터시트에 따른 시퀀스)
                INIT: begin
                    if(busy) begin
                        send = 0;
                        if(cnt_data >= 6) begin
                            cnt_data = 0;
                            next_state = IDLE;
                            init_flag = 1; // 초기화 완료
                        end
                    end
                    else if(!send) begin
                        case(cnt_data)
                            0:send_buffer = 8'h33;
                            1:send_buffer = 8'h32;
                            2:send_buffer = 8'h28;
                            3:send_buffer = 8'h0c;
                            4:send_buffer = 8'h01;
                            5:send_buffer = 8'h06;
                        endcase
                        send = 1;
                        cnt_data = cnt_data + 1;
                    end
                end

                // 버튼0: "a~z" 순서 출력
                SEND_CHARACTER: begin
                    if(busy) begin
                        next_state = IDLE;
                        send = 0;
                        if(cnt_data >= 25) cnt_data = 0;
                        cnt_data = cnt_data + 1;
                    end
                    else begin
                        rs = 1;  // 데이터 모드
                        send_buffer = "a" + cnt_data;
                        send = 1;
                    end
                end

                // 버튼1: 화면 오른쪽 이동
                SHIFT_RIGHT_DISPLAY: begin
                    if(busy) begin
                        next_state = IDLE;
                        send = 0;
                    end
                    else begin
                        rs = 0;          // 명령 모드
                        send_buffer = 8'h1c;
                        send = 1;
                    end
                end

                // 버튼2: 화면 왼쪽 이동
                SHIFT_LEFT_DISPLAY: begin
                    if(busy) begin
                        next_state = IDLE;
                        send = 0;
                    end
                    else begin
                        rs = 0;
                        send_buffer = 8'h18;
                        send = 1;
                    end
                end

                // 키패드 입력된 값을 LCD에 표시
                SEND_KEY: begin
                    if(busy) begin
                        next_state = IDLE;
                        send = 0;
                    end
                    else begin
                        rs = 1;
                        if(key_value < 10) send_buffer = "0" + key_value;  // 숫자
                        else if(key_value == 10) send_buffer = "+";
                        else if(key_value == 11) send_buffer = "-";
                        else if(key_value == 12) send_buffer = "C";
                        else if(key_value == 13) send_buffer = "/";
                        else if(key_value == 14) send_buffer = "*";
                        else if(key_value == 15) send_buffer = "=";
                        send = 1;
                    end
                end
            endcase
        end
    end
endmodule

module led_pwm_top(
    input clk, reset_p,
    output led_r, led_g, led_b,
    output [15:0] led);

    integer cnt;
    always @(posedge clk)cnt = cnt + 1;
    
    pwm_Nfreq_Nstep #(.duty_step_N(200)) pwm_led_r(clk, reset_p, cnt[27:20], led_r);
    pwm_Nfreq_Nstep #(.duty_step_N(100)) pwm_led_g(clk, reset_p, cnt[28:21], led_g);
    pwm_Nfreq_Nstep #(.duty_step_N(100)) pwm_led_b(clk, reset_p, cnt[29:22], led_b);
    
    
endmodule

module sg90_top(
    input clk,          // 시스템 클럭 입력 (예: 100MHz)
    input reset_p,      // 비동기 리셋 신호, 1로 들어오면 초기화
    output sg90         // SG90 서보 모터 PWM 출력
);

    // step: 서보 위치를 나타내는 값
    // cnt: 펄스 생성용 카운터
    integer step, cnt;

    // 1클럭마다 cnt 증가
    always @(posedge clk)
        cnt = cnt + 1;

    // cnt[22]의 상승 에지 검출용
    wire cnt_pedge;
    edge_detector_p echo_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(cnt[22]),     // cnt[22] 신호를 카운트 기준으로 사용
        .p_edge(cnt_pedge) // cnt[22] 상승 에지 발생 시 1
    );
    
    // inc_flag: step 증가/감소 방향 결정
    reg inc_flag;

    // step 값 업데이트
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            step = 16;       // 초기 step 값 (서보 PWM 최소 위치)
            inc_flag = 1;    // 처음에는 증가 방향
        end
        else if(cnt_pedge) begin //  cnt[22] 상승 에지마다 실행
            if(inc_flag) begin
                if(step >= 18) // 최대값 도달 시 감소 방향으로 변경
                    inc_flag = 0;
                else
                    step = step + 1; // 1 step 증가
            end
            else begin
                if(step <= 189) // 최소값 도달 시 증가 방향으로 변경
                    inc_flag = 1;
                else
                    step = step - 1; // 1 step 감소
            end
        end
    end

    // PWM 생성 모듈 인스턴스
    pwm_Nfreq_Nstep #(
        .pwm_freq(50),       // SG90 서보 기준 PWM 주파수 50Hz
        .duty_step_N(1440)   // step 최대값 설정 (PWM 분해능)
    ) pwm_sg90(
        clk, reset_p, step, sg90  // step 값으로 PWM duty 결정
    );    

endmodule

module adc_top_6(
    input clk, reset_p,           // clk: 시스템 클럭, reset_p: 비동기 리셋(High일 때 리셋)
    input vauxp6, vauxn6,         // XADC 보드의 아날로그 입력 (채널 6의 차동 입력 핀)
    output [7:0] seg_7,           // 7세그먼트 LED segment 출력 (a~g + dp)
    output [3:0] com,             // 7세그먼트 자릿수 선택 출력
    output [15:0] led);           // 디버깅용 LED 출력 (필요 시 표시용)

    // XADC 관련 신호선
    wire [4:0] channel_out;       // 변환된 채널 번호 출력
    wire eoc_out;                 // End Of Conversion (변환 완료 신호)
    wire [15:0] do_out;           // 변환된 ADC 결과 (16비트 데이터 버스)
    
    // Xilinx XADC Wizard IP 인스턴스
    xadc_wiz_0 adc
          (
          .daddr_in({2'b00,channel_out}),  // DRP 주소 입력 (채널 지정)
          .dclk_in(clk),                   // DRP 클럭 입력 (시스템 클럭 사용)
          .den_in(eoc_out),                // DRP enable → 변환 완료될 때 데이터 읽음
          .reset_in(reset_p),              // 리셋 입력
          .vauxp6(vauxp6), .vauxn6(vauxn6),// 아날로그 입력 (채널 6 사용)
          .channel_out(channel_out),       // 현재 변환 중인 채널 출력
          .do_out(do_out),                 // 변환 결과 데이터 출력
          .eoc_out(eoc_out)                // 변환 완료 신호 출력
          );
          
    // 변환된 ADC 값 저장 레지스터 (12비트만 사용)
    reg [11:0] adc_value;
    
    // eoc_out의 양엣지 검출기
    wire eoc_pedge;
    edge_detector_p echo_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(eoc_out),        // 입력: eoc_out 신호
        .p_edge(eoc_pedge)); // 출력: eoc_out의 양엣지 발생 시 1 클럭 동안 High
    
    // ADC 값 저장 로직
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) 
            adc_value = 0;               // 리셋 시 값 초기화
        else if(eoc_pedge) 
            adc_value = do_out[15:8];    // 변환 완료 시 상위 12비트만 adc_value에 저장
    end
    
    // FND(7세그먼트) 표시 모듈
    fnd_cntr fnd(
        .clk(clk), 
        .reset_p(reset_p),
        .fnd_value(adc_value), // 입력값: ADC 변환 결과
        .hex_bcd(0),           // 0=HEX 그대로 표시, 1=BCD 변환해서 표시
        .seg_7(seg_7), 
        .com(com));

endmodule

module adc_sequence2_top(
    input clk, reset_p,       // 시스템 클럭, 리셋 입력
    input vauxp6,             // X축 입력 채널 (ADC 보조 채널 6, +단)
    input vauxn6,             // X축 입력 채널 (ADC 보조 채널 6, -단)
    input vauxp14,            // Y축 입력 채널 (ADC 보조 채널 14, +단)
    input vauxn14,            // Y축 입력 채널 (ADC 보조 채널 14, -단)
    output [7:0] seg_7,       // 7-세그먼트 데이터 출력
    output [3:0] com,         // 7-세그먼트 공통 신호
    output led_g, led_b,
    output [15:0] led         // 디버깅용 LED 출력 (현재 사용 X)
);

    // XADC IP에서 나오는 신호들
    wire [4:0] channel_out;   // 현재 변환된 채널 번호
    wire [15:0] do_out;       // ADC 변환 데이터 (16비트 중 상위 12비트 사용)
    wire eoc_out;             // 변환 완료 신호 (End Of Conversion)

    // XADC IP 인스턴스
    xadc_joystic joystick
          (
          .daddr_in({2'b00, channel_out}),  // 동적 재구성 포트 주소 (현재 채널 기반)
          .dclk_in(clk),                    // 동적 포트 클럭
          .den_in(eoc_out),                 // 변환 완료 시 enable
          .reset_in(reset_p),               // 리셋 입력
          .vauxp6(vauxp6), .vauxn6(vauxn6), // X축 채널 (VAUX6)
          .vauxp14(vauxp14), .vauxn14(vauxn14), // Y축 채널 (VAUX14)
          .channel_out(channel_out),        // 변환된 채널 번호 출력
          .do_out(do_out),                  // 변환된 데이터 출력
          .eoc_out(eoc_out)                 // 변환 완료 신호 출력
          );
          
    // 변환된 ADC 값 저장 (X, Y 각각 12비트 사용)
    reg [11:0] adc_value_x, adc_value_y;
    
    // eoc_out의 양엣지 검출기 → 변환 완료 시점 검출
    wire eoc_pedge;
    edge_detector_p echo_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(eoc_out),        
        .p_edge(eoc_pedge)); // eoc_out의 rising edge에서 1클럭 동안 High
    
    // ADC 값 저장 로직
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            adc_value_x = 0;   // 리셋 시 초기화
            adc_value_y = 0;
        end
        else if(eoc_pedge) begin
            case(channel_out[3:0])        // 채널 번호 확인
                6:  adc_value_x = do_out[15:4]; // X축 값 저장 (상위 12비트)
                14: adc_value_y = do_out[15:4]; // Y축 값 저장 (상위 12비트)
            endcase
        end
    end
    
    // X, Y 값을 BCD 변환 (상위 6비트만 사용 → 0~63 범위)
    wire [7:0] x_bcd, y_bcd;
    bin_to_dec bcd_x(.bin(adc_value_x[11:6]), .bcd(x_bcd));
    bin_to_dec bcd_y(.bin(adc_value_y[11:6]), .bcd(y_bcd));
    
    // 7-Segment 표시 모듈
    // X값과 Y값을 합쳐서 표시 (예: {X, Y} 형태 → 16비트 입력)
    fnd_cntr fnd_x(
        .clk(clk), 
        .reset_p(reset_p),
        .fnd_value({x_bcd,y_bcd}), // 상위 8비트=Y, 하위 8비트=X
        .hex_bcd(1),               // 0=HEX 그대로, 1=BCD 변환된 값 사용
        .seg_7(seg_7), 
        .com(com));
    
    pwm_Nfreq_Nstep #(.duty_step_N(128)) pwm_led_g(clk, reset_p, adc_value_x[11:4], led_g);
    pwm_Nfreq_Nstep #(.duty_step_N(128)) pwm_led_b(clk, reset_p, adc_value_y[11:4], led_b);

endmodule







`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2025 09:23:49 AM
// Design Name: 
// Module Name: stop_watch
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


// 100MHz 클럭을 10Hz로 분주
module clock_divider_10Hz(
    input clk,
    input reset_p,
    output reg clk_10Hz
);
    reg [23:0] count;

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            count <= 0;
            clk_10Hz <= 0;
        end else begin
            if(count == 24'd499_999) begin // 10Hz 기준 (100MHz / 2 / 10)
                count <= 0;
                clk_10Hz <= ~clk_10Hz; // 토글
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule

// 스톱워치 카운터 (초/분 단위, 상태 전이 포함)
module stopwatch_counter (
    input clk_10Hz,                 // 10Hz 클럭 입력
    input reset_p,                 // 리셋 입력
    input btn_start_stop,         // 시작/정지 버튼
    input btn_reset,              // 리셋 버튼
    output reg [3:0] sec_ones,    // 초 1의 자리
    output reg [3:0] sec_tens,    // 초 10의 자리
    output reg [3:0] min_ones,    // 분 1의 자리
    output reg [3:0] min_tens,     // 분 10의 자리
    output reg [3:0] signal
);
    // 상태 정의
    parameter IDEL    = 2'b00;
    parameter RUNNING = 2'b01;
    parameter PAUSED  = 2'b10;
    
    reg [1:0] current_state, next_state;

    // 상태 레지스터
    always @(posedge clk_10Hz or posedge reset_p) begin
        if(reset_p)
            current_state <= IDEL;
        else
            current_state <= next_state;
    end

    // 상태 전이 로직
    always @(*) begin
        case (current_state)
            IDEL:
                next_state = btn_start_stop ? RUNNING : IDEL;
            RUNNING:
                next_state = btn_start_stop ? PAUSED : RUNNING;
            PAUSED:
                next_state = btn_reset ? IDEL :
                             btn_start_stop ? RUNNING : PAUSED;
            default:
                next_state = IDEL;
        endcase
    end

    // 카운터 동작
    always @(posedge clk_10Hz or posedge reset_p) begin
        if(reset_p || current_state == IDEL) begin
            sec_ones <= 0;
            sec_tens <= 0;
            min_ones <= 0;
            min_tens <= 0;
        end else if(current_state == RUNNING) begin
            if(sec_ones == 9) begin
                sec_ones <= 0;
                if(sec_tens == 9) begin
                    sec_tens <= 0;
                    if(min_ones == 9) begin
                        min_ones <= 0;
                        if(min_tens == 5) begin 
                            min_tens <= 0;
                            signal <= signal + 1;
                        end                            
                        else
                            min_tens <= min_tens + 1;
                    end else begin
                        min_ones <= min_ones + 1;
                    end
                end else begin
                    sec_tens <= sec_tens + 1;
                end
            end else begin
                sec_ones <= sec_ones + 1;
            end
        end
    end
endmodule

// 버튼 디바운싱 모듈
module debounce (
    input clk,
    input btn_in,
    output reg btn_out
);
    reg [15:0] count;
    reg btn_sync_0, btn_sync_1;
    wire stable = (count == 16'hFFFF);

    // 두 번 동기화 (메타스테이블 방지)
    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;
    end

    // 안정 신호 카운팅
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

// 100MHz → 2KHz 분주 (세그먼트 스캔용)
module clock_divider_2KHz (
    input clk,
    input reset_p,
    output reg clk_2KHz
);
    reg [15:0] count;

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            count <= 0;
            clk_2KHz <= 0;
        end else begin
            if (count == 24_999) begin // 2KHz 기준
                count <= 0;
                clk_2KHz <= ~clk_2KHz;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule

// 스캔할 자릿수 결정 및 현재 숫자 전달
module display_scan_controller (
    input scan_clk,
    input reset_p,
    input [3:0] sec_ones,
    input [3:0] sec_tens,
    input [3:0] min_ones,
    input [3:0] min_tens,
    output reg [1:0] scan_count,
    output reg [3:0] select_digit
);
    always @(posedge scan_clk or posedge reset_p) begin
        if (reset_p)
            scan_count <= 0;
        else
            scan_count <= scan_count + 1;
    end

    always @(*) begin
        case (scan_count)
            2'd0: select_digit = sec_ones;
            2'd1: select_digit = sec_tens;
            2'd2: select_digit = min_ones;
            2'd3: select_digit = min_tens;
            default: select_digit = 0;
        endcase
    end
endmodule

// BCD to 7세그먼트 디코더 (공통 애노드용)
module seg_decoder (
    input [3:0] digit_in,
    output reg [7:0] seg_out
);
    always @(*) begin
        case (digit_in)
            4'd0 : seg_out = 8'b1100_0000;
            4'd1 : seg_out = 8'b1111_1001;
            4'd2 : seg_out = 8'b1010_0100;
            4'd3 : seg_out = 8'b1011_0000;
            4'd4 : seg_out = 8'b1001_1001;
            4'd5 : seg_out = 8'b1001_0010;
            4'd6 : seg_out = 8'b1000_0010;
            4'd7 : seg_out = 8'b1111_1000;
            4'd8 : seg_out = 8'b1000_0000;
            4'd9 : seg_out = 8'b1001_0000;
            default : seg_out = 8'b1111_1111;
        endcase
    end
endmodule

// 애노드 선택 (공통 애노드 방식)
module anode_selector (
    input [1:0] scan_count,
    output reg [3:0] an_out
);
    always @(*) begin
        case (scan_count)
            2'd0 : an_out = 4'b1110; // 첫 번째 자리
            2'd1 : an_out = 4'b1101; // 두 번째 자리
            2'd2 : an_out = 4'b1011; // 세 번째 자리
            2'd3 : an_out = 4'b0111; // 네 번째 자리
            default : an_out = 4'b1111;
        endcase
    end
endmodule

module led (
    input [3:0] signal,
    output reg [15:0] led
);
    always @(*) begin
        case(signal)
            4'd0:  led = 16'b0000_0000_0000_0001;  // 0초
            4'd1:  led = 16'b0000_0000_0000_0011;  // 1초
            4'd2:  led = 16'b0000_0000_0000_0111;  // 2초
            4'd3:  led = 16'b0000_0000_0000_1111;  // 3초
            4'd4:  led = 16'b0000_0000_0001_1111;  // 4초
            4'd5:  led = 16'b0000_0000_0011_1111;  // 5초
            4'd6:  led = 16'b0000_0000_0111_1111;  // 6초
            4'd7:  led = 16'b0000_0000_1111_1111;  // 7초
            4'd8:  led = 16'b0000_0001_1111_1111;  // 8초
            4'd9:  led = 16'b0000_0011_1111_1111;  // 9초
            4'd10: led = 16'b0000_0111_1111_1111;  // 10초
            4'd11: led = 16'b0000_1111_1111_1111;  // 11초
            4'd12: led = 16'b0001_1111_1111_1111;  // 12초
            4'd13: led = 16'b0011_1111_1111_1111;  // 13초
            4'd14: led = 16'b0111_1111_1111_1111;  // 14초
            4'd15: led = 16'b1111_1111_1111_1111;  // 15초
            default: led = 16'b1111_1111_1111_1111;
        endcase
    end
endmodule

// 스톱워치 최상위 모듈
module stop_watch_top (
    input clk,                     // 100MHz 클럭
    input reset_p,                 // 리셋 스위치
    input btn_start_stop,          // 시작/정지 버튼
    input btn_reset,               // 리셋 버튼
    output [7:0] seg,              // 7세그먼트 세그먼트 출력
    output [3:0] an,                // 애노드 제어 출력
    output [15:0] led
);
    // 내부 연결용 와이어
    wire clk_10Hz;
    wire scan_clk_2KHz;
    wire [3:0] sec_ones_out, sec_tens_out;
    wire [3:0] min_ones_out, min_tens_out;
    wire [1:0] scan_count_out;
    wire [3:0] select_digit;
    wire clean_btn_start_stop, clean_btn_reset;
    wire signal_led;

    // 분주기: 10Hz
    clock_divider_10Hz u1(.clk(clk), .reset_p(reset_p), .clk_10Hz(clk_10Hz));
    
    // 버튼 디바운싱
    debounce u2(.clk(clk), .btn_in(btn_start_stop), .btn_out(clean_btn_start_stop));
    debounce u3(.clk(clk), .btn_in(btn_reset), .btn_out(clean_btn_reset));
    
    // 스톱워치 카운터
    stopwatch_counter u4(
        .clk_10Hz(clk_10Hz),
        .reset_p(reset_p),
        .btn_start_stop(clean_btn_start_stop),
        .btn_reset(clean_btn_reset),
        .sec_ones(sec_ones_out),
        .sec_tens(sec_tens_out),
        .min_ones(min_ones_out),
        .min_tens(min_tens_out),
        .signal(signal_led)
    );

    // 분주기: 2KHz
    clock_divider_2KHz u5(.clk(clk), .reset_p(reset_p), .clk_2KHz(scan_clk_2KHz));
    
    // 디스플레이 스캔
    display_scan_controller u6(
        .scan_clk(scan_clk_2KHz),
        .reset_p(reset_p),
        .sec_ones(sec_ones_out),
        .sec_tens(sec_tens_out),
        .min_ones(min_ones_out),
        .min_tens(min_tens_out),
        .scan_count(scan_count_out),
        .select_digit(select_digit)
    );
         // 7세그먼트 디코더
    seg_decoder u7(.digit_in(select_digit), .seg_out(seg));

    // 애노드 선택
    anode_selector u8(.scan_count(scan_count_out), .an_out(an));

   
    led u9(
        .signal(signal_led),
        .led(led)
    ); endmodule

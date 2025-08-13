`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2025 11:24:01 AM
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
    input clk, reset_p,         // 입력 클록, 리셋
    output reg [15:0] led       // 16개 LED 출력
);
    reg [20:0] clk_div;         // 클록 분주용 레지스터
    always @(posedge clk)clk_div = clk_div + 1;  // 매 클록 상승 에지마다 1씩 증가 → 비트가 올라가며 속도 느려짐
    wire clk_div_18; 

    edge_detector_p clk_div_edge(
        .clk(clk),
        .reset_p(reset_p),
        .cp(clk_div[18]),
        .p_edge(clk_div_18)
        
    );
    
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) 
            led = 16'b0000_0000_0000_0001;  // 초기 LED 상태
        else if(clk_div_18) led = {led[14:0], led[15]};     // 링 카운터: 왼쪽 시프트 후 순환
    end

endmodule



module seg_decoder (
    input [3:0] digit_in,
    output reg [7:0] seg_out
);
    always @(*) begin
        case (digit_in)
                             //pgfe_dcba
            4'd0: seg_out = 8'b1100_0000;   // 0 (dp 꺼짐)
            4'd1: seg_out = 8'b1111_1001; // 1
            4'd2: seg_out = 8'b1010_0100; // 2
            4'd3: seg_out = 8'b1011_0000; // 3
            4'd4: seg_out = 8'b1001_1001; // 4
            4'd5: seg_out = 8'b1001_0010; // 5
            4'd6: seg_out = 8'b1000_0010; // 6
            4'd7: seg_out = 8'b1111_1000; // 7
            4'd8: seg_out = 8'b1000_0000; // 8
            4'd9: seg_out = 8'b1001_0000; // 9
            4'hA: seg_out = 8'b1000_1000; // A
            4'hb: seg_out = 8'b0000_0011; // b
            4'hC: seg_out = 8'b1100_0110; // C
            4'hd: seg_out = 8'b1010_0001; // D
            4'hE: seg_out = 8'b1000_0110; // E
            4'hF: seg_out = 8'b1000_1110; // F
            default: seg_out = 8'b1111_1111;
        endcase
    end
endmodule

module anode_selector (
    input [1:0] scan_count,
    output reg [3:0] an_out
);
    always @(*) begin
        case (scan_count)
            2'd0: an_out = 4'b1110; // an[0]
            2'd1: an_out = 4'b1101; // an[1]
            2'd2: an_out = 4'b1011; // an[2]
            2'd3: an_out = 4'b0111; // an[3]
            default: an_out = 4'b1111;
        endcase
    end
endmodule

module watch_top(
    input clk, reset_p,
    input [2:0] btn,
    output [7:0]seg_7,
    output [3:0]com,
    output [15:0] led
);
    wire btn_mode, inc_sec, inc_min;
    
    btn_cntr mode_btn(.clk(clk), .reset_p(reset_p),.btn(btn[0]), .btn_pedge(btn_mode));
    btn_cntr inc_sec_btn(.clk(clk), .reset_p(reset_p),.btn(btn[1]), .btn_pedge(inc_sec));
    btn_cntr inc_min_btn(.clk(clk), .reset_p(reset_p),.btn(btn[2]), .btn_pedge(inc_min));

    reg set_watch;
    assign led[0] = set_watch;
    
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            set_watch = 0; 
        end
        else if(btn_mode)begin
            set_watch = ~set_watch;
        end
    end
    
    reg [26:0] cnt_sysclk;
    reg [7:0] sec, min;
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;
        end
        else begin
            if(set_watch) begin
                if(inc_sec)begin
                    if(sec >= 59) sec = 0;
                    else sec = sec + 1;
                end
                if(inc_min)begin
                    if(min >= 59) min = 0;
                    else min = min + 1;
                end
            end
            else begin
                if(cnt_sysclk >= 27'd99_999_999) begin
                cnt_sysclk = 0;
                if(sec >= 59) begin
                    sec = 0;
                    if(min >= 59) min = 0;
                    else min = min + 1;
                end
                    else sec = sec + 1;
                end
                else cnt_sysclk = cnt_sysclk + 1;
            end
        end
    end
    wire [15:0] sec_bcd, min_bcd;
    bin_to_dec bcd_sec( .bin(sec), .bcd(sec_bcd));
    bin_to_dec bcd_min( .bin(min), .bcd(min_bcd));
    
    fnd_cntr fnd(
        .clk(clk),
        .reset_p(reset_p),
        .fnd_value({min_bcd[7:0], sec_bcd[7:0]}),
        .hex_bcd(1),
        .seg_7(seg_7),
        .com(com)
    );

endmodule

module cook_timer(
    input clk, reset_p,
    input [3:0] btn,
    output [7:0] seg_7,
    output [3:0] com,
    output reg alarm,
    output [14:0] led);

    wire btn_mode, inc_sec, inc_min, alarm_off;
    wire [15:0] cur_time = {min, sec};
    reg start_set;
    reg [7:0] set_sec, set_min;
    reg [26:0] cnt_sysclk;
    reg [7:0] sec, min;
    wire [7:0] sec_bcd, min_bcd;
    reg set_flag;

    
    btn_cntr mode_btn(.clk(clk), .reset_p(reset_p),.btn(btn[0]), .btn_pedge(btn_mode));
    btn_cntr inc_sec_btn(.clk(clk), .reset_p(reset_p),.btn(btn[1]), .btn_pedge(inc_sec));
    btn_cntr inc_min_btn(.clk(clk), .reset_p(reset_p),.btn(btn[2]), .btn_pedge(inc_min));
    btn_cntr alarm_off_btn(.clk(clk), .reset_p(reset_p),.btn(btn[3]), .btn_pedge(alarm_off));

    
    assign led[0] = start_set;
    
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            start_set = 0;
            alarm = 0;
        end
        else if(btn_mode && cur_time != 0 && start_set == 0) begin
            start_set = 1;
            set_sec = sec;
            set_min = min;
        end
        else if(start_set && btn_mode)start_set = 0;
        else if(start_set && min == 0 && sec == 0) begin
            start_set = 0;
            alarm = 1;
        end
        else if(alarm && (alarm_off || inc_sec || inc_min)) begin 
            alarm = 0;
            set_flag = 1;
        end
        else if(cur_time != 0) set_flag = 0;
    end
    

    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;
        end
        else begin
            if(start_set)begin
                if(cnt_sysclk >= 99_999_999) begin
                    cnt_sysclk = 0;
                    if(sec == 0) begin
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
                if(inc_sec) begin
                    if(sec >= 59) sec = 0;
                    else sec = sec + 1;
                end
                else if(inc_min) begin
                    if(min >= 99) min = 0;
                    else min = min + 1;
                end
                if(set_flag)begin
                    sec = set_sec;
                    min = set_min;
                end
            end
        end
    end
    
    bin_to_dec bcd_sec( .bin(sec), .bcd(sec_bcd));
    bin_to_dec bcd_min( .bin(min), .bcd(min_bcd));
    
    fnd_cntr fnd(
        .clk(clk),
        .reset_p(reset_p),
        .fnd_value({min_bcd[7:0], sec_bcd[7:0]}),
        .hex_bcd(1),
        .seg_7(seg_7),
        .com(com)
    );
endmodule


module stop_watch(
    input clk, reset_p,
    input [3:0] btn,
    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led);
    
    wire btn_start, btn_lap, btn_clear;
    reg [7:0] sec, csec;
    wire [7:0] sec_bcd, csec_bcd;
    
    btn_cntr mode_btn(.clk(clk), .reset_p(reset_p),.btn(btn[0]), .btn_pedge(btn_start));
    btn_cntr inc_sec_btn(.clk(clk), .reset_p(reset_p),.btn(btn[1]), .btn_pedge(btn_lap));
    btn_cntr inc_min_btn(.clk(clk), .reset_p(reset_p),.btn(btn[2]), .btn_pedge(btn_clear));
    
    reg start_stop;
    assign led[0] = start_stop;
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) start_stop = 0;
        else if(btn_start) start_stop = ~start_stop;
        else if(btn_clear) start_stop = 0;
    end
    
    reg lap;
    assign led[1] = lap;
    reg [7:0] lap_sec, lap_csec;
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            lap = 0;
            lap_sec = 0;
            lap_csec = 0;
        end
        else if(btn_lap) begin
            lap = ~lap;
            lap_sec = sec;
            lap_csec = csec;
        end
        else if(btn_clear)begin
            lap = 0;
            lap_sec = 0;
            lap_csec = 0;
        end
    end
    
    reg [26:0] cnt_sysclk;
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            sec = 0;
            csec = 0;
            cnt_sysclk = 0;
        end
        else begin
            if(start_stop) begin
                if(cnt_sysclk >= 999_999) begin
                    cnt_sysclk = 0;
                    if(csec >= 99) begin
                        csec = 0;
                        if(sec >= 99) sec = 0;
                        else sec = sec + 1;
                    end
                    else csec = csec + 1;
                end
                else cnt_sysclk = cnt_sysclk + 1;
            end
            if(btn_clear) begin
                sec = 0;
                csec = 0;
                cnt_sysclk = 0;
            end
        end
    end
    
    wire [7:0] fnd_sec, fnd_csec;
    assign fnd_sec = lap ? lap_sec : sec;
    assign fnd_csec = lap ? lap_csec : csec;
    
    bin_to_dec bcd_sec( .bin(fnd_sec), .bcd(sec_bcd));
    bin_to_dec bcd_min( .bin(fnd_csec), .bcd(csec_bcd));
    fnd_cntr fnd(.clk(clk), .reset_p(reset_p), .fnd_value({sec_bcd, csec_bcd}), .hex_bcd(1), .seg_7(seg_7), .com(com));
endmodule

module top_module(
    input clk, reset_p,
    input [1:0] sw,
    input [3:0] btn,
    output reg [7:0] seg_7,
    output reg [3:0] com,
    output reg [13:0] led,
    output [15:14] mode_led,
    output alarm
);

    // 하위 모듈들의 출력 신호를 연결하기 위한 wire 선언
    wire [7:0] seg_7_watch, seg_7_cook, seg_7_stop;
    wire [3:0] com_watch, com_cook, com_stop;
    wire [13:0] led_watch, led_cook, led_stop;
    
    // 시계 모듈 인스턴스화
    watch_top watch_instance(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn),
        .seg_7(seg_7_watch),
        .com(com_watch),
        .led(led_watch)
    );
    
    // 타이머 모듈 인스턴스화
    cook_timer cook_timer_instance(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn),
        .seg_7(seg_7_cook),
        .com(com_cook),
        .alarm(alarm),
        .led(led_cook)
    );
    
    // 스톱워치 모듈 인스턴스화
    stop_watch stop_watch_instance(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn),
        .seg_7(seg_7_stop),
        .com(com_stop),
        .led(led_stop)
    );
    
    reg [1:0] mode; // 현재 모드를 저장하는 레지스터
    assign mode_led[15:14] = mode[1:0]; // 현재 모드를 LED로 표시

    // 스위치(sw) 입력에 따라 현재 모드(mode)를 결정
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) 
            mode <= 0;
        else begin
            case (sw)
                2'b01: mode = 1; // 1번 모드: 타이머
                2'b10: mode = 2; // 2번 모드: 스톱워치
                default: mode = 0; // 기본 모드: 시계
            endcase
        end
    end
    
    // 모드(mode)에 따라 각 모듈의 출력을 최종 출력으로 선택 (멀티플렉서 역할)
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            seg_7 = 0;
            com = 0;
            led = 0;
        end
        else if(mode == 0) begin // 모드 0 (시계) 선택
            seg_7 = seg_7_watch;
            com = com_watch;
            led = led_watch;
        end
        else if(mode == 1) begin // 모드 1 (타이머) 선택
            seg_7 = seg_7_cook;
            com = com_cook;
            led = led_cook;
        end
        else if(mode == 2) begin // 모드 2 (스톱워치) 선택
            seg_7 = seg_7_stop;
            com = com_stop;
            led = led_stop;
        end
    end
endmodule







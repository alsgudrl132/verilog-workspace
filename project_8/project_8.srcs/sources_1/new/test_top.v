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


















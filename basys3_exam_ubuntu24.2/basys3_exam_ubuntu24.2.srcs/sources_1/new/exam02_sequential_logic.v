`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2025 10:27:47 AM
// Design Name: 
// Module Name: exam02_sequential_logic
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


module D_flip_flop_n(
    input d,
    input clk,
    input enable,
    input reset_p,
    output reg q);

    always @(negedge clk or posedge reset_p)begin
        if(reset_p)begin
            q = 1'b0;
        end
        else if(enable)begin
            q = d;
        end
    end

endmodule

module D_flip_flop_p(
    input d,
    input clk,
    input enable,
    input reset_p,
    output reg q);

    always @(posedge clk or posedge reset_p)begin
        if(reset_p)begin
            q = 1'b0;
        end
        else if(enable)begin
            q = d;
        end
    end

endmodule

module T_flip_flop_n(
    input clk, reset_p,      // clk: 클럭 (negedge 기준), reset_p: 비동기 리셋 (양의 엣지에서 작동)
    input enable,            // enable: 플립플롭 동작 허용 여부
    input t,                 // t: T 입력 (1이면 토글)
    output reg q);           // q: 출력 레지스터 (현재 상태)

    // 비동기 리셋 또는 클럭 하강 엣지에서 동작
    always @(negedge clk, posedge reset_p) begin
        if (reset_p)
            q = 0;           // 리셋이 1이면 출력 0으로 초기화
        else begin
            if (enable) begin          // enable이 1일 때만 동작
                if (t)
                    q = ~q;            // t가 1이면 현재 q 상태를 반전 (Toggle)
            end
        end
    end

endmodule

module T_flip_flop_p(
    input clk, reset_p,      // clk: 클럭 (negedge 기준), reset_p: 비동기 리셋 (양의 엣지에서 작동)
    input enable,            // enable: 플립플롭 동작 허용 여부
    input t,                 // t: T 입력 (1이면 토글)
    output reg q);           // q: 출력 레지스터 (현재 상태)

    // 비동기 리셋 또는 클럭 하강 엣지에서 동작
    always @(posedge clk, posedge reset_p) begin
        if (reset_p)
            q = 0;           // 리셋이 1이면 출력 0으로 초기화
        else begin
            if (enable) begin          // enable이 1일 때만 동작
                if (t)
                    q = ~q;            // t가 1이면 현재 q 상태를 반전 (Toggle)
            end
        end
    end

endmodule

module up_counter_asyc(
    input clk, reset_p,
    output [3:0] count);
    
    T_flip_flop_n cnt0(.clk(clk), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[0]));
    T_flip_flop_n cnt1(.clk(count[0]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[1]));
    T_flip_flop_n cnt2(.clk(count[1]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[2]));
    T_flip_flop_n cnt3(.clk(count[2]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[3]));    

endmodule

module down_counter_asyc(
    input clk, reset_p,
    output [3:0] count);
    
    T_flip_flop_p cnt0(.clk(clk), .reset_p(reset_p), .enable(1'b1), .t(1), .q(count[0]));
    T_flip_flop_p cnt1(.clk(count[0]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[1]));
    T_flip_flop_p cnt2(.clk(count[1]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[2]));
    T_flip_flop_p cnt3(.clk(count[2]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[3]));    
                
endmodule


module up_counter_p(
    input clk, reset_p,
    output reg [3:0] count
);
    
    always @(posedge clk, posedge reset_p) begin
        if (reset_p)
            count = 0;
        else
            count = count + 1;
    end
endmodule

module down_counter_p(
    input clk, reset_p,
    output reg [3:0] count
);
    
    always @(posedge clk, posedge reset_p) begin
        if (reset_p)
            count = 0;
        else
            count = count - 1;
    end
endmodule

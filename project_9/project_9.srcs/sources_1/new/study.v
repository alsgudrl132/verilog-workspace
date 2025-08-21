`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2025 04:37:56 PM
// Design Name: 
// Module Name: study
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


module edge_detector_study(
    input clk, reset_p, cp,
    output reg pedge, nedge
);
    reg ff_cur, ff_old; // cp의 현재 상태, 직전 상태

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
            pedge  <= 0;
            nedge  <= 0;
        end else begin
            ff_cur <= cp;
            ff_old <= ff_cur;

            pedge <= (~ff_old & ff_cur); // 0->1
            nedge <= ( ff_old & ~ff_cur); // 1->0
        end
    end
endmodule

module div_1s_study(
    input clk, reset_p,
    output reg clk_div_1s
);
    reg [25:0] count;
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            count = 0;
            clk_div_1s = 0;
        end
        else begin
            if(count >= 49999999) begin
                count = 0;
                clk_div_1s = ~clk_div_1s;
            end
            else begin
                count = count + 1;
            end
        end
    end
endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2025 10:37:42 AM
// Design Name: 
// Module Name: test
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


module ring_counter (
    input clk,
    input reset_p,
    output reg [3:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 4'b0001;                   // 초기값 0001 설정
        end

        else begin
            case (q)
                4'b0001 : q <= 4'b0010;
                4'b0010 : q <= 4'b0100;
                4'b0100 : q <= 4'b1000;
                4'b1000 : q <= 4'b0001;
                default : q <= 4'b0001;     // 문제 생기면 초기값으로
            endcase
        end
    end

endmodule

module ring_counter_shift (
    input clk,
    input reset_p,
    output reg [3:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 4'b0001;                   // 초기값 0001 설정
        end

        else begin
                if (q == 4'b1000)
                    q <= 4'b0001;
                else if (q == 4'b0000 || q > 4'b1000)
                    q <= 4'b0001;
                else
                    q <= {q[2:0], 1'b0};
        end
    end

endmodule

module ring_counter_p (
    input clk,
    input reset_p,
    output reg [3:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) q <= 4'b0001;                   // 초기값 0001 설정
        else q = {q[2:0], q[3]};
    end

endmodule

module edge_detector_n(
    input clk,
    input reset_p,
    input cp,

    output p_edge,
    output n_edge

    );

    reg ff_cur, ff_old;

    always @(negedge clk or posedge reset_p) begin
        if(reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end

    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0;
endmodule

    // cur = 1, old = 0 => p = 1
    // cur = 1, old = 1 => p = 0
    // cur = 0, old = 1 => n = 1



module edge_detector_p(
    input clk,
    input reset_p,
    input cp,

    output p_edge,
    output n_edge

    );

    reg ff_cur, ff_old;

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end

    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1'b1 : 1'b0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1'b1 : 1'b0;
endmodule

module ring_counter_led (
    input clk,
    input reset_p,
    output reg [15:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) q <= 4'b0000_0000_0000_0001;
        else q = {q[14:0], q[15]};
    end

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 03:16:02 PM
// Design Name: 
// Module Name: tb_encoder
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


module tb_encoder_4x2_behavioral;

reg [3:0] signal;
wire [1:0] code;

encoder_4x2_behavioral uut(
    .signal(signal),
    .code(code)
);

initial begin
    signal = 4'b0000;
    #10 signal = 4'b0001;
    #10 signal = 4'b0010;
    #10 signal = 4'b0100;
    #10 signal = 4'b1000;

    #10 signal = 4'b0000;
    #10 signal = 4'b0011;
    #10 $finish;  // $finish는 시뮬레이션 종료 명령
end

initial begin
    $monitor("time = %0dns, signal = %b, code = %b", $time, signal, code);
end

endmodule

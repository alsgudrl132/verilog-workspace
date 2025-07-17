`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2025 04:13:05 PM
// Design Name: 
// Module Name: adder
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


module full_adder_dataflow(
    input a, b, cin,
    output sum, carry
);
    assign sum = a ^ b ^ cin;                        // 세 입력의 XOR
    assign carry = (a & b) | (b & cin) | (a & cin);  // 세 경우의 자리올림

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2025 08:46:24 AM
// Design Name: 
// Module Name: fa
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


module FA(
    input a,
    input b,
    input cin,
    output cout,
    output sum
    );
    
    assign sum = a ^ b ^ cin;
    assign cout = (a&b) | (b&cin) | (a&cin);
endmodule

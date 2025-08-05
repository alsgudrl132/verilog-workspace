`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2025 08:56:42 AM
// Design Name: 
// Module Name: tb_FA
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


module tb_FA;
    reg a, b, cin;
    wire sum, cout;
    
    FA module_FA(a, b, cin, cout, sum);
    
    initial begin
       $monitor("At time %0t: a=%b b=%b, cin=%b, sum=%b, carry=%b",$time, a,b,cin,cout,sum);
        a = 0; b = 0; cin = 0; #1;
        a = 0; b = 0; cin = 1; #1;
        a = 0; b = 1; cin = 0; #1;
        a = 0; b = 1; cin = 1; #1;
        a = 1; b = 0; cin = 0; #1;
        a = 1; b = 0; cin = 1; #1;
        a = 1; b = 1; cin = 0; #1;
        a = 1; b = 1; cin = 1;
    end
endmodule

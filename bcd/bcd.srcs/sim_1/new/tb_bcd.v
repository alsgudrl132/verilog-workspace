`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 02:06:46 PM
// Design Name: 
// Module Name: tb_bcd
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


module tb_bin_to_dec;
    reg [11:0] bin;
    wire [15:0] bcd;
    
    bin_to_dec uut(
        .bin(bin),
        .bcd(bcd)
    );
    
    initial begin
        bin = 12'b0;
        
        #10 bin = 12'b0000_0000_0000;   // 0
        #10 bin = 12'b0000_0000_0001;   // 1
        #10 bin = 12'b0000_0000_1001;   // 9
        #10 bin = 12'b0000_0001_0100;   // 20
        #10 bin = 12'b0000_1011_1001;   // 185
        #10 bin = 12'b1011_0110_1101;   // 2925
        #10 bin = 12'b1111_1111_1111;   // 4095
        
        #20 $stop;  // 시뮬레이션 종료
        
        
    end
    initial begin
        $monitor("Time=%t | bin=%b (%0d) -> BCD=%b (BCD digits:%0d%0d%0d%0d)",
                  $time, bin, bin, bcd, bcd[15:12], bcd[11:8], bcd[7:4], bcd[3:0]);
    end

endmodule

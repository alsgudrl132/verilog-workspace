`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 10:05:45 AM
// Design Name: 
// Module Name: tb_nor_gate
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


module tb_nor_gate;
    reg a, b;
    wire q;
    
    nor_gate_behavior uut (.a(a), .b(b), .q(q));
    // nor_gate_structural uut (.a(a), .b(b), .q(q));
    // nor_gate_dataflow uut (.a(a), .b(b), .q(q));

    initial begin
        $display("Time\ta b | q");                     // 출력 헤더
        $monitor("%0t\t%b %b | %b", $time, a, b, q);   // 값이 바뀔 때마다 자동 출력

        a = 0; b = 0; #10;   // 입력: 0 0
        a = 0; b = 1; #10;   // 입력: 0 1
        a = 1; b = 0; #10;   // 입력: 1 0
        a = 1; b = 1; #10;   // 입력: 1 1

        $finish;             // 시뮬레이션 종료
    end
    
endmodule

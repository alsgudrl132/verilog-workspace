`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 10:26:58 AM
// Design Name: 
// Module Name: tb_xor_gate
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


// XNOR 게이트 테스트벤치
module tb_xnor_gate;

    reg a, b;          // 테스트할 입력 신호 선언 (reg 타입은 값을 할당할 수 있음)
    wire q;            // 출력 신호 선언 (회로로부터 값을 읽어옴)

    // 테스트할 모듈 연결 (동작적 모델링 사용)
    xnor_gate_behavior uut (.a(a), .b(b), .q(q));
    // xnor_gate_structural uut (.a(a), .b(b), .q(q));
    // xnor_gate_dataflow uut (.a(a), .b(b), .q(q));

    initial begin
        $display("Time\ta b | q");                      // 헤더 출력
        $monitor("%0t\t%b %b | %b", $time, a, b, q);    // 값이 바뀔 때마다 출력

        a = 0; b = 0; #10;   // 입력: 0 0 → 10ns 대기
        a = 0; b = 1; #10;   // 입력: 0 1 → 10ns 대기
        a = 1; b = 0; #10;   // 입력: 1 0 → 10ns 대기
        a = 1; b = 1; #10;   // 입력: 1 1 → 10ns 대기

        $finish;             // 시뮬레이션 종료
    end
endmodule


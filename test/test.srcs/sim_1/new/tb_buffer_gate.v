`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 10:48:38 AM
// Design Name: 
// Module Name: tb_buffer_gate
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

// BUFFER 게이트 테스트벤치
module tb_buffer_gate;

    reg a;                 // 테스트할 입력 신호 선언 (reg 타입)
    wire q;                // 출력 신호 선언 (회로로부터 값을 읽어옴)

    // 테스트할 BUFFER 모듈 연결 (동작적 모델링 사용)
    buffer_gate_behavioral uut (.a(a), .q(q));
    // buffer_gate_structural uut (.a(a), .q(q));
    // buffer_gate_dataflow uut (.a(a), .q(q));

    initial begin
        $display("Time\ta | q");                      // 출력 헤더
        $monitor("%0t\t%b | %b", $time, a, q);        // 값이 바뀔 때마다 출력

        a = 0; #10;       // 입력: 0 → 10ns 대기
        a = 1; #10;       // 입력: 1 → 10ns 대기

        $finish;          // 시뮬레이션 종료
    end
endmodule


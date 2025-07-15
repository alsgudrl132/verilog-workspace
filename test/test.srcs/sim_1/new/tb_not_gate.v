`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 09:28:02 AM
// Design Name: 
// Module Name: tb_not_gate
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

// NOT 게이트 테스트벤치
module tb_not_gate;

    reg a;          // 테스트할 입력 신호 선언
    wire q;         // 출력 신호 선언

    // 테스트할 NOT 게이트 모듈 연결 (동작적 모델링 사용)
    not_gate_behavioral uut (.a(a), .q(q));
    // not_gate_dataflow uut (.a(a), .q(q));
    // not_gate_structural uut (.a(a), .q(q));

    initial begin
        $display("Time\ta | q");                      // 출력 헤더
        $monitor("%0t\t%b | %b", $time, a, q);        // 값이 바뀔 때마다 자동 출력

        a = 0; #10;   // 입력: 0
        a = 1; #10;   // 입력: 1

        $finish;             // 시뮬레이션 종료
    end
endmodule

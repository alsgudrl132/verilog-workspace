`timescale 1ns/1ps

// OR 게이트 테스트벤치
module tb_or_gate;

    reg a, b;          // 테스트 입력 신호
    wire q;            // 출력 신호

    // 테스트할 DUT 선택 (동작적 모델링 사용)
    or_gate_behavioral uut (.a(a), .b(b), .q(q));
    // or_gate_dataflow uut(.a(a), .b(b), .q(q));       // 데이터플로우 모델
    // or_gate_structural uut(.a(a), .b(b), .q(q));      // 구조적 모델

    initial begin
        $display("Time\t a b | q");                      // 헤더 출력
        $monitor("%0t\t%b %b | %b", $time, a, b, q);     // 값이 바뀔 때마다 출력

        // 입력 조합 테스트
        a = 0; b = 0; #10;   // 입력: 0 0 → 10ns 대기
        a = 0; b = 1; #10;   // 입력: 0 1 → 10ns 대기
        a = 1; b = 0; #10;   // 입력: 1 0 → 10ns 대기
        a = 1; b = 1; #10;   // 입력: 1 1 → 10ns 대기

        $finish;             // 시뮬레이션 종료
    end
endmodule
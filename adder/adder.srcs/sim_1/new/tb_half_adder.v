`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 02:32:32 PM
// Design Name: 
// Module Name: tb_half_adder
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


// Half Adder 테스트벤치 모듈
module tb_half_adder;

    // 테스트 입력 신호 선언
    reg a, b;            // 1비트 입력 (reg 타입은 값을 할당할 수 있음)

    // 테스트 출력 신호 선언
    wire s, c;           // 1비트 출력 (wire는 회로로부터 값을 읽어옴)

    // 테스트할 회로(Half Adder 모듈) 인스턴스 생성
//    Half_adder_behavioral uut (
//        .a(a),           // 입력 a 연결
//        .b(b),           // 입력 b 연결
//        .s(s),           // 출력 sum 연결
//        .c(c)            // 출력 carry 연결
//    );

    // 시뮬레이션 초기 블록
    initial begin
        // 시뮬레이션 중 값이 바뀔 때마다 출력
        $monitor("%b + %b = sum = %b, carry = %b", a, b, s, c);

        // 모든 입력 조합 테스트 (00, 01, 10, 11)
        a = 0; b = 0; #10;   // a=0, b=0 → 10ns 대기
        a = 0; b = 1; #10;   // a=0, b=1 → 10ns 대기
        a = 1; b = 0; #10;   // a=1, b=0 → 10ns 대기
        a = 1; b = 1; #10;   // a=1, b=1 → 10ns 대기

        // 시뮬레이션 종료
        $finish;
    end

endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 09:22:01 AM
// Design Name: 
// Module Name: comparator
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


module comparator_dataflow(
    input a, b,           // 입력: 1비트 a, b
    output equal,         // 출력: a == b 일 때 1
    output greator,       // 출력: a > b 일 때 1
    output less           // 출력: a < b 일 때 1
);
    // 삼항 연산자를 이용해 논리 표현 (데이터 흐름 방식)
    assign equal = (a == b) ? 1'b1 : 1'b0;
    assign greator = (a > b) ? 1'b1 : 1'b0;
    assign less = (a < b) ? 1'b1 : 1'b0;
endmodule

module comparator_structural (
    input a, b,               // 입력: 1비트 a, b
    output equal,             // 출력: a == b
    output greator,           // 출력: a > b
    output less               // 출력: a < b
);

    // 내부 와이어 선언 (NOT 및 AND 결과 저장)
    wire nota, notb;
    wire a_and_b, nota_and_notb;
    wire a_and_notb, nota_and_b;

    // 논리 게이트 연결 (게이트 수준 표현)
    not (nota, a);              // nota = ~a
    not (notb, b);              // notb = ~b

    and (a_and_b, a, b);        // a & b
    and (nota_and_notb, nota, notb); // ~a & ~b
    and (a_and_notb, a, notb);  // a & ~b
    and (nota_and_b, nota, b);  // ~a & b

    or (equal, nota_and_notb, a_and_b); // equal = (~a & ~b) | (a & b)
    and (greator, a, notb);     // greator = a & ~b
    and (less, nota, b);        // less = ~a & b

endmodule

module comparator_behavioral (
    input a, b,                // 입력: 1비트 a, b
    output reg equal,          // 출력: a == b
    output reg greator,        // 출력: a > b
    output reg less            // 출력: a < b
);

    // 입력값 변경 시마다 항상 블록 실행
    always @(a, b) begin
        // 기본값 0으로 초기화
        equal = 0;
        greator = 0;
        less = 0;

        // 조건문을 이용해 비교 수행
        if (a == b)
            equal = 1;
        else if (a > b)
            greator = 1;
        else
            less = 1;
    end

endmodule

// N비트 크기의 비교기를 정의한 모듈
module comparator_Nbit #(parameter N = 8) (
    input [N-1:0] a, b,     // N비트 입력 벡터 a, b
    output equal,           // a와 b가 같은지 나타내는 출력
    output greator,         // a가 b보다 큰지 나타내는 출력
    output less             // a가 b보다 작은지 나타내는 출력
);

    // 비교 연산 결과를 출력에 할당
    assign equal = (a == b) ? 1'b1 : 1'b0;
    assign greator = (a > b) ? 1'b1 : 1'b0;
    assign less = (a < b) ? 1'b1 : 1'b0;
endmodule

module comparator_test_4bit (
    input [3:0] a, b,
    output equal, greator, less
);
    comparator_Nbit #(.N(4)) test(
        .a(a), .b(b),
        .equal(equal),
        .greator(greator),
        .less(less)
    );
endmodule

module comparator_Nbit_behavioral #(parameter N = 8) (
    input [N-1:0] a, b,
    output reg equal, greator, less
);

    always @(*) begin
        equal = 0;
        greator = 0;
        less = 0;
        
        if (a == b) begin
            equal = 1;
        end
        else if (a > b) begin
            greator = 1;
        end
        else if (a < b) begin
            less = 1;
        end
    end

endmodule
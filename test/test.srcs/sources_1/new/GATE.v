`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 10:33:37 AM
// Design Name: 
// Module Name: GATE
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


// AND 게이트 (동작적 모델링 - case문 방식)
module and_gate(
    input a, b,              // 1비트 입력 a, b
    output reg q            // 출력 q는 레지스터 타입
);
    always @(a, b) begin    // a 또는 b 값이 변할 때마다 블록 실행
        case ({a, b})       // 입력 a, b를 묶어 2비트로 비교
            2'b00 : q = 0;  // 0 AND 0 = 0
            2'b01 : q = 0;  // 0 AND 1 = 0
            2'b10 : q = 0;  // 1 AND 0 = 0
            2'b11 : q = 1;  // 1 AND 1 = 1
        endcase
    end
endmodule

// AND 게이트 (동작적 모델링 - if문 방식)
module and_gate_behavioral (
    input a, b,                 // 1비트 입력 a, b
    output reg q               // 출력 q는 레지스터 타입
);
    always @(a or b) begin     // a 또는 b가 변경될 때 실행
        if(a == 1'b1 && b == 1'b1)  // a와 b가 모두 1이면
            q = 1'b1;              // 출력 q는 1
        else                       // 그 외의 경우
            q = 1'b0;              // 출력 q는 0
    end
endmodule

// AND 게이트 (구조적 모델링)
module and_gate_structual (
    input a, b,                // 1비트 입력 a, b
    output q                   // 출력 q는 wire 타입 (기본)
);
    and U1(q, a, b);           // 내장 and 게이트 사용, 출력 q = a AND b
endmodule

// AND 게이트 (데이터플로우 모델링)
module and_gate_dataflow (
    input a, b,                // 1비트 입력 a, b
    output q                   // 출력 q
);
    assign q = a & b;          // 데이터플로우 방식으로 AND 연산
endmodule

/* --------------------------------------------------------------------------- */

// OR 게이트 (동작적 모델링 - case문 방식)
module or_gate (
    input a, b,                // 1비트 입력 a, b
    output reg q              // 출력 q는 레지스터 타입
);
    always @(a, b) begin       // a 또는 b 변경 시 블록 실행
        case ({a, b})          // 입력 a, b 조합에 따라 출력 결정
            2'b00 : q = 0;     // 0 OR 0 = 0
            2'b01 : q = 1;     // 0 OR 1 = 1
            2'b10 : q = 1;     // 1 OR 0 = 1
            2'b11 : q = 1;     // 1 OR 1 = 1
        endcase
    end
endmodule

// OR 게이트 (동작적 모델링 - if문 방식)
module or_gate_behavioral (
    input a, b,                // 1비트 입력 a, b
    output reg q              // 출력 q는 레지스터 타입
);
    always @(a, b) begin       // a 또는 b 변경 시 실행
        if(a == 1'b1 || b == 1'b1)  // a나 b 중 하나라도 1이면
            q = 1'b1;               // q는 1
        else                        // 둘 다 0이면
            q = 1'b0;               // q는 0
    end
endmodule

// OR 게이트 (구조적 모델링)
module or_gate_structual (
    input a, b,
    output q
);
    or U1(q, a, b);               // 내장 or 게이트 사용 → 실제로는 OR 게이트 구조적 모델링
endmodule

// OR 게이트 (데이터플로우 모델링)
module or_gate_dataflow (
    input a, b,                  // 1비트 입력
    output q
);
    assign q = a | b;            // 데이터플로우 방식으로 OR 연산
endmodule

/* --------------------------------------------------------------------------- */

// NOT 게이트 (동작적 모델링 - if문 방식)
module not_gate (
    input a,
    output reg q
);
    always @(a) begin
        if(a == 1'b1)
            q = 1'b0;
        else
            q = 1'b1;
    end
endmodule

// NOT 게이트 (구조적 모델링)
module not_gate_structual (
    input a,                   // 1비트 입력 a
    output q                   // 출력 q는 wire 타입 (기본)
);
    not U1(q, a);           // 내장 not 게이트 사용, 출력 q = !a
endmodule

// NOT 게이트 (데이터플로우 모델링)
module not_gate_dataflow (
    input a,                   // 1비트 입력 a
    output q                   // 출력 q
);
    assign q = !a;        // 데이터플로우 방식으로 NOT 연산
endmodule

/* --------------------------------------------------------------------------- */

// NAND 게이트 (동작적 모델링 - case문 방식)
module nand_gate(
    input a, b,                  // 1비트 입력 a, b
    output reg q                // 출력 q는 레지스터 타입
);
    always @(a,b) begin
        case ({a,b})
            2'b00 : q = 1;       // 0 NAND 0 = 1
            2'b01 : q = 1;       // 0 NAND 1 = 1
            2'b10 : q = 1;       // 1 NAND 0 = 1
            2'b11 : q = 0;       // 1 NAND 1 = 0
        endcase
    end
endmodule

// NAND 게이트 (동작적 모델링 - if문 방식)
module nand_gate_behavior (
    input a, b,
    output reg q
);
    always @(a,b) begin
        if(a == 1'b1 && b == 1'b1)
            q = 1'b0;
        else
            q = 1'b1;
    end
    
endmodule

// NAND 게이트 (구조적 모델링)
module nand_gate_structual (
    input a, b,                // 1비트 입력 a, b
    output q                   // 출력 q는 wire 타입 (기본)
);
    nand U1(q, a, b);           // 내장 nand 게이트 사용, 출력 q = a AND b
endmodule

// NAND 게이트 (데이터플로우 모델링)
module nand_gate_dataflow (
    input a, b,                // 1비트 입력 a, b
    output q                   // 출력 q
);
    assign q = !(a & b);          // 데이터플로우 방식으로 NAND 연산
endmodule
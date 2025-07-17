`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 10:33:37 AM
// Design Name: Basic Logic Gates
// Module Name: GATE
// Project Name: Logic Gate Modeling
// Target Devices: 
// Tool Versions: 
// Description: Verilog modules for various logic gates implemented in 
//              behavioral, structural, and dataflow modeling styles.
//
// Dependencies: None
// 
// Revision:
// Revision 0.01 - File Created
//////////////////////////////////////////////////////////////////////////////////


/* --------------------------------------------------------------------------- */
/* AND 게이트 */
/* --------------------------------------------------------------------------- */

// AND 게이트 (동작적 모델링 - case문 방식)
module and_gate(
    input a, b,              // 1비트 입력 a, b
    output reg q             // 출력 q는 레지스터 타입
);
    always @(a, b) begin     // a 또는 b 값이 변할 때마다 블록 실행
        case ({a, b})        // 입력 a, b를 묶어 2비트로 비교
            2'b00 : q = 0;   // 0 AND 0 = 0
            2'b01 : q = 0;   // 0 AND 1 = 0
            2'b10 : q = 0;   // 1 AND 0 = 0
            2'b11 : q = 1;   // 1 AND 1 = 1
        endcase
    end
endmodule

// AND 게이트 (동작적 모델링 - if문 방식)
module and_gate_behavioral (
    input a, b,              // 1비트 입력 a, b
    output reg q             // 출력 q는 레지스터 타입
);
    always @(a or b) begin
        if(a == 1'b1 && b == 1'b1)
            q = 1'b1;
        else
            q = 1'b0;
    end
endmodule

// AND 게이트 (구조적 모델링)
module and_gate_structural (
    input a, b,              // 1비트 입력 a, b
    output q                 // 출력 q는 wire 타입 (기본)
);
    and U1(q, a, b);         // 내장 and 게이트 사용
endmodule

// AND 게이트 (데이터플로우 모델링)
module and_gate_dataflow (
    input a, b,
    output q
);
    assign q = a & b;        // 비트 AND 연산
endmodule


/* --------------------------------------------------------------------------- */
/* OR 게이트 */
/* --------------------------------------------------------------------------- */

// OR 게이트 (동작적 모델링 - case문 방식)
module or_gate (
    input a, b,
    output reg q
);
    always @(a, b) begin
        case ({a, b})
            2'b00 : q = 0;   // 0 OR 0 = 0
            2'b01 : q = 1;   // 0 OR 1 = 1
            2'b10 : q = 1;   // 1 OR 0 = 1
            2'b11 : q = 1;   // 1 OR 1 = 1
        endcase
    end
endmodule

// OR 게이트 (동작적 모델링 - if문 방식)
module or_gate_behavioral (
    input a, b,
    output reg q
);
    always @(a, b) begin
        if(a == 1'b1 || b == 1'b1)
            q = 1'b1;
        else
            q = 1'b0;
    end
endmodule

// OR 게이트 (구조적 모델링)
module or_gate_structural (
    input a, b,
    output q
);
    or U1(q, a, b);          // 내장 or 게이트 사용
endmodule

// OR 게이트 (데이터플로우 모델링)
module or_gate_dataflow (
    input a, b,
    output q
);
    assign q = a | b;        // 비트 OR 연산
endmodule


/* --------------------------------------------------------------------------- */
/* NOT 게이트 */
/* --------------------------------------------------------------------------- */

// NOT 게이트 (동작적 모델링 - if문 방식)
module not_gate_behavioral (
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
module not_gate_structural (
    input a,
    output q
);
    not U1(q, a);            // 내장 not 게이트 사용
endmodule

// NOT 게이트 (데이터플로우 모델링)
module not_gate_dataflow (
    input a,
    output q
);
    assign q = !a;           // 논리 NOT 연산
endmodule

/* --------------------------------------------------------------------------- */
/* BUFFER 게이트 */
/* --------------------------------------------------------------------------- */

// BUFFER 게이트 (동작적 모델링 - if문 없이 단순 대입 방식)
module buffer_gate_behavioral (
    input a,               // 1비트 입력 a
    output reg q           // 출력 q는 레지스터 타입
);
    always @(a) begin
        q = a;             // 입력을 그대로 출력
    end
endmodule

// BUFFER 게이트 (구조적 모델링)
module buffer_gate_structural (
    input a,               // 1비트 입력 a
    output q               // 출력 q는 wire 타입
);
    buf U1(q, a);          // 내장 buf 게이트 사용
endmodule

// BUFFER 게이트 (데이터플로우 모델링)
module buffer_gate_dataflow (
    input a,               // 1비트 입력 a
    output q               // 출력 q는 wire 타입
);
    assign q = a;          // 비트 그대로 전달
endmodule

/* --------------------------------------------------------------------------- */
/* NAND 게이트 */
/* --------------------------------------------------------------------------- */

// NAND 게이트 (동작적 모델링 - case문 방식)
module nand_gate(
    input a, b,
    output reg q
);
    always @(a,b) begin
        case ({a,b})
            2'b00 : q = 1;   // 0 NAND 0 = 1
            2'b01 : q = 1;   // 0 NAND 1 = 1
            2'b10 : q = 1;   // 1 NAND 0 = 1
            2'b11 : q = 0;   // 1 NAND 1 = 0
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
module nand_gate_structural (
    input a, b,
    output q
);
    nand U1(q, a, b);        // 내장 nand 게이트 사용
endmodule

// NAND 게이트 (데이터플로우 모델링)
module nand_gate_dataflow (
    input a, b,
    output q
);
    assign q = !(a & b);     // NAND = NOT(AND)
endmodule


/* --------------------------------------------------------------------------- */
/* NOR 게이트 */
/* --------------------------------------------------------------------------- */

// NOR 게이트 (동작적 모델링 - if문 방식)
module nor_gate_behavior (
    input a, b,
    output reg q
);
    always @(a, b) begin
        if(a == 1'b0 && b == 1'b0)
            q = 1'b1;
        else
            q = 1'b0;
    end
endmodule

// NOR 게이트 (구조적 모델링)
module nor_gate_structural (
    input a, b,
    output q
);
    nor U1(q, a, b);         // 내장 nor 게이트 사용
endmodule

// NOR 게이트 (데이터플로우 모델링)
module nor_gate_dataflow (
    input a, b,
    output q
);
    assign q = !(a | b);     // NOR = NOT(OR)
endmodule


/* --------------------------------------------------------------------------- */
/* XOR 게이트 */
/* --------------------------------------------------------------------------- */

// XOR 게이트 (동작적 모델링 - if문 방식)
module xor_gate_behavior (
    input a, b,
    output reg q
);
    always @(a, b) begin
        if((a == 1'b0 && b == 1'b1) || (a == 1'b1 && b == 1'b0))
            q = 1'b1;
        else
            q = 1'b0;
    end
endmodule

// XOR 게이트 (구조적 모델링)
module xor_gate_structural (
    input a, b,
    output q
);
    xor U1(q, a, b);         // 내장 xor 게이트 사용
endmodule

// XOR 게이트 (데이터플로우 모델링)
module xor_gate_dataflow (
    input a, b,
    output q
);
    assign q = a ^ b;        // 비트 XOR 연산
endmodule


/* --------------------------------------------------------------------------- */
/* XNOR 게이트 */
/* --------------------------------------------------------------------------- */

// XNOR 게이트 (동작적 모델링 - if문 방식)
module xnor_gate_behavior (
    input a, b,
    output reg q
);
    always @(a, b) begin
        if((a == 1'b0 && b == 1'b0) || (a == 1'b1 && b == 1'b1))
            q = 1'b1;
        else
            q = 1'b0;
    end
endmodule

// XNOR 게이트 (구조적 모델링)
module xnor_gate_structural (
    input a, b,
    output q
);
    xnor U1(q, a, b);        // 내장 xnor 게이트 사용
endmodule

// XNOR 게이트 (데이터플로우 모델링)
module xnor_gate_dataflow (
    input a, b,
    output q
);
    assign q = !(a ^ b);     // XNOR = NOT(XOR)
endmodule

module gates (
    input a, b,
    output q0, q1, q2, q3, q4, q5, q6
);

    assign q0 = ~a;         // NOT
    assign q1 = a & b;      // AND
    assign q2 = a | b;      // OR
    assign q3 = ~(a & b);   // NAND
    assign q4 = ~(a | b);   // NOR
    assign q5 = a ^ b;      // XOR
    assign q6 = ~(a ^ b);   // XNOR
    
endmodule
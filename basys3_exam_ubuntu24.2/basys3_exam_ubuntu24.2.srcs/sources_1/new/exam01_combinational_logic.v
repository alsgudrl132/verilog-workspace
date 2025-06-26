module and_gate(
    input A,
    input B,
    output F
    );
    
    assign F = A & B;
    
endmodule


module half_adder_structural(
    input A, B,
    output sum, carry
);

    xor(sum, A, B); 
    and(carry, A, B); 

endmodule

module half_adder_behavioral(
    input A, B,
    output reg sum, carry   // always 블록 안에서 값을 할당하므로 reg가 필요하다.
);
    
    always @(A, B) begin    // A 또는 B가 변경될 때마다 아래 코드가 실행된다.
        case ({A, B})       // A와 B를 하나로 묶어 2비트로 만든 후 조건 비교한다.
            2'b00: begin sum = 0; carry = 0; end    // A=0, B=0 → sum=0, carry=0
            2'b01: begin sum = 1; carry = 0; end    // A=0, B=1 → sum=1, carry=0
            2'b10: begin sum = 1; carry = 0; end    // A=1, B=0 → sum=1, carry=0
            2'b11: begin sum = 0; carry = 1; end    // A=1, B=1 → sum=0, carry=1
        endcase
    end
endmodule

module half_adder_dataflow(
    input A, B,        // 입력 신호 A와 B (1비트)
    output sum, carry  // 출력 신호 sum (합), carry (자리올림)
);

    wire [1:0] sum_value;  // 2비트 와이어: A와 B를 더한 결과를 저장

    // A와 B를 더한 결과를 sum_value에 할당
    // sum_value[0]은 합의 하위 비트, sum_value[1]은 자리올림 비트
    assign sum_value = A + B;

    // sum은 sum_value의 0번째 비트 (합의 하위 비트)
    assign sum = sum_value[0];

    // carry는 sum_value의 1번째 비트 (자리올림 비트)
    assign carry = sum_value[1];

endmodule

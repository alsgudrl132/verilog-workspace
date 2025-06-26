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

module full_adder_behavioral(
    input A, B, cin,        // 입력: A, B (피연산자), cin (자리올림 입력)
    output reg sum, carry   // 출력: sum (합), carry (자리올림 출력)
);

always @(A, B, cin) begin    // A, B, cin 중 하나라도 바뀌면 아래 블록 실행
    case ({A, B, cin})       // 세 입력을 하나의 3비트 벡터로 묶어 case로 비교
        3'b000: begin sum = 0; carry = 0; end  // 0 + 0 + 0 = 0, carry = 0
        3'b001: begin sum = 1; carry = 0; end  // 0 + 0 + 1 = 1, carry = 0
        3'b010: begin sum = 1; carry = 0; end  // 0 + 1 + 0 = 1, carry = 0
        3'b011: begin sum = 0; carry = 1; end  // 0 + 1 + 1 = 2, carry = 1
        3'b100: begin sum = 1; carry = 0; end  // 1 + 0 + 0 = 1, carry = 0
        3'b101: begin sum = 0; carry = 1; end  // 1 + 0 + 1 = 2, carry = 1
        3'b110: begin sum = 0; carry = 1; end  // 1 + 1 + 0 = 2, carry = 1
        3'b111: begin sum = 1; carry = 1; end  // 1 + 1 + 1 = 3, carry = 1
    endcase
end

endmodule

module full_adder_structural(
    input A, B, cin,        // 입력: A, B (피연산자), cin (자리올림 입력)
    output sum, carry       // 출력: sum (합), carry (자리올림 출력)
);

    wire sum_0, carry_0, carry_1;  // 내부 연결선: 하프가산기들의 출력 중간값 저장

    // 첫 번째 하프가산기: A + B 연산
    half_adder_structural ha0(
        .A(A),              // 입력 A
        .B(B),              // 입력 B
        .sum(sum_0),        // 출력: 중간 합 (sum_0)
        .carry(carry_0)     // 출력: 자리올림 (carry_0)
    );

    // 두 번째 하프가산기: sum_0 + cin 연산
    half_adder_structural ha1(
        .A(sum_0),          // 입력: 첫 하프가산기의 sum
        .B(cin),            // 입력: 외부에서 들어온 자리올림
        .sum(sum),          // 출력: 최종 합
        .carry(carry_1)     // 출력: 자리올림
    );

    // 최종 자리올림(carry)은 두 하프가산기에서 나온 carry들을 OR 연산해서 결정
    or(carry, carry_0, carry_1);

endmodule

module full_adder_dataflow(
    input A, B, cin,         // 입력: A, B (1비트 피연산자), cin (자리올림 입력)
    output sum, carry        // 출력: sum (1의 자리 합), carry (자리올림 출력)
);

    wire [1:0] sum_value;     // 2비트 와이어: 전체 덧셈 결과 (합 + 자리올림)

    // A + B + cin 연산 결과를 2비트 sum_value에 저장
    // 예: 1 + 1 + 1 = 3 (2'b11)
    assign sum_value = A + B + cin;

    // sum_value[0]: 1의 자리 (최하위 비트) → sum 출력에 연결
    assign sum = sum_value[0];

    // sum_value[1]: 2의 자리 (자리올림 비트) → carry 출력에 연결
    assign carry = sum_value[1];    

endmodule

module fadder_4bit_dataflow(
    input [3:0] A, B, 
    input cin,         // 입력: A, B (1비트 피연산자), cin (자리올림 입력)
    output [3:0] sum,
    output carry        // 출력: sum (1의 자리 합), carry (자리올림 출력)
);

    wire [4:0] sum_value;     // 2비트 와이어: 전체 덧셈 결과 (합 + 자리올림)

    assign sum_value = A + B + cin;
    assign sum = sum_value[3:0];
    assign carry = sum_value[4];    

endmodule

module fadder_4bit_structural(
    input [3:0] A, B,
    input cin,
    output [3:0] sum,
    output carry   
    );
    
    wire [2:0] carry_w;
    
    full_adder_structural fa0(.A(A[0]), .B(B[0]), .cin(cin), .sum(sum[0]), .carry(carry_w[0]));
    full_adder_structural fa1(.A(A[1]), .B(B[1]), .cin(carry_w[0]), .sum(sum[1]), .carry(carry_w[1]));
    full_adder_structural fa2(.A(A[2]), .B(B[2]), .cin(carry_w[1]), .sum(sum[2]), .carry(carry_w[2]));
    full_adder_structural fa3(.A(A[3]), .B(B[3]), .cin(carry_w[2]), .sum(sum[3]), .carry(carry));

    
endmodule


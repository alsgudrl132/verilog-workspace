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

module mux_2_1(         // 2:1 멀티플렉서 모듈 정의
    input [1:0] d,      // 2비트 입력 (d[1], d[0])
    input s,            // 선택 신호 (1비트)
    output f            // 출력 신호
    );

    assign f = s ? d[1] : d[0];  // s가 1이면 d[1] 출력, s가 0이면 d[0] 출력

endmodule

module mux_4_1(         // 2:1 멀티플렉서 모듈 정의
    input [3:0] d,      // 2비트 입력 (d[1], d[0])
    input [1:0] s,            // 선택 신호 (1비트)
    output f            // 출력 신호
    );

    assign f = d[s];

endmodule

module mux_8_1(         
    input [7:0] d,      
    input [2:0] s,      
    output f            
    );

    assign f = d[s];

endmodule

// 1-to-4 디멀티플렉서 (demux) 모듈 정의
module demux_1_4_d(
    input d,              // 입력 신호 (1비트)
    input [1:0] s,        // 선택 신호 (2비트)
    output [3:0] f        // 4비트 출력 (4개 중 하나만 d로 설정됨)
    );
    
    // 선택 신호 s에 따라 d를 해당 위치에 출력하고 나머지는 0
    assign f = (s == 2'b00) ? {3'b000, d} :         // s = 00 → f[0] = d
               (s == 2'b01) ? {2'b00, d, 1'b0} :     // s = 01 → f[1] = d
               (s == 2'b10) ? {1'b0, d, 2'b00} :     // s = 10 → f[2] = d
                             {d, 3'b000};           // s = 11 → f[3] = d
    
endmodule

// mux와 demux를 함께 테스트하는 모듈
module mux_demux_test(
    input [3:0] d,            // 4비트 입력 데이터 (mux에 연결)
    input [1:0] mux_s,        // 멀티플렉서 선택 신호
    input [1:0] demux_s,      // 디멀티플렉서 선택 신호
    output [3:0] f            // 디멀티플렉서 출력
    );
    
    wire mux_f;               // 멀티플렉서 출력과 디멀티플렉서 입력을 연결할 중간 와이어
    
    // 4:1 멀티플렉서 인스턴스
    mux_4_1 mux_4(
        .d(d),                // 4비트 입력 데이터
        .s(mux_s),            // 선택 신호
        .f(mux_f)             // 출력 (1비트)
    );
    
    // 1:4 디멀티플렉서 인스턴스
    demux_1_4_d demux4(
        .d(mux_f),            // 입력 신호 (mux 출력)
        .s(demux_s),          // 선택 신호
        .f(f)                 // 출력 (4비트)
    );
endmodule

module encoder_4_2(
    input [3:0] signal,     // 4비트 입력 신호
    output reg [1:0] code        // 2비트 출력 코드
    );

    // 아래 코드는 단순 매핑 방식으로,
    // 입력 신호가 특정 값일 때 그에 대응되는 출력을 하도록 구성되어 있음
    // 즉, "이 값이 들어오면 이 값을 출력한다"는 방식

//    assign code = (signal == 4'b1000) ? 2'b11 :  // 입력이 1000이면 출력은 11
//                  (signal == 4'b0100) ? 2'b10 :  // 입력이 0100이면 출력은 10
//                  (signal == 4'b0010) ? 2'b01 :  // 입력이 0010이면 출력은 01
//                                        2'b00;   // 그 외 (또는 0001일 경우 등)엔 00 출력
    
//    always @(signal)begin
//        if(signal == 4'b1000) code = 2'b11;
//        else if(signal == 4'b0100) code = 2'b10;
//        else if(signal == 4'b0010) code = 2'b01;
//        else code = 2'b00;
//    end

    always @(signal)begin
        case(signal)
            4'b0001: code = 2'b00;
            4'b0010: code = 2'b01;
            4'b0100: code = 2'b10;
            4'b1000: code = 2'b11;
            default: code = 2'b00;
        endcase
    end
endmodule

module decoder_2_4(
    input [1:0] code,       // 2비트 입력 값 (인코딩된 신호)
    output reg [3:0] signal     // 4비트 출력 신호 (디코딩된 결과)
    );

    // 아래 assign 문은 2:4 디코더 역할을 합니다.
    // 입력 code 값에 따라 출력 signal의 한 비트만 1로 설정됩니다.
    // 즉, "이 값이 들어오면 이 신호를 출력한다"는 방식입니다.

//    assign signal = (code == 2'b00) ? 4'b0001 :  // code가 00이면 signal은 0001
//                    (code == 2'b01) ? 4'b0010 :  // code가 01이면 signal은 0010
//                    (code == 2'b10) ? 4'b0100 :  // code가 10이면 signal은 0100
//                                     4'b1000;    // 나머지(11)면 signal은 1000

//    always @(code)begin
//        if(code == 2'b00) signal = 4'b0001;
//        else if(code == 2'b01) signal = 4'b0010;
//        else if(code == 2'b10) signal = 4'b0100;
//        else signal = 4'b1000;    
//    end

    always @(code)begin
        case(code)
            2'b00: signal = 4'b0001;
            2'b01: signal = 4'b0010;
            2'b10: signal = 4'b0100;
            default: signal = 4'b1000;    
        endcase
    end

endmodule



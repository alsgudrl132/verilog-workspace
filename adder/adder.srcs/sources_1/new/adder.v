`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 02:06:39 PM
// Design Name: 
// Module Name: adder
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

// Half Adder Behavioral
// 두개의 1비트를 입력 (a, b)
// 합(s), 자리올립(c)를 출력하는 반가산기
module Half_adder_behavioral(
    input a,    // 1bit 입력 a
    input b,    // 1bit 입력 b
    output reg s,   // 합(sum)을 저장할 레지스터 타입의 출력
    output reg c    // 자리올림(carry)를 저장할 레지스터 타입의 출력
    );

    // a 또는 b의 변화가 생길때 마다 always블록 실행
    always @(a, b) begin
        case ({a, b})
            2'b00 : begin   // a = 0, b = 0 -> 합 = 0, 자리올림 = 0
                s = 0;
                c = 0;
            end
            2'b01 : begin   // a = 0, b = 1 -> 합 = 1, 자리올림 = 0
                s = 1;
                c = 0;
            end
            2'b10 : begin   // a = 1, b = 0 -> 합 = 1, 자리올림 = 0
                s = 1;
                c = 0;
            end
            2'b11 : begin   // a = 1, b = 1 -> 합 = 0, 자리올림 = 1
                s = 0;
                c = 1;
            end
        endcase
    end
endmodule

module half_adder_structual (
    input a, b,
    output s, c
);
    and (c, a, b);
    xor (s, a, b);
endmodule

module half_adder_dataflow (
    input a, b,
    output s, c
);
    // a와 b의 합을 저장할 2비트 와이어
    // 최대값은 1 + 1 = 2 (2'b10)이므로 2비트가 필요
    wire [1:0] sum_value;
    
    // verilog에서 '+' 연산자는 벡터를 생성해서 결과를 sum_value에 저장
    // ex) a = 1, b = 1 -> sum_value = 2'b10
    assign sum_value = a + b;
    
    // sum_value의 최하위비트(LSB)인 sum_value[0]를 s에 할당
    assign s = sum_value[0];
    
    // sum_value의 최상위비트(MSB)인 sum_value[1]을 c에 할당
    assign c = sum_value[1];
endmodule

// ---------------------------------------------------------------------------
// N비트 하프 가산기 (Half Adder) 모듈
// ---------------------------------------------------------------------------
// 이 모듈은 N비트 입력값 load_data에 1비트 inc 값을 더하는 회로입니다.
// 오직 Half Adder만 사용하여 구현되며, 첫 자리에는 inc가 더해지고,
// 그 이후 자리는 이전 자리의 캐리값과 load_data[i]를 더해서 계산됩니다.
// ---------------------------------------------------------------------------

module half_adder_N_bit #(
    parameter N = 8              // N은 비트 수이며 기본값은 8비트입니다.
)(
    input inc,                   // 첫 번째 비트에 더할 값 (보통 0 또는 1)
    input [N-1:0] load_data,     // 더해질 입력 데이터 (N비트)
    output [N-1:0] sum           // 결과로 나올 합 (N비트)
);

    // 각 비트 자리마다 발생한 캐리 출력을 저장할 배열입니다.
    wire [N-1:0] carry_out;

    // 첫 번째 비트(0번째 자리)는 inc와 load_data[0]를 더해서 계산합니다.
    // - 합은 sum[0]
    // - 캐리는 carry_out[0]에 저장됩니다.
    half_adder_dataflow ha0 (
        .a(inc),
        .b(load_data[0]),
        .s(sum[0]),
        .c(carry_out[0])
    );

    // 반복문을 만들기 위한 변수 i (generate 문 전용 변수입니다)
    genvar i;

    // 두 번째 비트(1번 자리)부터 마지막 비트(N-1)까지 반복적으로 Half Adder 생성
    generate
        for (i = 1; i < N; i = i + 1) begin : hagen  // 각 반복 블록 이름은 hagen[i]
            
            // 각 자리 i에서는 다음을 계산합니다:
            // - 이전 자리의 캐리 carry_out[i-1]
            // - 현재 자리 입력 load_data[i]
            // → 이 둘을 Half Adder에 넣어
            //    sum[i]과 carry_out[i]를 계산합니다.
            half_adder_dataflow ha (
                .a(carry_out[i - 1]),   // 이전 자리의 캐리를 입력
                .b(load_data[i]),       // 현재 자리 입력값
                .s(sum[i]),             // 현재 자리의 합 출력
                .c(carry_out[i])        // 다음 자리로 전달될 캐리 출력
            );
        end
    endgenerate

endmodule

module full_adder_structual (
    input a, b, cin,            // 입력비트 3개 (이전자리에서 올라온 자리올림 cin)
    output sum, carry           // 출력
);

    wire sum_0;     // 첫번째 반가산기의 합
    wire carry_0;   // 첫번째 반가산기의 캐리
    wire carry_1;   // 두번째 반가산기의 캐리

    // 첫번째 반가산기 : 입력 a, b 더함
    // 결과로 sum_0에 중간합이 저장,  carry_0에 자리올림
    half_adder_structual ha0(
        .a(a),
        .b(b),
        .s(sum_0),
        .c(carry_0)
    );

    // 두번째 반가산기 : sum_0 하고 cin 을 더함
    // 최종합(sum)은 여기서 나옴, carry_1은 중간 자리올림
    half_adder_structual ha1(
        .a(sum_0),
        .b(cin),
        .s(sum),
        .c(carry_1)
    );

    // 최종 자리올림은 두자리올림의 OR연산 (carry_0, carry_1)
    // 둘중 하나라도 1이면 carry 출력은 1
    or (carry, carry_0, carry_1);
    
endmodule

module full_adder_behavioral (
    input a, b, cin,
    output reg sum, carry
);

    always @(a, b, cin) begin
        case ({a, b, cin})
            3'b000 : begin sum = 0; carry = 0; end
            3'b001 : begin sum = 1; carry = 0; end
            3'b010 : begin sum = 1; carry = 0; end
            3'b011 : begin sum = 0; carry = 1; end
            3'b100 : begin sum = 1; carry = 0; end
            3'b101 : begin sum = 0; carry = 1; end
            3'b110 : begin sum = 0; carry = 1; end
            3'b111 : begin sum = 1; carry = 1; end
        endcase
    end
endmodule

module full_adder_dataflow (
    input a, b, cin,
    output sum, carry
);
    wire [1:0] sum_value;   // 2비트 와이어 -> 덧셈결과 (하위 : sum, 상위 : carry)
    
    assign sum_value = a + b + cin;
    
    assign sum = sum_value[0];
    assign carry = sum_value[1];
    
endmodule

module fadder_4bit_structural (
    input  [3:0] a, b,     // 4비트 입력 벡터 a, b
    input        cin,      // 처음 자리의 입력 캐리
    output [3:0] sum,      // 4비트 덧셈 결과
    output       carry     // 최종 자리의 출력 캐리
);

    // 각 전가산기의 출력 캐리를 연결할 내부 신호선 (3개 필요)
    wire [2:0] carry_w;

    // --------------------------
    // 비트 0 (가장 하위 비트)
    // 입력: a[0], b[0], cin
    // 출력: sum[0], carry_w[0]
    // --------------------------
    full_adder_structual fa0 (
        .a    (a[0]),
        .b    (b[0]),
        .cin  (cin),
        .sum  (sum[0]),
        .carry(carry_w[0])
    );

    // --------------------------
    // 비트 1
    // 입력: a[1], b[1], carry_w[0]
    // 출력: sum[1], carry_w[1]
    // --------------------------
    full_adder_structual fa1 (
        .a    (a[1]),
        .b    (b[1]),
        .cin  (carry_w[0]),
        .sum  (sum[1]),
        .carry(carry_w[1])
    );

    // --------------------------
    // 비트 2
    // 입력: a[2], b[2], carry_w[1]
    // 출력: sum[2], carry_w[2]
    // --------------------------
    full_adder_structual fa2 (
        .a    (a[2]),
        .b    (b[2]),
        .cin  (carry_w[1]),
        .sum  (sum[2]),
        .carry(carry_w[2])
    );

    // --------------------------
    // 비트 3 (가장 상위 비트)
    // 입력: a[3], b[3], carry_w[2]
    // 출력: sum[3], 최종 캐리 출력 carry
    // --------------------------
    full_adder_structual fa3 (
        .a    (a[3]),
        .b    (b[3]),
        .cin  (carry_w[2]),
        .sum  (sum[3]),
        .carry(carry)
    );

endmodule

module fadder_sub_4bit_structural (
    input [3:0] a, b,   // 4bit input
    input s,            // select signal (0 : add, 1 : sub)
    output [3:0] sum,   // 4bit result
    output carry        // final carry (carry or borrow)
);

    wire [2:0] carry_w;     // 각 자리에서 발생하는 중간 캐리
    wire [3:0] b_w;         // b 입력값과 s 신호를 xor 한 결과(b의 보수 처리용)

    // b의 각 비트와 s를 xor
    // s가 0이면 b_w는 b와 같음(덧셈모드)
    // s가 1이면 b_w는 b의 각 비트가 반전됨 (뺄셈모드, 2의 보수 연산 준비)
    xor(b_w[0], b[0], s);   
    xor(b_w[1], b[1], s);   
    xor(b_w[2], b[2], s);   
    xor(b_w[3], b[3], s);   

    // 4개의 전 가산기로 4비트 덧셈/뺄셈
    // 첫번째 가산기에는 s를 초기 캐리 입력(cin)으로 사용
    // s = 0이면 덧셈 (cin = 0)
    // s = 1이면 뺄셈 (cin = 1), 2의 보수로 연산
    full_adder_structual fa0(.a(a[0]), .b(b_w[0]), .cin(s), .sum(sum[0]), .carry(carry_w[0]));
    full_adder_structual fa1(.a(a[1]), .b(b_w[1]), .cin(carry_w[0]), .sum(sum[1]), .carry(carry_w[1]));
    full_adder_structual fa2(.a(a[2]), .b(b_w[2]), .cin(carry_w[1]), .sum(sum[2]), .carry(carry_w[2]));
    full_adder_structual fa3(.a(a[3]), .b(b_w[3]), .cin(carry_w[2]), .sum(sum[3]), .carry(carry));

endmodule

module fadder_sub_4bit_dataflow (
    input [3:0] a, b,
    input s,
    output [3:0] sum,
    output carry
);
    wire [4:0] sum_value;   // 5비트 와이어 : 덧셈/뺄셈 결과 (4비트 + 캐리비트)

    assign sum_value = s ? a - b : a + b;
    assign sum = sum_value[3:0];
    
    assign carry = s ? ~sum_value[4] : sum_value[4];

endmodule
    
module fadder_sub_4bit_behavioral (
    input [3:0] a, b,
    input s,
    output reg [3:0] sum,
    output reg carry
);
    reg [4:0] temp; // 5비트 임시 변수
    always @(*) begin
        if (s == 0)
            temp = a + b;
        else
            temp = a - b; 
        
        sum = temp[3:0];
        carry = s ? ~temp[4] : temp[4];
    end
endmodule

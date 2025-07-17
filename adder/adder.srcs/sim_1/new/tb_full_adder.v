`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 04:26:24 PM
// Design Name: 
// Module Name: tb_full_adder
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


// Full Adder 테스트벤치
module tb_full_adder;

    // 입력 신호는 reg 타입 (테스트 중 값을 할당해야 하므로)
    reg a, b, cin;

    // 출력 신호는 wire 타입 (회로에서 계산된 결과를 받음)
    wire sum, carry;

    // 테스트할 Full Adder 모듈 인스턴스화
    full_adder_structual uut (
        .a(a),        // 입력 a 연결
        .b(b),        // 입력 b 연결
        .cin(cin),    // 입력 자리올림 carry-in 연결
        .sum(sum),    // 출력 합 연결
        .carry(carry) // 출력 자리올림 carry-out 연결
    );

    // 시뮬레이션 시작 블록
    initial begin
        // 출력 헤더
        $display("A B Cin | Sum Carry");
        $display("--------------------");

        // 다양한 입력 조합 테스트
        a = 0; b = 0; cin = 0; #10
        $display("%b %b %b | %b %b", a, b, cin, sum, carry);

        a = 0; b = 0; cin = 1; #10
        $display("%b %b %b | %b %b", a, b, cin, sum, carry);

        a = 0; b = 1; cin = 0; #10
        $display("%b %b %b | %b %b", a, b, cin, sum, carry);

        a = 0; b = 1; cin = 1; #10
        $display("%b %b %b | %b %b", a, b, cin, sum, carry);

        a = 0; b = 0; cin = 0; #10
        $display("%b %b %b | %b %b", a, b, cin, sum, carry);

        a = 0; b = 0; cin = 1; #10
        $display("%b %b %b | %b %b", a, b, cin, sum, carry);

        a = 0; b = 1; cin = 0; #10
        $display("%b %b %b | %b %b", a, b, cin, sum, carry);

        a = 0; b = 1; cin = 1; #10
        $display("%b %b %b | %b %b", a, b, cin, sum, carry);

        // 시뮬레이션 종료
        $finish;
    end
endmodule

module tb_full_adder_tb;
    reg a, b, cin;
    wire sum, carry;

    // 0 = behavioral, 1 = dataflow
    parameter USE_DATAFLOW = 0;
    
    generate
        if(USE_DATAFLOW == 0) begin : behav
            full_adder_behavioral uut(
                .a(a),
                .b(b),
                .cin(cin),
                .sum(sum),
                .carry(carry)
            );
        end else begin : dataf
            full_adder_dataflow uut(
                .a(a),
                .b(b),
                .cin(cin),
                .sum(sum),
                .carry(carry)
            );
        end
    endgenerate

    initial begin
        a = 0; b = 0; cin = 0;

        repeat (8) begin
            #10;
            {a, b, cin} = {a, b, cin} + 1;
        end
        #10;
        $finish;
    end

    initial begin
        $display("Time\t a b cin | sum carry");
        $monitor("%0t\t %b %b %b | %b %b", $time, a, b, cin, sum, carry);
    end

endmodule

module tb_fadder_4bit_structural;

    // 입력 신호 (4비트 a, b와 캐리 입력)
    reg [3:0] a, b;
    reg       cin;

    // 출력 신호 (4비트 합과 최종 캐리 출력)
    wire [3:0] sum;
    wire       carry;

    // 테스트 대상 모듈 인스턴스 연결
    fadder_4bit_structural uut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        // 헤더 출력
        $display("Time\t cin\t a\t    b\t   | sum\t  carry");
        $monitor("%0t\t  %b\t %b\t %b\t | %b\t   %b", $time, cin, a, b, sum, carry);

        // -----------------------
        // 테스트 벡터 입력
        // -----------------------

        cin = 0; a = 4'b0000; b = 4'b0000; #10; // 0 + 0 + 0 = 0000, carry = 0
        cin = 0; a = 4'b0001; b = 4'b0001; #10; // 1 + 1 + 0 = 0010, carry = 0
        cin = 1; a = 4'b0010; b = 4'b0011; #10; // 2 + 3 + 1 = 0110, carry = 0
        cin = 0; a = 4'b1111; b = 4'b0001; #10; // 15 + 1 + 0 = 0000, carry = 1
        cin = 1; a = 4'b1010; b = 4'b0101; #10; // 10 + 5 + 1 = 10000, carry = 1
        cin = 0; a = 4'b1111; b = 4'b1111; #10; // 15 + 15 + 0 = 1110, carry = 1
        cin = 1; a = 4'b1111; b = 4'b1111; #10; // 15 + 15 + 1 = 1111, carry = 1

        // 시뮬레이션 종료
        #10 $finish;
    end

endmodule

module tb_fadder_sub_4bit;

    // 테스트 입력: 4비트 입력 a, b / 제어 신호 s (0: 덧셈, 1: 뺄셈)
    reg [3:0] a, b;
    reg s;

    // 출력: 연산 결과 sum, 캐리/버로우 carry
    wire [3:0] sum;
    wire carry;

    // 테스트할 모듈 인스턴스화 (구조적 설계 기반)
    fadder_sub_4bit_structural uut (
        .a(a),
        .b(b),
        .s(s),          // 제어 신호: 0이면 덧셈, 1이면 뺄셈
        .sum(sum),
        .carry(carry)
    );

    integer i, j;       // 반복문용 변수

    // 테스트 시나리오
    initial begin
        // 시뮬레이션 출력 포맷 정의
        $display("Time\t a  b   s | sum carry");
        $monitor("%0t\t %b  %b  %b | %b %b", $time, a, b, s, sum, carry);

        // a, b에 대해 0~15까지 모든 조합 테스트
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a = i;
                b = j;

                // 덧셈 테스트 (s=0)
                s = 0;
                #10;

                // 뺄셈 테스트 (s=1)
                s = 1;
                #10;
            end
        end

        // 시뮬레이션 종료
        $finish;
    end

endmodule


module tb_fadd_sub_4bit;
    reg [3:0] a,b;
    reg s;
    wire [3:0] sum;
    wire carry;

    parameter USE_BEHAVIORAL = 0;

    generate
        if (USE_BEHAVIORAL == 0) begin : behav
            fadder_sub_4bit_behavioral uut(
                .a(a),
                .b(b),
                .s(s),
                .sum(sum),
                .carry(carry)
            );
        end else begin
            fadder_sub_4bit_dataflow uut(
                .a(a),
                .b(b),
                .s(s),
                .sum(sum),
                .carry(carry)
            );
        end
    endgenerate

    integer i, j;       // 반복문용 변수

    // 테스트 시나리오
    initial begin
        // 시뮬레이션 출력 포맷 정의
        $display("Time\t a  b   s | sum carry");
        $monitor("%0t\t %b  %b  %b | %b %b", $time, a, b, s, sum, carry);

        // a, b에 대해 0~15까지 모든 조합 테스트
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                a = i;
                b = j;

                // 덧셈 테스트 (s=0)
                s = 0;
                #10;

                // 뺄셈 테스트 (s=1)
                s = 1;
                #10;
            end
        end

        // 시뮬레이션 종료
        $finish;
    end
    
endmodule
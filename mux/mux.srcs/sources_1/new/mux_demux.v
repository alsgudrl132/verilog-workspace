`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 03:42:58 PM
// Design Name: 
// Module Name: mux_demux
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

module mux_2_1(
    input [1:0] d,  // 2개의 입력선: d[0]과 d[1]
    input s,        // 선택 신호: 0 또는 1
    output f        // 출력 신호
);
    assign f = s ? d[1] : d[0];  // s=0이면 d[0], s=1이면 d[1]을 출력
endmodule


module mux_4_1 (
    input [3:0] d,
    input [1:0] s,  // 선택신호 2bit (00, 01, 10, 11)
    output f
);

    assign f = d[s];    // s가 가리키는 d배열 원소 출력
    
endmodule

// 8:1 멀티플렉서 (Multiplexer)
// 8개의 입력 중 선택선 s에 따라 하나를 출력 f로 전달
module mux_8_1 (
    input [7:0] d,     // 8개의 입력 신호: d[7] ~ d[0]
    input [2:0] s,     // 선택선 (3비트): 0~7까지 표현 가능, 어떤 입력을 선택할지 결정
    output f           // 출력 신호: 선택된 입력 d[s]가 출력됨
);

    // 선택선 s의 값에 따라 d[0] ~ d[7] 중 하나를 선택하여 f에 할당
    assign f = d[s];

endmodule

module mux_2_1_behavioral (
    input [1:0] d,
    input s,
    output reg f
);
    always @(d, s) begin
        if (s == 1'b1) begin
            f = d[1];
        end else begin
            f = d[0];
        end
    end

endmodule

module mux_2_1_structual (
    input [1:0] d,
    input s,
    output f
);

    wire s_n;           // s의 NOT을 저장할 내부 와이어
    wire and_out_0;     // 첫번째 AND게이트 출력
    wire and_out_1;     // 두번째 ANDㅔ이트 출력
    
    not (s_n, s);
    
    and (and_out_0, d[0], s_n);
    and (and_out_1, d[1], s);
    
    or(f, and_out_0, and_out_1);

endmodule

module mux_4_1_behavioral (
    input [3:0]d,
    input [1:0]s,
    output reg f
);

    always @(d,s) begin
        case (s)
            2'b00 : f = d[0];
            2'b01 : f = d[1];
            2'b10 : f = d[2];
            2'b11 : f = d[3];
            default f= 1'bx;     //정의되지 않은 값 처리 (옵션)
        endcase
    end
endmodule

module mux_4_1_structual (
    input [3:0]d,
    input [1:0]s,
    output f
);

    wire mux_out_0;     // 첫번째 먹스 출력 2_1
    wire mux_out_1;     // 두번째 먹스 출력 2_2
    
    mux_2_1_structual m0 (
        .d0(d[0]),
        .d1(d[1]),
        .s(s[0]),
        .f(mux_out_0)
    );
    mux_2_1_structual m1 (
        .d0(d[2]),
        .d1(d[3]),
        .s(s[1]),
        .f(mux_out_1)
    );
    
    mux_2_1_structual m2 (
        .d0(mux_out_0),
        .d1(mux_out_1),
        .s(s[1]),
        .f(f)
    );

endmodule

module demux_1_to_2 (
    input in,
    input s,
    output reg [1:0] out
);
    always @(*) begin
        case(s)
            1'b0 : out = {1'b0, in};    // out[1] = 0, out[0] = in
            1'b1 : out = {in, 1'b0};    // out[1] = in, out[0] = 0
        endcase    
    end    
endmodule

module demux_1_4_d (
    input d,
    input [1:0] s,
    output [3:0] f
);
    // 선택 신호 s에 따라서 d를 4개중에 한위치 전달 하고 나머지 0
    assign f = (s == 2'b00) ? {3'b000, d}:          // s = 00이면 -> f = 000d (f[0] = d)
               (s == 2'b01) ? {2'b00, d, 1'b0}:     // s = 01이면 -> f = 00d0 (f[1] = d)
               (s == 2'b10) ? {1'b0, d, 2'b00}:     // s = 10이면 -> f = 0d00 (f[2] = d) 
                              {d, 3'b000};          // s = 11이면 -> f = d000 (f[3] = d)
                                               
endmodule

module tb_demux_1_4;
    reg d;
    reg [1:0] s;
    wire [3:0] f;

    demux_1_4_d uut(
        .d(d),
        .s(s),
        .f(f)
    );
    
    initial begin
        $display("time\t d s\t|\tf");
        $monitor("%0t\t %b %b\t|\t%b", $time, d, s, f);
        
        d = 1;
        s = 2'b00; #10;
        s = 2'b01; #10;
        s = 2'b10; #10;
        s = 2'b11; #10;
    
        d = 0;
        s = 2'b00; #10;
        s = 2'b01; #10;
        s = 2'b10; #10;
        s = 2'b11; #10;
    
        $finish;
    end
endmodule

// MUX와 DEMUX를 연동하여 테스트하는 회로 모듈
module mux_demux_test (
    input [3:0] d,       // MUX 입력 (4비트): d[0], d[1], d[2], d[3]
    input [1:0] mux_s,   // MUX 선택 신호 (2비트): 4개의 입력 중 선택
    input [1:0] demux_s, // DEMUX 선택 신호 (2비트): 출력 중 어느 한 곳으로 보내는지 선택
    output [3:0] f        // DEMUX 출력 (4비트): 실제로는 wire가 되어야 함 (입력이 아닌 출력)
);

    wire mux_f;          // MUX의 출력 → DEMUX의 입력으로 연결됨

    // 4:1 MUX 인스턴스
    mux_4_1_behavioral mux4(
        .d(d),       // 4개의 입력 신호
        .s(mux_s),   // 선택 신호
        .f(mux_f)    // 선택된 입력이 mux_f로 출력됨
    );
    
    // 1:4 DEMUX 인스턴스
    demux_1_4_d demux4(
        .d(mux_f),     // MUX의 출력이 DEMUX의 입력으로 전달됨
        .s(demux_s),   // 선택 신호
        .f(f)          // 선택된 출력에만 mux_f 값이 전달됨
    );

endmodule




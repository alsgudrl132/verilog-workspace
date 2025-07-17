`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 11:29:37 AM
// Design Name: 
// Module Name: decoder
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


// 2-to-4 디코더 모듈 (Behavioral 방식)
module decoder_2x4_behavioral(
    input [1:0] code,        // 2비트 입력 신호 (00~11)
    output reg [3:0] signal  // 4비트 출력 신호 (선택된 하나의 비트만 1)
    );
    
    // 입력 code가 변경될 때마다 항상 블록 실행
    always @(code) begin
        if(code == 2'b00)        // 입력이 00일 경우
            signal = 4'b0001;    // 출력: 첫 번째 비트만 1
        else if(code == 2'b01)   // 입력이 01일 경우
            signal = 4'b0010;    // 출력: 두 번째 비트만 1
        else if(code == 2'b10)   // 입력이 10일 경우
            signal = 4'b0100;    // 출력: 세 번째 비트만 1
        else                     // 입력이 11일 경우
            signal = 4'b1000;    // 출력: 네 번째 비트만 1
    end
endmodule

module decoder_2x4_dataflow (
    input [1:0] code,
    output [3:0] signal
);  

    assign signal = (code == 2'b00) ? 4'b0001 : (code == 2'b01) ? 4'b0010 : (code == 2'b10) ? 4'b0100 : 4'b1000;

endmodule


module decoder_2x4_dataflow_d (
    input [1:0] code,
    output [3:0] signal
);  
    assign signal[0] = (~code[1]) & (~code[0]);
    assign signal[1] = (~code[1]) & (code[0]);
    assign signal[2] = (code[1]) & (~code[0]);
    assign signal[3] = (code[1]) & (code[0]);
endmodule

module decoder_2x4_structual (
    input [1:0] code,
    output [3:0] signal
);
    wire n0, n1;     // NOT 신호
    
    not u_not0 (n0, code[0]);
    not u_not1 (n1, code[1]);
    
    and u_and0 (signal[0], n1, n0);
    and u_and1 (signal[1], n1, code[0]);
    and u_and2 (signal[2], code[1], n0);
    and u_and3 (signal[3], code[1], code[0]);

endmodule

module decoder_7seg(
    input [3:0] hex_value,
    output reg [7:0] seg_7,
    output reg [3:0] com_an
    );
    
    always @(hex_value)begin
        com_an = 4'b0000;
        case (hex_value)
            4'b0000 : seg_7 = 8'b11000000; //0
            4'b0001 : seg_7 = 8'b11111001; //1
            4'b0010 : seg_7 = 8'b10100100; //2
            4'b0011 : seg_7 = 8'b10110000; //3
            4'b0100 : seg_7 = 8'b10011001; //4
            4'b0101 : seg_7 = 8'b10010010; //5
            4'b0110 : seg_7 = 8'b10000010; //6
            4'b0111 : seg_7 = 8'b11111000; //7
            4'b1000 : seg_7 = 8'b10000000; //8
            4'b1001 : seg_7 = 8'b10011000; //9
            4'b1010 : seg_7 = 8'b10001000; //A
            4'b1011 : seg_7 = 8'b10000011; //b
            4'b1100 : seg_7 = 8'b11000110; //C
            4'b1101 : seg_7 = 8'b10100001; //d
            4'b1110 : seg_7 = 8'b10000110; //E
            4'b1111 : seg_7 = 8'b10001110; //F
        
        endcase
    end
endmodule

module encoder_4x2_behavioral(
    output reg [1:0] code,  // 2비트 출력 : 입력중에 켜진 위치를 이진수로 출력
    input [3:0] signal      // 4비트 입력 : 4개의 신호중에 하나가 1이라고 가정
);

    always @(signal)begin
        // signal -> 0001일때 -> 0번째 입력이 켜진것
        if(signal == 4'b0001) code = 2'b00;     // 출력 code = 0
        else if(signal == 4'b0010) code = 2'b01;
        else if(signal == 4'b0100) code = 2'b10;
        else code = 2'b11;
    end

endmodule

module endocer_4x2_dataflow(
    output [1:0] code,  // 2비트 출력 : 입력중에 켜진 위치를 이진수로 출력
    input [3:0] signal      // 4비트 입력 : 4개의 신호중에 하나가 1이라고 가정
);

    assign code = (signal == 4'b0001) ? 2'b00:
                  (signal == 4'b0010) ? 2'b01:
                  (signal == 4'b0100) ? 2'b10:
                  (signal == 4'b1000) ? 2'b11 : 2'b00;

endmodule

module encoder_4x2_structural (
    output [1:0] code,
    input  [3:0] signal
);

    wire a0, a1;
    // code[1] = signal[2] or signal[3]
    // 입력값이 0100 또는 1000일 경우에 code[1]은 1
    or or1(a1, signal[2], signal[3]);
    
    //code[0] = signal[1] or signal[3] 
    //입력값이 0010 또는 1000일경우느에는 code[0] = 1
    or or0(a0, signal[1], signal[3]);
    
    assign code = {a1, a0}; // code[1]이 상위비트, code[0]이 하위비트

endmodule
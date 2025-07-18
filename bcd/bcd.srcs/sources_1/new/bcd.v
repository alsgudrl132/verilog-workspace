`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 11:47:32 AM
// Design Name: 
// Module Name: bcd
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


// 12비트 이진수를 4자리 BCD로 변환하는 모듈
module bin_to_dec(
    input [11:0] bin,         // 12비트 이진 입력 (최대 값: 4095)
    output reg [15:0] bcd     // 4자리 BCD 출력 (각 자릿수 4비트 × 4 = 16비트)
);
    
    integer i;                // for문에서 사용할 인덱스 변수

    always @(bin) begin       // bin 값이 변할 때마다 동작
        bcd = 0;              // BCD 출력 초기화 (모든 자릿수를 0으로)

        // Dabble 알고리즘 (Shift-Add-3)
        for(i = 0; i < 12; i = i + 1) begin

            // 각 BCD 자릿수 값이 5 이상이면 3을 더해줌 (BCD 자리값 보정)
            if (bcd[3:0] >= 5)       bcd[3:0]   = bcd[3:0]   + 3;  // 일의 자리
            if (bcd[7:4] >= 5)       bcd[7:4]   = bcd[7:4]   + 3;  // 십의 자리
            if (bcd[11:8] >= 5)      bcd[11:8]  = bcd[11:8]  + 3;  // 백의 자리
            if (bcd[15:12] >= 5)     bcd[15:12] = bcd[15:12] + 3;  // 천의 자리

            // bcd 전체를 왼쪽으로 1비트 shift + bin의 MSB부터 1비트씩 추가
            bcd = {bcd[14:0], bin[11 - i]};

            // 예: bin = 12'b0000_0011_0010 (50일 때)
            // 반복하면서 BCD로 변환됨: 0000 0000 0000 0000 → ... → 0000 0000 0101 0000 (BCD로 0050)
        end
    end

endmodule


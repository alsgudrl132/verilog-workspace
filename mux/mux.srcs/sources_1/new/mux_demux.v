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

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2025 11:05:17 AM
// Design Name: 
// Module Name: clock_library
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


module clock_div_100 (
    input clk, reset_p,                 // 입력: 시스템 클럭, 리셋
    output reg clk_div_100,             // 출력: 1/100 분주된 클럭
    output nedge_div_100, pedge_div_100 // 출력: 분주된 클럭의 상승/하강 엣지 펄스
    );

    reg [5:0] cnt_sysclk; // 6비트 카운터 (최대 63까지 카운트 가능)

    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            cnt_sysclk = 0;       // 리셋 시 카운터 초기화
            clk_div_100 = 0;      // 분주 클럭도 0으로 초기화
        end
        else begin
            if (cnt_sysclk >= 49) begin
                cnt_sysclk = 0;             // 50번 카운트 되면 초기화
                clk_div_100 = ~clk_div_100; // 분주 클럭 토글 (0→1, 1→0)
            end
            else begin
                cnt_sysclk = cnt_sysclk + 1; // 카운터 증가
            end
        end
    end

    // 엣지 디텍터 인스턴스: 분주된 클럭(clk_div_100)의 상승/하강을 감지
    edge_detector_pos clk_ed (
        .clk(clk), 
        .reset_p(reset_p),
        .cp(clk_div_100), 
        .p_edge(pedge_div_100), 
        .n_edge(nedge_div_100)
    );
endmodule

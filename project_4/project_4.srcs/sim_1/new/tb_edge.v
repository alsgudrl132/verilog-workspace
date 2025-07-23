`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 11:30:07 AM
// Design Name: 
// Module Name: tb_edge
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


// 테스트벤치: 두 모듈의 동작을 확인
module tb_edge_detector;
    reg clk;               // 시스템 클럭
    reg reset_p;           // 리셋 신호
    reg cp;                // 테스트용 클럭 펄스

    wire p_edge_pos, n_edge_pos;  // 양의 엣지 기준 모듈 출력
    wire p_edge_neg, n_edge_neg;  // 음의 엣지 기준 모듈 출력

    // 10ns 주기의 클럭 생성 (5ns마다 반전)
    always #5 clk = ~clk;

    // 양의 엣지 기준 엣지 디텍터 인스턴스
    edge_detector_p uut_p(
        .clk(clk),
        .reset_p(reset_p),
        .cp(cp),
        .p_edge(p_edge_pos),
        .n_edge(n_edge_pos)
    );

    // 음의 엣지 기준 엣지 디텍터 인스턴스
    edge_detector_n uut_n(
        .clk(clk),
        .reset_p(reset_p),
        .cp(cp),
        .p_edge(p_edge_neg),
        .n_edge(n_edge_neg)
    );

    initial begin
        clk = 0;
        reset_p = 1;
        cp = 0;

        #12;
        reset_p = 0;       // 리셋 해제

        #10; cp = 1;       // 상승 엣지
        #20; cp = 0;       // 하강 엣지
        #15; cp = 1;       // 상승 엣지
        #25; cp = 0;       // 하강 엣지
        #25;

        $finish;           // 시뮬레이션 종료
    end
endmodule

module tb_ring_counter;
    reg clk;
    reg reset_p;
    wire [3:0] q;
    
    ring_counter uut (
        .clk(clk),
        .reset_p(reset_p),
        .q(q)
    );
    
    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        reset_p = 1;
        
        #10 reset_p = 0;
        
        #100;
        
        // 강제로 주입
        force uut.q = 4'b0110;
        #10;
        release uut.q;
        // default 동작 ???
        #50; 
        $finish;
    end
endmodule

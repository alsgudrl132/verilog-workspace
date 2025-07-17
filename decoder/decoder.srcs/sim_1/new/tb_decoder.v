`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 11:41:58 AM
// Design Name: 
// Module Name: tb_decoder
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


// 2-to-4 디코더 테스트벤치
module tb_decoder;
    reg [1:0] code;           // 테스트할 입력 값 (2비트)
    wire [3:0] signal;        // 디코더 출력 (4비트)

    // 테스트할 디코더 인스턴스 생성 (DUT: Device Under Test)
    decoder_2x4_behavioral uut (
        .code(code),          // 입력 신호 연결
        .signal(signal)       // 출력 신호 연결
    );

    // 시뮬레이션 초기 블록
    initial begin
        // 결과 출력 포맷 지정
        $display("Time\t code\tbehavioral");
        $monitor("%0t\t %d\t%d", $time, code, signal);

        // 각 입력 조합을 10ns 간격으로 적용
        code = 2'b00; #10;    // 출력: 0001
        code = 2'b01; #10;    // 출력: 0010
        code = 2'b10; #10;    // 출력: 0100
        code = 2'b11; #10;    // 출력: 1000

        // 시뮬레이션 종료
        $finish;
    end
endmodule

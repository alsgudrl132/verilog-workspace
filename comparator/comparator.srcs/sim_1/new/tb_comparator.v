`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 10:21:03 AM
// Design Name: 
// Module Name: tb_comparator
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

module tb_comparator;
    // 입력 신호 선언 (테스트할 값)
    reg a, b;

    // 출력 신호 선언 (비교 결과)
    wire equal, greator, less;

    // 테스트할 모듈 인스턴스화 (Dataflow 방식 비교기)
    comparator_dataflow uut(
        .a(a),
        .b(b),
        .equal(equal),
        .greator(greator),
        .less(less)
    );

    initial begin
        // 시뮬레이션 결과의 헤더 출력
        $display("Time\t a b | equals greator less");

        // 시뮬레이션 진행 중 입력과 출력 변화를 실시간 모니터링
        $monitor("%0t\t %b %b | %b %b %b", $time, a, b, equal, greator, less);
        
        // 테스트 입력 패턴 적용 (a와 b의 모든 조합)
        a = 0; b = 0; #10;   // 0과 0을 비교
        a = 0; b = 1; #10;   // 0과 1을 비교
        a = 1; b = 0; #10;   // 1과 0을 비교
        a = 1; b = 1; #10;   // 1과 1을 비교

        // 시뮬레이션 종료
        $finish;
    end 
endmodule

// 4비트 비교기를 테스트하는 테스트벤치 모듈
module tb_comparator_4bit_full;
    reg [3:0] a, b;                 // 테스트 입력 신호 (4비트)
    wire equal, greator, less;     // 테스트 출력 신호

    // 테스트 대상 장치(DUT)로 N=4 설정하여 인스턴스화
    comparator_Nbit #(.N(4)) dut(
        .a(a),
        .b(b),
        .equal(equal),
        .greator(greator),
        .less(less)
    );
    
    integer i, j; // 반복문을 위한 변수 선언
    
    initial begin
        // 시뮬레이션 결과의 헤더 출력
        $display("Time\t a\t b\t |\tequal\tgreator\tless");

        // 값이 바뀔 때마다 현재 시간과 신호 값 출력
        $monitor("%4t\t %b\t %b\t |\t%b\t%b\t%b", $time, a, b, equal, greator, less);
        
        // 4비트이므로 a, b는 0 ~ 15까지 총 256가지 조합을 테스트
        for(i = 0; i < 16; i = i + 1) begin
            for(j = 0; j < 16; j = j + 1) begin
                a = i;
                b = j;
                #5; // 각 입력 조합에 대해 5ns 지연 후 출력 관찰
            end
        end     
        
        // 시뮬레이션 종료
        $finish;
    end
endmodule
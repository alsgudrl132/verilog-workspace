`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/17/2025 03:48:39 PM
// Design Name: 
// Module Name: tb_mux_2_1
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


module tb_mux_2_1;
    reg [1:0] d;   // 2비트 입력: d[0], d[1]
    reg s;         // 선택 신호(select)
    wire f;        // 출력 신호

    // 테스트할 MUX 모듈 인스턴스화
    mux_2_1 uut(
        .d(d),  // 입력 연결
        .s(s),  // 선택 신호 연결
        .f(f)   // 출력 연결
    );

    // 시뮬레이션 동작 정의
    initial begin
        $monitor("time=%0t | s=%b | d=%b | f=%b", $time, s, d, f);  
        // 시간, 선택 신호, 입력, 출력 상태 출력

        d = 2'b10; s = 0; #10;  // s=0이면 f=d[0] → 0 출력
                       s = 1; #10;  // s=1이면 f=d[1] → 1 출력

        d = 2'b01; s = 0; #10;  // s=0이면 f=d[0] → 1 출력
                       s = 1; #10;  // s=1이면 f=d[1] → 0 출력

        $finish;  // 시뮬레이션 종료
    end
endmodule

// 8:1 멀티플렉서 테스트벤치
module tb_mux_8_1;
    reg [7:0] d;      // 8비트 입력 벡터: d[7] ~ d[0]
    reg [2:0] s;      // 선택선 (3비트): 0~7 중 하나의 인덱스를 선택
    wire f;           // 출력: 선택된 d[s]의 값

    // 테스트할 멀티플렉서 인스턴스 연결
    mux_8_1 uut (
        .d(d),        // 입력 신호 연결
        .s(s),        // 선택선 연결
        .f(f)         // 출력 신호 연결
    );

    initial begin
        // 시뮬레이션 중 출력 모니터링: 시간, 선택선, 입력, 출력 표시
        $monitor("Time=%0t | s=%b | d=%b | f=%b", $time, s, d, f);
        
        // 입력 데이터 설정
        d = 8'b11001010;  // d[7]=1, d[6]=1, d[5]=0, ..., d[0]=0

        // 선택선 s 값을 변화시키며 테스트 진행
        s = 3'b000; #10;  // d[0] 선택 → f = d[0]
        s = 3'b001; #10;  // d[1] 선택 → f = d[1]
        s = 3'b010; #10;  // d[2] 선택 → f = d[2]
        s = 3'b011; #10;  // d[3] 선택 → f = d[3]
        s = 3'b100; #10;  // d[4] 선택 → f = d[4]
        s = 3'b101; #10;  // d[5] 선택 → f = d[5]
        s = 3'b110; #10;  // d[6] 선택 → f = d[6]
        s = 3'b111; #10;  // d[7] 선택 → f = d[7]

        // 시뮬레이션 종료
        $finish;
    end
endmodule

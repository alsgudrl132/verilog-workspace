`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2025 12:14:33 PM
// Design Name: 
// Module Name: tb_dht11_cntr
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


module tb_dht11_cntr();

    //=============================
    // 테스트용 상수 데이터 (DHT11 모의 데이터)
    //=============================
    localparam [7:0] humi_value = 8'd70;   // 습도 정수부
    localparam [7:0] tmpr_value = 8'd25;   // 온도 정수부
    localparam [7:0] check_sum = humi_value + tmpr_value; // 체크섬
    localparam [39:0] data = {humi_value, 8'd0, tmpr_value, 8'd0, check_sum}; 
    // DHT11 40bit 데이터 구성: [습도8][습도소수8][온도8][온도소수8][체크섬8]

    //=============================
    // 신호 선언
    //=============================
    reg clk, reset_p;                     // 클럭, 리셋
    wire [7:0] humidity, temperature;     // DUT에서 출력되는 습도/온도
    reg dout, wr_e;                       // 테스트벤치에서 DHT11 신호를 제어할 용도
    tri1 dht11_data;                      // DHT11 데이터 핀 (tri-state)
    assign dht11_data = wr_e ? dout : 'bz; // wr_e=1일 때 출력, 아니면 high-Z

    //=============================
    // DUT 인스턴스
    //=============================
    dht11_cntr DUT(
        clk, reset_p,
        dht11_data,                        
        humidity, temperature                        
    );

    //=============================
    // 초기 클럭과 리셋
    //=============================
    initial begin
        clk = 0;
        reset_p = 1;  // 초기 리셋
        wr_e = 0;     // 데이터 출력 비활성화
    end

    // 10ns 주기 클럭 생성 (100MHz)
    always #5 clk = ~clk;

    integer i; // for loop용 변수

    //=============================
    // DHT11 데이터 시뮬레이션
    //=============================
    initial begin
        #10;
        reset_p = 0; #10;           // 리셋 해제
        wait(!dht11_data);           // DHT11이 Low가 될 때까지 대기 (응답 신호 시작)
        wait(dht11_data);            // DHT11이 High 될 때까지 대기
        #20_000;                     // 20,000ns 대기 (응답 High 유지)

        // 초기 Start 신호 시뮬레이션
        dout = 0; wr_e = 1; #80_000; // MCU가 80us 동안 Low 신호 출력
        wr_e = 0; #80_000;            // 출력 해제, DHT11이 High로 응답
        wr_e = 1;                      // 다시 출력 모드

        //=============================
        // 40bit 데이터 전송
        //=============================
        for(i = 0; i < 40; i = i + 1) begin
            dout = 0; #50_000;           // bit 시작: 50us Low
            dout = 1;                     // bit High 펄스
            if(data[39-i])                // 1bit이면 70us High
                #70_000;
            else                          // 0bit이면 27us High
                #27_000;
        end

        // 데이터 전송 종료
        dout = 0; #10;
        wr_e = 0; #1000;

        $stop; // 시뮬레이션 정지
    end

endmodule


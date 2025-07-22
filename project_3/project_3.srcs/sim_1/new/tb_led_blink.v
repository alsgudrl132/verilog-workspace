`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2025 09:32:36 AM
// Design Name: 
// Module Name: tb_led_blink
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


module tb_led_blink;
    reg clk;
    reg reset;
    wire [7:0] led;
    
    led_blink_1s dut(
        .clk(clk),
        .reset(reset),
        .led(led)
    );
    
    // 클럭 생성: 100MHz (10ns 주기)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // 리셋 초기화
    initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    // 시뮬레이션 시간 제한: 10초 (100MHz 기준으로 1초 = 100,000,000ns)
    initial begin
        #(100_000_000 * 10);    // 10초 시뮬레이션
        $finish;
    end
    
endmodule


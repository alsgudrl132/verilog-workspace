`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 02:59:21 PM
// Design Name: 
// Module Name: fnd
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


`timescale 1ns / 1ps
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 디지털 시계 설계 (100MHz 입력 -> 1Hz 분주 -> 분/초 카운트 -> 7세그먼트 출력)
// 주요 기능:
// - 1Hz 클럭 생성 (clock_divider_1Hz)
// - 분/초 카운트 (time_counter)
// - 2KHz 클럭 생성 및 디스플레이 스캔 (clock_divider_2KHz + display_scan_controller)
// - BCD -> 7세그먼트 변환 (seg_decoder)
// - 자릿수 스캔용 애노드 제어 (anode_selector)
// - 최상위 모듈: digital_clock_top
//////////////////////////////////////////////////////////////////////////////////

// 100MHz 클럭을 1Hz로 분주
module clock_divider_1Hz(
    input clk,
    input reset_p,
    output reg clk_1Hz
);
    reg [26:0] count; // 50_000_000 클럭 주기까지 셈 (0.5초에 반전 → 1Hz)

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            count <= 0;
            clk_1Hz <= 0;
        end else begin
            if (count == 49_999_999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz; // 1초 주기 토글
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule

// 초(00~59), 분(00~59) BCD 카운터
module time_counter(
    input clk_1Hz,
    input reset_p,
    output reg [3:0] sec_ones,   // 초 1의 자리
    output reg [3:0] sec_tens,   // 초 10의 자리
    output reg [3:0] min_ones,   // 분 1의 자리
    output reg [3:0] min_tens    // 분 10의 자리
);
    // 초 카운트
    always @(posedge clk_1Hz or posedge reset_p) begin
        if (reset_p) begin
            sec_ones <= 0;
            sec_tens <= 0;
        end else begin
            if (sec_ones == 9) begin
                sec_ones <= 0;
                if (sec_tens == 5) sec_tens <= 0;
                else sec_tens <= sec_tens + 1;
            end else begin
                sec_ones <= sec_ones + 1;
            end
        end
    end

    // 분 카운트 (초가 59일 때만 증가)
    always @(posedge clk_1Hz or posedge reset_p) begin
        if (reset_p) begin
            min_ones <= 0;
            min_tens <= 0;
        end else if (sec_tens == 5 && sec_ones == 9) begin
            if (min_ones == 9) begin
                min_ones <= 0;
                if (min_tens == 5) min_tens <= 0;
                else min_tens <= min_tens + 1;
            end else begin
                min_ones <= min_ones + 1;
            end
        end
    end
endmodule

// 100MHz 클럭을 2KHz로 분주 (세그먼트 스캔용)
module clock_divider_2KHz (
    input clk,
    input reset_p,
    output reg clk_2KHz
);
    reg [15:0] count;

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            count <= 0;
            clk_2KHz <= 0;
        end else begin
            if (count == 24_999) begin
                count <= 0;
                clk_2KHz <= ~clk_2KHz;
            end else begin
                count <= count + 1;
            end
        end
    end 
endmodule

// 2KHz 클럭으로 4개의 자릿수를 순차 스캔
module display_scan_controller (
    input scan_clk,
    input reset_p,
    input [3:0] sec_ones,   // 초 1의 자리
    input [3:0] sec_tens,   // 초 10의 자리
    input [3:0] min_ones,   // 분 1의 자리
    input [3:0] min_tens,   // 분 10의 자리
    output reg [1:0] scan_count,      // 스캔 카운터 (0~3)
    output reg [3:0] select_digit     // 현재 선택된 자릿수의 값
);
    always @(posedge scan_clk or posedge reset_p) begin
        if (reset_p) scan_count <= 0;
        else scan_count <= scan_count + 1;
    end

    always @(*) begin
        case (scan_count)
            2'd0 : select_digit = sec_ones;  // 오른쪽부터
            2'd1 : select_digit = sec_tens;
            2'd2 : select_digit = min_ones;
            2'd3 : select_digit = min_tens;
            default : select_digit = 0;
        endcase
    end
endmodule

// BCD 값(0~9)을 7세그먼트(공통 애노드)로 디코딩
module seg_decoder (
    input [3:0] digit_in,
    output reg [7:0] seg_out
);
    always @(*) begin
        case (digit_in)
            4'd0 : seg_out = 8'b1100_0000;
            4'd1 : seg_out = 8'b1111_1001;
            4'd2 : seg_out = 8'b1010_0100;
            4'd3 : seg_out = 8'b1011_0000;
            4'd4 : seg_out = 8'b1001_1001;
            4'd5 : seg_out = 8'b1001_0010;
            4'd6 : seg_out = 8'b1000_0010;
            4'd7 : seg_out = 8'b1111_1000;
            4'd8 : seg_out = 8'b1000_0000;
            4'd9 : seg_out = 8'b1001_0000;
            default : seg_out = 8'b1111_1111; // 꺼짐
        endcase
    end
endmodule

// 스캔 중인 자릿수에 맞춰 애노드 제어 (공통 애노드용)
module anode_selector (
    input [1:0] scan_count,
    output reg [3:0] an_out
);
    always @(*) begin
        case (scan_count)
            2'd0 : an_out = 4'b1110; // 첫 번째 자리
            2'd1 : an_out = 4'b1101; // 두 번째 자리
            2'd2 : an_out = 4'b1011; // 세 번째 자리
            2'd3 : an_out = 4'b0111; // 네 번째 자리
            default : an_out = 4'b1111; // 모두 끔
        endcase
    end
endmodule

// 최상위 디지털 시계 모듈 (전체 연결)
module digital_clock_top (
    input clk,            // 100MHz 입력 클럭
    input reset_p,        // 비동기 리셋
    output [7:0] seg,     // 세그먼트 출력 (a~g, dp)
    output [3:0] an       // 애노드 출력 (4자리)
);
    // 내부 연결선
    wire clk_1Hz;
    wire scan_clk_2KHz;
    wire [3:0] sec_ones_out, sec_tens_out;
    wire [3:0] min_ones_out, min_tens_out;
    wire [1:0] scan_count_out;
    wire [3:0] select_digit;

    // 모듈 인스턴스 연결
    clock_divider_1Hz u1(
        .clk(clk),
        .reset_p(reset_p),
        .clk_1Hz(clk_1Hz)
    );

    time_counter u2(
        .clk_1Hz(clk_1Hz),
        .reset_p(reset_p),
        .sec_ones(sec_ones_out),
        .sec_tens(sec_tens_out),  // ← 오타 수정 필요: sec_tesn_out → sec_tens_out
        .min_ones(min_ones_out),
        .min_tens(min_tens_out)
    );

    clock_divider_2KHz u3(
        .clk(clk),
        .reset_p(reset_p),
        .clk_2KHz(scan_clk_2KHz)
    );

    display_scan_controller u4(
        .scan_clk(scan_clk_2KHz),
        .reset_p(reset_p),
        .sec_ones(sec_ones_out),
        .sec_tens(sec_tens_out),
        .min_ones(min_ones_out),
        .min_tens(min_tens_out),
        .scan_count(scan_count_out),
        .select_digit(select_digit)
    );

    seg_decoder u5(
        .digit_in(select_digit),
        .seg_out(seg)
    );

    anode_selector u6(
        .scan_count(scan_count_out),
        .an_out(an)
    );
endmodule

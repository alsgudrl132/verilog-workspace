`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/21/2025 04:37:56 PM
// Design Name: 
// Module Name: study
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


module edge_detector_study(
    input clk, reset_p, cp,
    output reg pedge, nedge
);
    reg ff_cur, ff_old; // cp의 현재 상태, 직전 상태

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
            pedge  <= 0;
            nedge  <= 0;
        end else begin
            ff_cur <= cp;
            ff_old <= ff_cur;

            pedge <= (~ff_old & ff_cur); // 0->1
            nedge <= ( ff_old & ~ff_cur); // 1->0
        end
    end
endmodule

module div_1s_study(
    input clk, reset_p,
    output reg clk_div_1s,
    output div_1s_pedge, div_1s_nedge
);
    reg [25:0] count;
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            count = 0;
            clk_div_1s = 0;
        end
        else begin
            if(count >= 49999999) begin
                count = 0;
                clk_div_1s = ~clk_div_1s;
            end
            else begin
                count = count + 1;
            end
        end
    end
    
    edge_detector_study ed(.clk(clk), .reset_p(reset_p), .cp(clk_div_1s), .pedge(div_1s_pedge), .nedge(div_1s_nedge));
endmodule

module led_top_study(
    input clk, reset_p,
    output reg [1:0] led
);

    wire clk_1s;
    wire pe, ne;

    div_1s_study div(
        .clk(clk),
        .reset_p(reset_p),
        .clk_div_1s(clk_1s),
        .div_1s_pedge(pe),
        .div_1s_nedge(ne)
    );

    always @(posedge clk or posedge reset_p) begin
        if(reset_p)
            led <= 2'b00;
        else begin
            if(pe)        // 상승 에지에서 LED[0] 토글
                led[0] <= ~led[0];
            if(ne)        // 하강 에지에서 LED[1] 토글
                led[1] <= ~led[1];
        end
    end
endmodule

module sound_led_study_top(
    input clk,             // FPGA 시스템 클럭
    input reset_p,         // 리셋 버튼 (active high)
    input sound_in,        // 사운드 센서 디지털 출력 (DO 핀 연결)
    output reg [15:0] led  // 16개 LED 출력
);

    // 소리를 감지하면 LED에 표시 (토글 효과)
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            led <= 16'b0;  // 리셋 시 LED OFF
        end else begin
            if (sound_in) begin
                // 소리 감지되면 LED shift left
                led <= {led[14:0], 1'b1};
            end else begin
                // 소리 없으면 그대로 유지
                led <= led;
            end
        end
    end

endmodule


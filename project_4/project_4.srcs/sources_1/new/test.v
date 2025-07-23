`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 11:24:55 AM
// Design Name: 
// Module Name: test
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


// 음의 엣지를 기준으로 cp 신호의 상승/하강 엣지를 검출하는 모듈
module edge_detector_n(
    input clk,             // 시스템 클럭
    input reset_p,         // 비동기 리셋 (양의 엣지에서 동작)
    input cp,              // 클럭 펄스 신호 (엣지 검출 대상)
    output p_edge,         // 상승 엣지 발생 시 1
    output n_edge          // 하강 엣지 발생 시 1
    );

    reg ff_cur, ff_old;    // 이전 상태 저장 레지스터

    // clk의 **음의 엣지**에서 cp 상태 저장
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end

    // ff_old = 1, ff_cur = 0 => 하강 엣지
    // ff_old = 0, ff_cur = 1 => 상승 엣지
    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0;
endmodule

// 양의 엣지를 기준으로 cp 신호의 상승/하강 엣지를 검출하는 모듈
module edge_detector_p(
    input clk,             // 시스템 클럭
    input reset_p,         // 비동기 리셋 (양의 엣지에서 동작)
    input cp,              // 클럭 펄스 신호 (엣지 검출 대상)
    output p_edge,         // 상승 엣지 발생 시 1
    output n_edge          // 하강 엣지 발생 시 1
    );

    reg ff_cur, ff_old;    // 이전 상태 저장 레지스터

    // clk의 **양의 엣지**에서 cp 상태 저장
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end

    // ff_old = 1, ff_cur = 0 => 하강 엣지
    // ff_old = 0, ff_cur = 1 => 상승 엣지
    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0;
endmodule

// 1개의 비트가 정해진 순서대로 한비트씩 이동 순환
module ring_counter (
    input clk,
    input reset_p,
    output reg [3:0] q
);

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 4'b0001;   // 초기값 0001 설정
        end
        else begin
            case (q)
                4'b0001 : q <= 4'b0010;
                4'b0010 : q <= 4'b0100;
                4'b0100 : q <= 4'b1000;
                4'b1000 : q <= 4'b0001;
                default : q <= 4'b0001; // 문제 생기면 초기값으로
            endcase
        end
    end
endmodule

module ring_counter_shift(
    input clk, reset_p,
    output reg [3:0] q
);

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 4'b0001;
        end
        else begin
            if (q == 4'b1000) q <= 4'b0001;
            else if (q == 4'b0000 || q > 4'b1000) q <= 4'b0001;
            else q <= {q[2:0], 1'b0};
        end
        
    end


endmodule

module ring_count_fnd (
    input clk,
    input reset_p,
    output reg [3:0] q
);
    reg [16:0] clk_div;     // 17비트면 10만 이상
    // 클럭 분주
    always @(posedge clk) begin
        clk_div <= clk_div + 1;
    end
    
    wire clk_div_16_p;
    
    edge_detector_n ed(
        .clk(clk),
        .reset_p(reset_p),
        .cp(clk_div[4]),
        .p_edge(clk_div_16_p)
    );
    
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 4'b1110;
        end
        else if(clk_div_16_p) begin
            if (q <= 4'b0111)
                q <= 4'b1110;
            else q <= {q[2:0], 1'b1}; 
        end
    end

endmodule

module ring_counter_led (
    input clk,
    input reset_p,
    output reg [15:0] led
);

    // 21비트 클럭 분주용 카운터
    reg [20:0] clk_div = 0;

    always @(posedge clk) begin
        clk_div <= clk_div + 1;
    end

    wire clk_div_20_p;

    // clk_div[20]의 상승엣지 검출기
    edge_detector_p ed(
        .clk(clk),
        .reset_p(reset_p),
        .cp(clk_div[20]),
        .p_edge(clk_div_20_p)
    );

    always @(posedge clk or posedge reset_p) begin
        if (reset_p)
            led <= 16'b0000_0000_0000_0001;  // 초기값: 첫 번째 LED on
        else if (clk_div_20_p)
            led <= {led[14:0], led[15]};     // 왼쪽으로 회전 (ring counter)
    end

endmodule

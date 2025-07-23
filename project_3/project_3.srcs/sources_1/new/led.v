`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2025 09:23:38 AM
// Design Name: 
// Module Name: led
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


module led_blink_1s(
    input clk,                // 입력 클럭 (예: 100MHz)
    input reset,              // 비동기 리셋
    output reg [7:0] led      // 8비트 LED 출력
    );
    
    reg clk_1Hz;              // 내부적으로 만든 1Hz 클럭
    reg [26:0] count;         // 카운터: 27비트 → 최대 약 1억까지 카운트 가능
    
    // 1Hz 클럭 생성 로직
    // 100MHz 입력 클럭 기준: 0.5초 동안 50,000,000 카운트 → 1Hz 주기 생성
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;       // 리셋 시 카운터 초기화
            clk_1Hz <= 0;     // 1Hz 클럭도 초기화
        end else begin
            if(count == 49999999) begin
                count <= 0;         // 카운터 초기화
                clk_1Hz <= ~clk_1Hz; // 1Hz 클럭 토글
            end
            else begin
                count <= count + 1; // 카운트 증가
            end
        end
    end
    
    // 1Hz 클럭 상승 에지마다 LED 반전
    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b00000000;     // 리셋 시 모든 LED 꺼짐
        end else begin
            led <= ~led;            // LED 반전 (켜진 LED는 꺼지고, 꺼진 LED는 켜짐)
        end
    end
endmodule

module led_shift_L (
    input clk,                // 입력 클럭 (예: 100MHz)
    input reset,              // 비동기 리셋
    output reg [7:0] led      // 8비트 LED 출력
    );
    
    reg clk_1Hz;              // 내부적으로 만든 1Hz 클럭
    reg [26:0] count;         // 카운터: 27비트 → 최대 약 1억까지 카운트 가능

    
    // 1Hz 클럭 생성 로직
    // 100MHz 입력 클럭 기준: 0.5초 동안 50,000,000 카운트 → 1Hz 주기 생성
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;       // 리셋 시 카운터 초기화
            clk_1Hz <= 0;     // 1Hz 클럭도 초기화
        end else begin
            if(count == 49999999) begin
                count <= 0;         // 카운터 초기화
                clk_1Hz <= ~clk_1Hz; // 1Hz 클럭 토글
            end
            else begin
                count <= count + 1; // 카운트 증가
            end
        end
    end
    
    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b00000001; 
        end else begin
            led <= led << 1;
        end
    end

endmodule

module button_led (
    input clk,
    input reset,
    input btn_L,
    input btn_R,
    output reg [7:0] led
);
    
    always @(posedge clk or posedge reset) begin
        if(reset) led <= 8'b00000000;
        else begin
            if(btn_L)led <= 8'b00000000;
            else if(btn_R)led <= 8'b11111111;
        end
    end

endmodule

module debounce (
    input clk,
    input reset,
    input noise_btn,
    output reg clean_btn
);

    reg [16:0] cnt;
    reg btn_sync_0, btn_sync_1;
    reg btn_state;

    // 2단 동기화
    always @(posedge clk) begin
        btn_sync_0 <= noise_btn;
        btn_sync_1 <= btn_sync_0;
    end

    // 디바운스 로직
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            cnt <= 0;
            btn_state <= 0;
            clean_btn <= 0;
        end else begin
            if (btn_sync_1 == btn_state) begin
                cnt <= 0;           // 입력이 이전 상태와 같으면: 안정된 상태 -> 카운터 리셋
            end else begin
                cnt <= cnt + 1;     // 이전상태와 다르면 카운트 증가

                if (cnt >= 100_000) begin  // 1ms 유지 확인
                    btn_state <= btn_sync_1;
                    clean_btn <= btn_sync_1;
                    cnt <= 0;
                end
            end
        end
    end
endmodule


module btn_led_blink (
    input clk,
    input reset,
    input btn_L,
    input btn_R,
    output reg [7:0] led
);

    wire btn_L_clean;
    wire btn_R_clean;
    
    reg clk_1Hz;              // 내부적으로 만든 1Hz 클럭
    reg [26:0] count;         // 카운터: 27비트 → 최대 약 1억까지 카운트 가능

    debounce U1(
        .clk(clk), .reset(reset),
        .noise_btn(btn_L),          // 원래 버튼
        .clean_btn(btn_L_clean)     // 디바운싱된 출력
    );

    debounce U2(
        .clk(clk), .reset(reset),
        .noise_btn(btn_R),          // 원래 버튼
        .clean_btn(btn_R_clean)     // 세탁된 버튼 출력
    );

    // 1Hz 클럭 생성 로직
    // 100MHz 입력 클럭 기준: 0.5초 동안 50,000,000 카운트 → 1Hz 주기 생성
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;       // 리셋 시 카운터 초기화
            clk_1Hz <= 0;     // 1Hz 클럭도 초기화
            led <= 8'b0000_0000;
        end else begin
            if(count == 49999999) begin
                count <= 0;         // 카운터 초기화
                clk_1Hz <= ~clk_1Hz; // 1Hz 클럭 토글
            end
            else begin
                count <= count + 1; // 카운트 증가
            end
        end
    end
    
    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b00000001; 
        end else if (btn_L_clean) begin
            led <= led << 1;
        end else if (btn_R_clean) begin
            led <= led >> 1;
        end
    end

endmodule

module led_shift_debounce (
    input clk,                // 입력 클럭 (예: 100MHz)
    input reset,              // 비동기 리셋
    input btn_L,              // 왼쪽 버튼
    input btn_R,              // 오른쪽 버튼
    output reg [7:0] led      // 8비트 LED 출력
    );

    reg clk_1Hz;              // 내부적으로 만든 1Hz 클럭
    reg [26:0] count;         // 카운터: 100MHz 기준 약 0.5초 주기
    reg flag;                 // 방향 플래그 (1: left, 0: right)

    wire btn_L_clean;         // 디바운싱된 왼쪽 버튼
    wire btn_R_clean;         // 디바운싱된 오른쪽 버튼

    // 디바운싱 모듈 인스턴스
    debounce U1(
        .clk(clk), .reset(reset),
        .noise_btn(btn_L),
        .clean_btn(btn_L_clean)
    );

    debounce U2(
        .clk(clk), .reset(reset),
        .noise_btn(btn_R),
        .clean_btn(btn_R_clean)
    );

    // 1Hz 클럭 생성 (100MHz 입력 기준)
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            clk_1Hz <= 0;
        end else begin
            if(count == 49999999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz;
            end else begin
                count <= count + 1;
            end
        end
    end

    // 방향 설정: 버튼 누를 때마다 갱신
    always @(posedge clk) begin
        if(reset) begin
            flag <= 1;  // 초기값: 왼쪽
        end else begin
            if(btn_L_clean)
                flag <= 1;  // 왼쪽 이동
            else if(btn_R_clean)
                flag <= 0;  // 오른쪽 이동
        end
    end

    // LED 이동: 1Hz 클럭 기준으로 주기적 이동
    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b00000001;
        end else begin
            if(flag)
                led <= led << 1;
            else
                led <= led >> 1;
        end
    end

endmodule

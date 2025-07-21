`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 02:35:12 PM
// Design Name: 
// Module Name: flip_flop
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


module d_flip_flop(
    input clk,      //클럭 입력
    input d,        //데이터 입력
    output reg q    //출력
    );
    
    always @(posedge clk) begin // 상승엣지 일때
        q <= d;     // q에 d를 저장
    end 
endmodule

module d_flip_flop_n (
    input d,
    input clk,
    input reset_p,  // 비동기식 리셋 신호
    input enable,
    output reg q
);
    always @(negedge clk or posedge reset_p) begin
        // 비동기 신호인 reset_p가 1이되면 즉시 q를 0으로
        if(reset_p)
            q <= 0;
        else if(enable) // enable이 1일때만 d를 q로 저장
            q <= d;     // enable이 0일때는 q를 이전값으로 유지
            
    end
endmodule

module d_flip_flop_p (
    input d,
    input clk,
    input reset_p,
    input enable,
    output reg q
);

    always @(posedge clk or posedge reset_p) begin
        if(reset_p)
            q <= 0;
        else if(enable)
            q <= d;
    end
    
endmodule

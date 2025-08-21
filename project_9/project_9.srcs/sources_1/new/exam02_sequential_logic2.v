`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2025 10:27:47 AM
// Design Name: 
// Module Name: exam02_sequential_logic
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

module D_flip_flop_n(
    input d,
    input clk,
    input enable,
    input reset_p,
    output reg q);

    always @(negedge clk or posedge reset_p)begin
        if(reset_p)begin
            q = 1'b0;
        end
        else if(enable)begin
            q = d;
        end
    end
endmodule

module D_flip_flop_p(
    input d,
    input clk,
    input enable,
    input reset_p,
    output reg q);

    always @(posedge clk or posedge reset_p)begin
        if(!reset_p)begin
            q = 1'b0;
        end
        else if(enable)begin
            q = d;
        end
    end
endmodule

module T_flip_flop_n(
    input clk, reset_p,
    input enable,
    input t,
    output reg q);

    always @(negedge clk, posedge reset_p)begin
        if(reset_p)begin
            q = 0;
        end
        else begin
            if(enable)begin
                if(t) q = ~q;
                else q = q;
            end
        end
    end

endmodule

module T_flip_flop_p(
    input clk, reset_p,
    input enable,
    input t,
    output reg q);

    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            q = 0;
        end
        else begin
            if(enable)begin
                if(t) q = ~q;
                else q = q;
            end
        end
    end

endmodule

module up_counter_asyc(
    input clk, reset_p,
    output [3:0] count);
    
    T_flip_flop_n cnt0(.clk(clk), .reset_p(reset_p), 
        .enable(1'b1), .t(1'b1), .q(count[0]));
    T_flip_flop_n cnt1(.clk(count[0]), .reset_p(reset_p), 
        .enable(1'b1), .t(1'b1), .q(count[1]));
    T_flip_flop_n cnt2(.clk(count[1]), .reset_p(reset_p), 
        .enable(1'b1), .t(1'b1), .q(count[2]));
    T_flip_flop_n cnt3(.clk(count[2]), .reset_p(reset_p), 
        .enable(1'b1), .t(1'b1), .q(count[3]));

endmodule

module down_counter_asyc(
    input clk, reset_p,
    output [3:0] count);
    
    T_flip_flop_p cnt0(.clk(clk), .reset_p(reset_p), 
        .enable(1), .t(1), .q(count[0]));
    T_flip_flop_p cnt1(.clk(count[0]), .reset_p(reset_p), 
        .enable(1'b1), .t(1'b1), .q(count[1]));
    T_flip_flop_p cnt2(.clk(count[1]), .reset_p(reset_p), 
        .enable(1'b1), .t(1'b1), .q(count[2]));
    T_flip_flop_p cnt3(.clk(count[2]), .reset_p(reset_p), 
        .enable(1'b1), .t(1'b1), .q(count[3]));

endmodule

module up_counter_p(
    input clk, reset_p,
    output reg [3:0] count);

    always @(posedge clk, posedge reset_p)begin
        if(reset_p)count = 0;
        else count = count + 1;
    end

endmodule

module up_counter_n(
    input clk, reset_p,
    output reg [3:0] count);

    always @(negedge clk, posedge reset_p)begin
        if(reset_p)count = 0;
        else count = count + 1;
    end

endmodule

module down_counter_p(
    input clk, reset_p,
    output reg [3:0] count);

    always @(posedge clk, posedge reset_p)begin
        if(reset_p)count = 0;
        else count = count - 1;
    end

endmodule

module ring_counter (
    input clk,
    input reset_p,
    output reg [3:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 4'b0001;                   // 초기값 0001 설정
        end

        else begin
            case (q)
                4'b0001 : q <= 4'b0010;
                4'b0010 : q <= 4'b0100;
                4'b0100 : q <= 4'b1000;
                4'b1000 : q <= 4'b0001;
                default : q <= 4'b0001;     // 문제 생기면 초기값으로
            endcase
        end
    end

endmodule

module ring_counter_shift (
    input clk,
    input reset_p,
    output reg [3:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 4'b0001;                   // 초기값 0001 설정
        end

        else begin
                if (q == 4'b1000)
                    q <= 4'b0001;
                else if (q == 4'b0000 || q > 4'b1000)
                    q <= 4'b0001;
                else
                    q <= {q[2:0], 1'b0};
        end
    end

endmodule

module ring_counter_p (
    input clk,
    input reset_p,
    output reg [3:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) q <= 4'b0001;                   // 초기값 0001 설정
        else   q = {q[2:0], q[3]};
    end
endmodule

module ring_counter_led (
    input clk,
    input reset_p,
    output reg [15:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) q <= 4'b0000_0000_0000_0001;                   // 초기값 0001 설정
        else   q = {q[14:0], q[15]};
    end
endmodule

module edge_detector_n(
    input clk,
    input reset_p,
    input cp,

    output p_edge,
    output n_edge

    );

    reg ff_cur, ff_old;

    always @(negedge clk or posedge reset_p) begin
        if(reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end

    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0;
endmodule

module edge_detector_p(
    input clk,
    input reset_p,
    input cp,

    output p_edge,
    output n_edge

    );

    reg ff_cur, ff_old;

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end

    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1'b1 : 1'b0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1'b1 : 1'b0;
endmodule


module edge_detector_pos (
    input clk, reset_p,
    input cp,                  // 감지할 입력 신호
    output reg p_edge,         // 상승 에지 검출
    output reg n_edge          // 하강 에지 검출
);

    reg cp_dly;                // 입력 신호의 1클럭 지연 버퍼

    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            cp_dly <= 0;
            p_edge <= 0;
            n_edge <= 0;
        end
        else begin
            // 에지 검출 결과
            p_edge <= ( cp & ~cp_dly );   // 0 → 1 변화 시
            n_edge <= (~cp &  cp_dly );   // 1 → 0 변화 시
            cp_dly <= cp;                 // 신호 지연
        end
    end

endmodule

module bin_to_dec(
    input [11:0] bin,           // 12비트 이진 입력
    output reg [15:0] bcd       // 4자리의 BCD를 출력 (4비트 x 4자리)
    );

    integer i;      // 반복문

    always @(bin) begin

        bcd = 0;    // initial value

        for(i = 0; i < 12; i = i + 1) begin
            // 1) 알고리즘 각 단위비트 자리별로 5이상이면 +3 해줌
            if(bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;          // 1의 자리수
            if(bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;          // 10의 자리수
            if(bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;       // 100의 자리수
            if(bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] +3;     // 1000의 자리수

            // 2) 1비트 left shift + 새로운 비트 붙임
            bcd = {bcd[14:0], bin[11 - i]};
        end

    end
endmodule

module anode_selector (
    input [1:0] scan_count,
    output reg [3:0] an_out
);
    always @(*) begin
        case (scan_count)
            2'd0: an_out = 4'b1110; // an[0]
            2'd1: an_out = 4'b1101; // an[1]
            2'd2: an_out = 4'b1011; // an[2]
            2'd3: an_out = 4'b0111; // an[3]
            default: an_out = 4'b1111;
        endcase
    end
endmodule

module seg_decoder (
    input [3:0] digit_in,
    output reg [7:0] seg_out
);
    always @(*) begin
        case (digit_in)
                             //pgfe_dcba
            4'd0: seg_out = 8'b1100_0000;   // 0 (dp 꺼짐)
            4'd1: seg_out = 8'b1111_1001; // 1
            4'd2: seg_out = 8'b1010_0100; // 2
            4'd3: seg_out = 8'b1011_0000; // 3
            4'd4: seg_out = 8'b1001_1001; // 4
            4'd5: seg_out = 8'b1001_0010; // 5
            4'd6: seg_out = 8'b1000_0010; // 6
            4'd7: seg_out = 8'b1111_1000; // 7
            4'd8: seg_out = 8'b1000_0000; // 8
            4'd9: seg_out = 8'b1001_0000; // 9
            4'hA: seg_out = 8'b1000_1000; // A
            4'hb: seg_out = 8'b0000_0011; // b
            4'hC: seg_out = 8'b1100_0110; // C
            4'hd: seg_out = 8'b1010_0001; // D
            4'hE: seg_out = 8'b1000_0110; // E
            4'hF: seg_out = 8'b1000_1110; // F
            default: seg_out = 8'b1111_1111;
        endcase
    end
endmodule


//module calculator_seg_decoder (
//    input [3:0] digit_in,
//    output reg [7:0] seg_out
//);
//    always @(*) begin
//        case (digit_in)
//                             //pgfe_dcba
//            4'd0: seg_out = 8'b1100_0000;   // 0 (dp 꺼짐)
//            4'd1: seg_out = 8'b1111_1001; // 1
//            4'd2: seg_out = 8'b1010_0100; // 2
//            4'd3: seg_out = 8'b1011_0000; // 3
//            4'd4: seg_out = 8'b1001_1001; // 4
//            4'd5: seg_out = 8'b1001_0010; // 5
//            4'd6: seg_out = 8'b1000_0010; // 6
//            4'd7: seg_out = 8'b1111_1000; // 7
//            4'd8: seg_out = 8'b1000_0000; // 8
//            4'd9: seg_out = 8'b1001_0000; // 9
//            4'hA: seg_out = 8'b1000_1000; // A
//            4'hb: seg_out = 8'b1011_1111; // -
//            4'hC: seg_out = 8'b1100_0110; // C
//            4'hd: seg_out = 8'b1010_0001; // D
//            4'hE: seg_out = 8'b1000_0110; // E
//            4'hF: seg_out = 8'b1011_1110; // =
//            default: seg_out = 8'b1111_1111;
//        endcase
//    end
//endmodule







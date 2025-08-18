`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2025 02:29:27 PM
// Design Name: 
// Module Name: controller
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


module fnd_cntr(
    input clk, reset_p,
    input [15:0] fnd_value,
    input hex_bcd,
    output [7:0] seg_7,
    output [3:0] com);
    
    wire [15:0] bcd_value;
    bin_to_dec bcd(.bin(fnd_value[11:0]), .bcd(sec_bcd));
    
    reg [16:0] clk_div;
    always @(posedge clk)clk_div = clk_div + 1;
    
    anode_selector ring_com(
        .scan_count(clk_div[16:15]), .an_out(com));
    reg [3:0] digit_value; 
    wire [15:0] out_value;
    assign out_value = hex_bcd ? fnd_value : bcd_value;   
    always @(posedge clk or posedge reset_p)begin
        if(reset_p)begin
            digit_value = 0;
        end
        else begin
            case(com)
                4'b1110 : digit_value = out_value[3:0];
                4'b1101 : digit_value = out_value[7:4];
                4'b1011 : digit_value = out_value[11:8];
                4'b0111 : digit_value = out_value[15:12];
            endcase
        end
    end
    seg_decoder dec(.digit_in(digit_value), .seg_out(seg_7));
    
    
endmodule

module debounce (
    input clk,
    input btn_in,
    output reg btn_out
);

    reg [15:0] count;
    reg btn_sync_0, btn_sync_1;
    wire stable = (count == 16'hFFFF);

    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;
    end

    always @(posedge clk) begin
        if(btn_sync_1 == btn_out) begin
            count <= 0;
        end else begin
            count <= count + 1;
            if(stable)
                btn_out <= btn_sync_1;
        end
    end

endmodule

module btn_cntr(
    input clk, reset_p,
    input btn,
    output btn_pedge, btn_nedge);
    wire debounced_btn;
    debounce btn_0(.clk(clk), .btn_in(btn), .btn_out(debounced_btn));
    
    edge_detector_p btn_ed(
        .clk(clk), .reset_p(reset_p), .cp(debounced_btn),
        .p_edge(btn_pedge), .n_edge(btn_nedge));

endmodule

module and_gate(
    input A,
    input B,
    output F
    );
    
    assign F = A & B;
    
endmodule

module half_adder_structural(
    input A, B,
    output sum, carry
    );

    xor (sum, A, B);
    and (carry, A, B);
    
endmodule 

module half_adder_behavioral(
    input A, B,
    output reg sum, carry
    );

    always @(A, B)begin
        case({A, B})
            2'b00: begin sum = 0; carry = 0; end
            2'b01: begin sum = 1; carry = 0; end
            2'b10: begin sum = 1; carry = 0; end
            2'b11: begin sum = 0; carry = 1; end
        endcase
    end

endmodule

module half_adder_dataflow(
    input A, B,
    output sum, carry
    );

    wire [1:0] sum_value;
    
    assign sum_value = A + B;
    assign sum = sum_value[0];
    assign carry = sum_value[1];
    
endmodule

module full_adder_behavioral(
    input A, B, cin,
    output reg sum, carry
    );

    always @(A, B, cin)begin
        case({A, B, cin})
            3'b000: begin sum = 0; carry = 0; end
            3'b001: begin sum = 1; carry = 0; end
            3'b010: begin sum = 1; carry = 0; end
            3'b011: begin sum = 0; carry = 1; end
            3'b100: begin sum = 1; carry = 0; end
            3'b101: begin sum = 0; carry = 1; end
            3'b110: begin sum = 0; carry = 1; end
            3'b111: begin sum = 1; carry = 1; end
        endcase
    end

endmodule

module full_adder_structural(
    input A, B, cin,
    output sum, carry
    );
    
    wire sum_0, carry_0, carry_1;

    half_adder_structural ha0(.A(A), .B(B), .sum(sum_0), .carry(carry_0));
    half_adder_structural ha1(.A(sum_0), .B(cin), .sum(sum), .carry(carry_1));
    
    or (carry, carry_0, carry_1);

endmodule

module full_adder_dataflow(
    input A, B, cin,
    output sum, carry
    );

    wire [1:0] sum_value;
    
    assign sum_value = A + B + cin;
    assign sum = sum_value[0];
    assign carry = sum_value[1];

endmodule

module fadder_4bit_dataflow(
    input [3:0] A, B, 
    input cin,
    output [3:0] sum, 
    output carry
    );

    wire [4:0] sum_value;
    
    assign sum_value = A + B + cin;
    assign sum = sum_value[3:0];
    assign carry = sum_value[4];

endmodule

module fadder_4bit_structural(
    input [3:0] A, B,
    input cin,
    output [3:0] sum,
    output carry
    );
    
    wire [2:0] carry_w;

    full_adder_structural fa0 (.A(A[0]), .B(B[0]), .cin(cin), .sum(sum[0]), .carry(carry_w[0]));
    full_adder_structural fa1 (.A(A[1]), .B(B[1]), .cin(carry_w[0]), .sum(sum[1]), .carry(carry_w[1]));
    full_adder_structural fa2 (.A(A[2]), .B(B[2]), .cin(carry_w[1]), .sum(sum[2]), .carry(carry_w[2]));
    full_adder_structural fa3 (.A(A[3]), .B(B[3]), .cin(carry_w[2]), .sum(sum[3]), .carry(carry));
endmodule

module mux_2_1(
    input [1:0] d,
    input s,
    output f
    );
    
    assign f = s ? d[1] : d[0];
    
endmodule

module mux_4_1(
    input [3:0] d,
    input [1:0] s,
    output f
    );
    
    assign f = d[s];
    
endmodule

module mux_8_1(
    input [7:0] d,
    input [2:0] s,
    output f
    );
    
    assign f = d[s];
    
endmodule

module demux_1_4_d(
    input d,
    input [1:0] s,
    output [3:0] f
    );

    assign f = (s == 2'b00) ? {3'b000, d} : 
               (s == 2'b01) ? {2'b00, d, 1'b0} :
               (s == 2'b10) ? {1'b0, d, 2'b00} : {d, 3'b000};

endmodule

module mux_demux_test(
    input [3:0] d,
    input [1:0] mux_s,
    input [1:0] demux_s,
    output [3:0] f);

    wire mux_f;
    
    mux_4_1 mux_4(.d(d), .s(mux_s), .f(mux_f));
    demux_1_4_d demux4(.d(mux_f), .s(demux_s), .f(f));

endmodule

module encoder_4_2(
    input [3:0] signal,
    output reg [1:0] code);

//    assign code = (signal == 4'b1000) ? 2'b11 :
//                  (signal == 4'b0100) ? 2'b10 :
//                  (signal == 4'b0010) ? 2'b01 : 2'b00;

//    always @(signal)begin
//        if(signal == 4'b1000) code = 2'b11;
//        else if(signal == 4'b0100) code = 2'b10;
//        else if(signal == 4'b0010) code = 2'b01;
//        else code = 2'b00;
//    end

    always @(signal)begin
        case(signal)
            4'b0001: code = 2'b00;
            4'b0010: code = 2'b01;
            4'b0100: code = 2'b10;
            4'b1000: code = 2'b11;
            default: code = 2'b00;
        endcase
    end

endmodule

module decoder_2_4(
    input [1:0] code,
    output [3:0] signal);

    assign signal = (code == 2'b00) ? 4'b0001 :
                    (code == 2'b01) ? 4'b0010 :
                    (code == 2'b10) ? 4'b0100 : 4'b1000;

endmodule

module seg_decoder (
    input [3:0] digit_in,
    output reg [7:0] seg_out
);

    always @(*) begin
        case (digit_in)
                             //pgfe_dcba
            4'd0: seg_out = 8'b1100_0000;   // 0 (dp 꺼짐)
            4'd1: seg_out = 8'b1111_1001;   // 1
            4'd2: seg_out = 8'b1010_0100;   // 2
            4'd3: seg_out = 8'b1011_0000;   // 3
            4'd4: seg_out = 8'b1001_1001;   // 4
            4'd5: seg_out = 8'b1001_0010;   // 5
            4'd6: seg_out = 8'b1000_0010;   // 6
            4'd7: seg_out = 8'b1111_1000;   // 7
            4'd8: seg_out = 8'b1000_0000;   // 8
            4'd9: seg_out = 8'b1001_0000;   // 9
            4'hA: seg_out = 8'b1000_1000;   // A
            4'hb: seg_out = 8'b1000_0011;   // b
            4'hC: seg_out = 8'b1100_0110;   // C
            4'hd: seg_out = 8'b1010_0001;   // d
            4'hE: seg_out = 8'b1000_0110;   // E
            4'hF: seg_out = 8'b1000_1110;   // F
            default: seg_out = 8'b1111_1111;
        endcase
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




















































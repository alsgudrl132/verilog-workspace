module or_gate(
    input a, b,
    output reg q
    );

    always @(a, b) begin
        case ({a, b})
            2'b01 : q = 1;
            2'b10 : q = 1;
            2'b00 : q = 0;
            2'b11 : q = 1; 
        endcase
    end
endmodule
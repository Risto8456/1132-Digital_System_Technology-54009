module rom_a (addr, data, dpt);
    input [3:0] addr;
    output reg [6:0] data;
    output dpt;

    always @(addr) begin
        case (addr) // gfedcba
            4'd0: data = 7'b1111110;
            4'd7: data = 7'b1110111;
            4'd8: data = 7'b1101111;
            4'd9: data = 7'b1011111;

            default: data = 7'b1111111;
        endcase
    end // always
    assign dpt = 1'b1;
endmodule
module rom_b (addr, data, dpt);
    input [3:0] addr;
    output reg [6:0] data;
    output dpt;

    always @(addr) begin
        case (addr) // gfedcba
            4'd1: data = 7'b1111110;
            4'd6: data = 7'b1110111;

            default: data = 7'b1111111;
        endcase
    end // always
    assign dpt = 1'b1;
endmodule
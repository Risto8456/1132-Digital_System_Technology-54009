module rom_c (addr, data, dpt);
    input [3:0] addr;
    output reg [6:0] data;
    output dpt;

    always @(addr) begin
        case (addr) // gfedcba
            4'd2: data = 7'b1111110;
            4'd3: data = 7'b1111101;
            4'd4: data = 7'b1111011;
            4'd5: data = 7'b1110111;

            default: data = 7'b1111111;
        endcase
    end // always
    assign dpt = 1'b1;
endmodule
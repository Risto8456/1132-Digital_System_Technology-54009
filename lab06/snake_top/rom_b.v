module rom_b (addr, data, dpt);
    input [4:0] addr;
    output reg [6:0] data;
    output dpt;

    always @(addr) begin
        case (addr) // gfedcba
            5'd0: data = 7'b1111110;
            5'd1: data = 7'b1111110;
            5'd5: data = 7'b0111111;
            5'd6: data = 7'b0111111;
            5'd7: data = 7'b0111111;
            5'd9: data = 7'b1110111;
            5'd10: data = 7'b1110111;
            5'd11: data = 7'b1110111;
            5'd15: data = 7'b0111111;
            5'd16: data = 7'b0111111;
            5'd17: data = 7'b0111111;
            5'd19: data = 7'b1111110;

            default: data = 7'b1111111;
        endcase
    end // always
    assign dpt=1'b1;
endmodule
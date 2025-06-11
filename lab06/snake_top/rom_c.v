module rom_c (addr, data, dpt);
    input [4:0] addr;
    output reg [6:0] data;
    output dpt;

    always @(addr) begin
        case (addr) // gfedcba
            5'd0: data = 7'b1111110;
            5'd1: data = 7'b1111110;
            5'd2: data = 7'b1111110;
            5'd4: data = 7'b0111111;
            5'd5: data = 7'b0111111;
            5'd6: data = 7'b0111111;
            5'd10: data = 7'b1110111;
            5'd11: data = 7'b1110111;
            5'd12: data = 7'b1110111;
            5'd14: data = 7'b0111111;
            5'd15: data = 7'b0111111;
            5'd16: data = 7'b0111111;

            default: data = 7'b1111111;
        endcase
    end // always
    assign dpt=1'b1;
endmodule
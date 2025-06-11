module rom_c (addr, data);
    input [4:0] addr;
    output reg [9:0] data;

    always @(addr) begin
        case (addr)
            5'd0: data = 10'b1000000001;
            5'd1: data = 10'b1100000011;
            5'd2: data = 10'b1110000111;
            5'd3: data = 10'b1111001111;
            5'd4: data = 10'b1111111111;
            5'd5: data = 10'b0000000000;
            5'd6: data = 10'b1111111111;
            5'd7: data = 10'b0000000000;
            5'd8: data = 10'b1111111111;
            5'd9: data = 10'b0000000000;
            5'd10: data = 10'b1111111111;
            5'd11: data = 10'b1111111111;
            5'd12: data = 10'b1111001111;
            5'd13: data = 10'b1110000111;
            5'd14: data = 10'b1100000011;
            5'd15: data = 10'b1000000001;
            5'd16: data = 10'b0000000000;
            5'd17: data = 10'b0000000000;
            // 共 18 種圖案循環

            default: data = 10'b0000000000;
        endcase
    end // always
endmodule
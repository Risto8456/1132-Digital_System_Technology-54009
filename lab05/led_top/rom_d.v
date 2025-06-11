module rom_d (addr, data);
    input [4:0] addr;
    output reg [9:0] data;

    always @(addr) begin
        case (addr)
            5'd0: data = 10'b1100000000;
            5'd1: data = 10'b011000000;
            5'd2: data = 10'b001100000;
            5'd3: data = 10'b0001100000;
            5'd4: data = 10'b0000110000;
            5'd5: data = 10'b0000011000;
            5'd6: data = 10'b0000001100;
            5'd7: data = 10'b0000000110;
            5'd8: data = 10'b0000000011;
            5'd9: data = 10'b0000000011;
            5'd10: data = 10'b0000000110;
            5'd11: data = 10'b0000001100;
            5'd12: data = 10'b0000011000;
            5'd13: data = 10'b0000110000;
            5'd14: data = 10'b0001100000;
            5'd15: data = 10'b0011000000;
            5'd16: data = 10'b0110000000;
            5'd17: data = 10'b1100000000;
            // 共 18 種圖案循環

            default: data = 10'b0000000000;
        endcase
    end // always
endmodule
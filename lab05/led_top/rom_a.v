module rom_a (addr, data);
    input [4:0] addr;
    output reg [9:0] data;

    always @(addr) begin    // data [9:0] 對應到 10 個 led,
        case (addr)         // 1: on, 0: off
            5'd0: data = 10'b1000000000;
            5'd1: data = 10'b0100000000;
            5'd2: data = 10'b0010000000;
            5'd3: data = 10'b0001000000;
            5'd4: data = 10'b0000100000;
            5'd5: data = 10'b0000010000;
            5'd6: data = 10'b0000001000;
            5'd7: data = 10'b0000000100;
            5'd8: data = 10'b0000000010;
            5'd9: data = 10'b0000000001;
            // 共 10 種圖案循環

            default: data = 10'b0000000000;
        endcase
    end // always
endmodule
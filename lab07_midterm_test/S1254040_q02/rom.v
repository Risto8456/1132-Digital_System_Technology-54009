module rom (addr, data);
    input [2:0] addr;
    output reg [3:0] data;

    always @(addr) begin    // data [3:0] 對應到 4 個 led,
        case (addr)         // 1: on, 0: off
            3'd0: data = 4'b0000;
            3'd1: data = 4'b0001;
            3'd2: data = 4'b0011;
            3'd3: data = 4'b0111;
            3'd4: data = 4'b1111;
            3'd5: data = 4'b1110;
            3'd6: data = 4'b1100;
            3'd7: data = 4'b1000;
            // 共 8 種圖案循環

            default: data = 4'b0000;
        endcase
    end // always
endmodule
module rom (addr, data);
    input [2:0] addr;
    output reg [2:0] data;

    always @(addr) begin    // data [2:0] 對應到 3 個 led,
        case (addr)         // 1: on, 0: off
            3'd0: data = 3'b000;
            3'd1: data = 3'b001;
            3'd2: data = 3'b011;
            3'd3: data = 3'b111;
            3'd4: data = 3'b110;
            3'd5: data = 3'b100;
            // 共 6 種圖案循環

            default: data = 3'b000;
        endcase
    end // always
endmodule
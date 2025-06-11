module rom (addr, data, dpt);
    input [4:0] addr;
    output reg [6:0] data;
    output dpt;

    always @(addr) begin
        case (addr) // gfedcba
            5'd0: data = 7'b1000000; // 0
            5'd1: data = 7'b1111001; // 1
            5'd2: data = 7'b1000000; // 0
            5'd3: data = 7'b0100100; // 2
            5'd4: data = 7'b1000000; // 0
            5'd5: data = 7'b0110000; // 3
            5'd6: data = 7'b1000000; // 0
            5'd7: data = 7'b1111001; // 1
            5'd8: data = 7'b0100100; // 2
            5'd9: data = 7'b0110000; // 3

            default: data = 7'b1111111;
        endcase
    end // always
    // 由於 seg7 為 0 觸發, 對應之 seg7 若要亮(暗), data 所給之值為 0 (1)
    assign dpt=1'b1;
endmodule
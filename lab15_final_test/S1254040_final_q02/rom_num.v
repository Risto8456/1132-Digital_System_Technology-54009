module rom_num (cnt, num);
	input [2:0] cnt;
	output reg [3:0] num;

    always @(cnt) begin
        case (cnt)
            3'd0: num = 4'd4;
            3'd1: num = 4'd10; // X
            3'd2: num = 4'd0;
            3'd3: num = 4'd10; // X
            3'd4: num = 4'd4;
            3'd5: num = 4'd10; // X
            3'd6: num = 4'd0;
            3'd7: num = 4'd10; // X

            default: num = 4'd10; // X
        endcase
    end // always
endmodule
module rom_num (cnt, num);
	input [3:0] cnt;
	output reg [3:0] num;

	// ABCD = 5472
    always @(cnt) begin
        case (cnt)
            4'd0: num = 4'd5;
            4'd1: num = 4'd10; // X
            4'd2: num = 4'd4;
            4'd3: num = 4'd10; // X
            4'd4: num = 4'd7;
            4'd5: num = 4'd10; // X
            4'd6: num = 4'd2;
            4'd7: num = 4'd10; // X
            4'd8: num = 4'd2;
            4'd9: num = 4'd10; // X

            default: num = 4'd10; // X
        endcase
    end // always
endmodule
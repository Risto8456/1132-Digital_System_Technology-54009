module S1254040_q01 (sw1, sw0, led);
    input sw1, sw0;
    output reg [2:0] led;

	always @(sw1 or sw0)
		case({sw1, sw0})
			2'b00:{led[2], led[1], led[0]} = {1'b0, 1'b0, 1'b0};
			2'b01:{led[2], led[1], led[0]} = {1'b0, 1'b0, 1'b1};
			2'b11:{led[2], led[1], led[0]} = {1'b0, 1'b1, 1'b0};
			2'b10:{led[2], led[1], led[0]} = {1'b1, 1'b0, 1'b0};
			
			default:{led[2], led[1], led[0]} = {1'b0, 1'b0, 1'b0};
		endcase
endmodule
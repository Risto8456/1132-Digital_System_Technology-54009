module S1254040_q01 (
    sw2, sw1, sw0, 
    seg7_1, seg7_1_dpt, seg7_0, seg7_0_dpt);

    input sw2, sw1, sw0;
    output [6:0] seg7_1, seg7_0;
    output seg7_1_dpt, seg7_0_dpt;

    reg [1:0] num1, num0;
	always @(sw2 or sw1 or sw0)
		case({sw2, sw1, sw0})
			3'b000:{num1, num0} = {2'd0, 2'd0};
			3'b001:{num1, num0} = {2'd0, 2'd1};
			3'b011:{num1, num0} = {2'd0, 2'd2};
			3'b111:{num1, num0} = {2'd1, 2'd0};
			3'b110:{num1, num0} = {2'd1, 2'd1};
			3'b100:{num1, num0} = {2'd1, 2'd2};
			
			default:{num1, num0} = {2'd2, 2'd2};
		endcase

    num_to_seg7_0_2 n1(num1, seg7_1, seg7_1_dpt);
    num_to_seg7_0_2 n0(num0, seg7_0, seg7_0_dpt);
endmodule
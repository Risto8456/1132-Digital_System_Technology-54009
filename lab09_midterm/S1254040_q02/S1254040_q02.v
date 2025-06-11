module S1254040_q02 (
    sw1, sw0, seg7_2, seg7_2_dpt, 
	seg7_1, seg7_1_dpt, seg7_0, seg7_0_dpt);

    input sw1, sw0;
    output [6:0] seg7_2, seg7_1, seg7_0;
    output seg7_2_dpt, seg7_1_dpt, seg7_0_dpt;

    reg [2:0] num2, num1, num0;
	always @(sw1 or sw0)
		case({sw1, sw0})
			2'b00:{num2, num1, num0} = {3'd0, 3'd0, 3'd0};
			2'b01:{num2, num1, num0} = {3'd4, 3'd0, 3'd0};
			2'b11:{num2, num1, num0} = {3'd0, 3'd3, 3'd0};
			2'b10:{num2, num1, num0} = {3'd0, 3'd0, 3'd2};
			
			default:{num2, num1, num0} = {3'd0, 3'd0, 3'd0};
		endcase

    num_to_seg7_0_9 n2(num2, seg7_2, seg7_2_dpt);
    num_to_seg7_0_9 n1(num1, seg7_1, seg7_1_dpt);
    num_to_seg7_0_9 n0(num0, seg7_0, seg7_0_dpt);
endmodule
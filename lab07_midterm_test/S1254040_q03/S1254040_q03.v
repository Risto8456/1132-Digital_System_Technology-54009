module S1254040_q03 (
    clk, rst, seg7_2, seg7_2_dpt, 
    seg7_1, seg7_1_dpt, seg7_0, seg7_0_dpt);

    input clk, rst;
    output [6:0] seg7_0, seg7_1, seg7_2;
    output seg7_0_dpt, seg7_1_dpt, seg7_2_dpt;

    wire clk_cnt;
    freq_div #(25) f0(clk, ~rst, clk_cnt);

    wire [2:0] ptn_cnt;
    updn_count #(7) u0(clk_cnt, ~rst, 1'b1, ptn_cnt);

    reg [1:0] num0, num1, num2;

	always @(ptn_cnt)
		case(ptn_cnt)
			3'd0:{num2, num1, num0} = {2'd0, 2'd0, 2'd0};
			3'd1:{num2, num1, num0} = {2'd1, 2'd1, 2'd1};
			3'd2:{num2, num1, num0} = {2'd2, 2'd2, 2'd2};
			3'd3:{num2, num1, num0} = {2'd3, 2'd3, 2'd3};
			3'd4:{num2, num1, num0} = {2'd1, 2'd2, 2'd2};
			3'd5:{num2, num1, num0} = {2'd2, 2'd3, 2'd3};
			3'd6:{num2, num1, num0} = {2'd3, 2'd1, 2'd1};
			
			default:{num2, num1, num0} = {2'd0, 2'd0, 2'd0};
		endcase
    
    num_to_seg7_0_3 n0(num0, seg7_0, seg7_0_dpt);
    num_to_seg7_0_3 n1(num1, seg7_1, seg7_1_dpt);
    num_to_seg7_0_3 n2(num2, seg7_2, seg7_2_dpt);
endmodule
module S1254040_q05 (
    clk, rst, seg7_2, seg7_2_dpt, 
    seg7_1, seg7_1_dpt, seg7_0, seg7_0_dpt);

    input clk, rst;
    output [6:0] seg7_0, seg7_1, seg7_2;
    output seg7_0_dpt, seg7_1_dpt, seg7_2_dpt;

    wire clk_cnt;
    freq_div #(25) f0(clk, ~rst, clk_cnt);

    wire [4:0] ptn_cnt;
    updn_count #(24) u0(clk_cnt, ~rst, 1'b1, ptn_cnt);

    wire [2:0] num2, num1, num0;
	rom r0(ptn_cnt, num2, num1, num0);
    
    num_to_seg7_0_9 n0(num0, seg7_0, seg7_0_dpt);
    num_to_seg7_0_9 n1(num1, seg7_1, seg7_1_dpt);
    num_to_seg7_0_9 n2(num2, seg7_2, seg7_2_dpt);
endmodule
module S1254040_q05 (
    clk, rst, mod_sel, seg7_2, seg7_2_dpt, 
	seg7_1, seg7_1_dpt, seg7_0, seg7_0_dpt);
    input clk, rst;
    input [1:0] mod_sel;
    output [6:0] seg7_2, seg7_1, seg7_0;
    output seg7_2_dpt, seg7_1_dpt, seg7_0_dpt;

    wire clk_cnt;
    // rst 必須先反相: ~rst
    freq_div #(24) f0(clk, ~rst, clk_cnt);

    wire [1:0] cnt0, cnt1, cnt2, cnt3;
    updn_count #(2) c0(clk_cnt, ~rst, 1'b1, cnt0);
    updn_count #(3) c1(clk_cnt, ~rst, 1'b1, cnt1);
    updn_count #(4) c2(clk_cnt, ~rst, 1'b1, cnt2);
    updn_count #(1) c3(clk_cnt, ~rst, 1'b1, cnt3);
    
    wire [1:0] cnt;
    assign cnt = mod_sel == 2'b00 ? cnt0 : 
                 mod_sel == 2'b01 ? cnt1 : 
                 mod_sel == 2'b11 ? cnt2 : cnt3;

    wire [2:0] num2, num1, num0;
    rom r0(cnt, num2, num1, num0);
    
    num_to_seg7_0_9 n2(num2, seg7_2, seg7_2_dpt);
    num_to_seg7_0_9 n1(num1, seg7_1, seg7_1_dpt);
    num_to_seg7_0_9 n0(num0, seg7_0, seg7_0_dpt);
endmodule
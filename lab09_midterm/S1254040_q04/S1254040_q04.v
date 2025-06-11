module S1254040_q04 (
    clk, rst, speed_sel, seg7_2, seg7_2_dpt, 
	seg7_1, seg7_1_dpt, seg7_0, seg7_0_dpt);
    input clk, rst;
    input [1:0] speed_sel;
    output [6:0] seg7_2, seg7_1, seg7_0;
    output seg7_2_dpt, seg7_1_dpt, seg7_0_dpt;

    wire clk_out_slow, clk_out_fast, clk_out_fastest;
    // rst 必須先反相: ~rst
    freq_div #(23) f0(clk, ~rst, clk_out_fastest);
    freq_div #(24) f1(clk, ~rst, clk_out_fast);
    freq_div #(25) f2(clk, ~rst, clk_out_slow);

    wire clk_cnt;
    assign clk_cnt = speed_sel == 2'b00 ? clk_out_fastest : 
                     speed_sel == 2'b10 ? clk_out_fast : clk_out_slow;

    wire [2:0] cnt;
    updn_count #(6) cnt0(clk_cnt, ~rst, 1'b1, cnt);
    
    wire [2:0] num2, num1, num0;
    rom r0(cnt, num2, num1, num0);
    
    num_to_seg7_0_9 n2(num2, seg7_2, seg7_2_dpt);
    num_to_seg7_0_9 n1(num1, seg7_1, seg7_1_dpt);
    num_to_seg7_0_9 n0(num0, seg7_0, seg7_0_dpt);
endmodule
module S1254040_q06 (clk, rst, 
    seg7_1, seg7_1_dpt, seg7_0, seg7_0_dpt);

    input clk, rst;
    output [6:0] seg7_0, seg7_1;
    output seg7_0_dpt, seg7_1_dpt;

    wire clk_cnt;
    freq_div #(24) f0(clk, ~rst, clk_cnt);

    wire [4:0] cnt;
    updn_count #(20) cnt0(clk_cnt, ~rst, 1'b1, cnt);

    wire [3:0] num1, num0;
    mod m0(clk_cnt, ~rst, cnt, num1, num0);
    
    num_to_seg7_0_9 n1(num1, seg7_1, seg7_1_dpt);
    num_to_seg7_0_9 n0(num0, seg7_0, seg7_0_dpt);
endmodule
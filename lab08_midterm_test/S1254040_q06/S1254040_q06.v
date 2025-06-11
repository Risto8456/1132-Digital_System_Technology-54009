module S1254040_q06 (clk, rst, 
    seg7_3, seg7_3_dpt, seg7_2, seg7_2_dpt, 
    seg7_1, seg7_1_dpt, seg7_0, seg7_0_dpt);

    input clk, rst;
    output [6:0] seg7_0, seg7_1, seg7_2, seg7_3;
    output seg7_0_dpt, seg7_1_dpt, seg7_2_dpt, seg7_3_dpt;

    wire clk_out_slow, clk_out_fast;
    // rst 必須先反相: ~rst
    freq_div #(23) f1(clk, ~rst, clk_out_fast);
    freq_div #(24) f2(clk, ~rst, clk_out_slow);

    wire clk_cnt, counter; // counter : 逆時針
    assign clk_cnt = counter == 1'b1 ? clk_out_fast : clk_out_slow;

    wire [3:0] ptn_cnt;
    updn_count #(10) cnt0(clk_cnt, ~rst, ~counter, ptn_cnt);
    
    rom_a r2(ptn_cnt, seg7_3, seg7_3_dpt);
    rom_b r1(ptn_cnt, seg7_2, seg7_2_dpt);
    rom_c r0(ptn_cnt, seg7_1, seg7_1_dpt);

    wire [2:0] run_cnt;
    circle_run_cnt #(10) rc0(clk_cnt, ~rst, ~counter, ptn_cnt, run_cnt, counter);
    num_to_seg7_0_9 n0(run_cnt, seg7_0, seg7_0_dpt);
endmodule
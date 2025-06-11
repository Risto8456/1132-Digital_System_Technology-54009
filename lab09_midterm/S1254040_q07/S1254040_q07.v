module S1254040_q07 (
    clk, rst, led, seg7_2, seg7_2_dpt, 
    seg7_1, seg7_1_dpt, seg7_0, seg7_0_dpt);

    input clk, rst;
    output [2:0] led;
    output [6:0] seg7_0, seg7_1, seg7_2;
    output seg7_0_dpt, seg7_1_dpt, seg7_2_dpt;

    wire clk_cnt_ori, clk_cnt, run_stop;
    freq_div #(24) f0(clk, ~rst, clk_cnt_ori);
    assign clk_cnt = run_stop == 1'b1 ? 1'b0 : clk_cnt_ori;
    
    wire [3:0] ptn_cnt;
    updn_count #(10) cnt0(clk_cnt, ~rst, 1'b1, ptn_cnt);
    
    rom_a r2(ptn_cnt, seg7_2, seg7_2_dpt);
    rom_b r1(ptn_cnt, seg7_1, seg7_1_dpt);
    rom_c r0(ptn_cnt, seg7_0, seg7_0_dpt);

    circle_run_cnt #(10) rc0(clk_cnt, ~rst, ptn_cnt, led, run_stop);
endmodule
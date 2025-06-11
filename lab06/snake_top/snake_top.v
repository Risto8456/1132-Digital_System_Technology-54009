module snake_top (
    clk, rst, speed_sel, updn_sel, 
    seg7_5, seg7_5_dpt, seg7_4, seg7_4_dpt, 
    seg7_3, seg7_3_dpt, seg7_2, seg7_2_dpt, 
    seg7_0, seg7_0_dpt);

    input clk, rst, speed_sel, updn_sel;
    output [6:0] seg7_0, seg7_2, seg7_3, seg7_4, seg7_5;
    output seg7_0_dpt, seg7_2_dpt, seg7_3_dpt, seg7_4_dpt, seg7_5_dpt;

    wire clk_out_slow, clk_out_fast;
    // rst 必須先反相: ~rst
    freq_div #(23) f0(clk, ~rst, clk_out_fast);
    freq_div #(24) f1(clk, ~rst, clk_out_slow);

    wire run_stop, clk_cnt;
    assign clk_cnt = run_stop == 1 ? 1'b0 : 
                     speed_sel == 1 ? clk_out_fast : clk_out_slow;
    // run_stop = 1 => clk_cnt = 0
    // run_stop = 0 => (speed_sel = 1 => fast, speed_sel = 0 => slow)

    wire [4:0] ptn_cnt;
    updn_count #(20) u0(clk_cnt, ~rst, ~updn_sel, ptn_cnt);
    // updn_sel=0 => count up, updn_sel=1 => count down
    // 由於按鍵關係,向下撥為正轉(updn_sel=0), 
    // 向上撥為反轉(updn_sel=1), 
    // 因此 updn_sel 傳入 updn_count 時, 必須先反相: ~updn_sel

    rom_a r0(ptn_cnt, seg7_5, seg7_5_dpt);
    rom_b r1(ptn_cnt, seg7_4, seg7_4_dpt);
    rom_c r2(ptn_cnt, seg7_3, seg7_3_dpt);
    rom_d r3(ptn_cnt, seg7_2, seg7_2_dpt);

    wire [3:0] run_cnt;
    // rst 及 updn_sel 必須先反相: ~rst, ~updn_sel
    snake_run_cnt #(20) s0(clk_cnt, ~rst, ~updn_sel, ptn_cnt, run_cnt, run_stop);
    num_to_seg7_0_9 n0(run_cnt, seg7_0, seg7_0_dpt);
endmodule
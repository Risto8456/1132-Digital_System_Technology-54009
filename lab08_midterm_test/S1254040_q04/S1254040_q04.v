module S1254040_q04 (clk, rst, speed_sel, seg7, seg7_dpt);
    input clk, rst;
    input [1:0] speed_sel;
    output [6:0] seg7;
    output seg7_dpt;

    wire clk_out_slow, clk_out_fast, clk_out_fastest;
    // rst 必須先反相: ~rst
    freq_div #(23) f0(clk, ~rst, clk_out_fastest);
    freq_div #(24) f1(clk, ~rst, clk_out_fast);
    freq_div #(25) f2(clk, ~rst, clk_out_slow);

    wire clk_cnt;
    assign clk_cnt = speed_sel == 2'b11 ? clk_out_fastest : 
                     speed_sel == 2'b10 ? clk_out_fast : clk_out_slow;

    wire [3:0] cnt;
    updn_count #(10) cnt0(clk_cnt, ~rst, 1'b1, cnt);
    
    rom r0(cnt, seg7, seg7_dpt);
endmodule
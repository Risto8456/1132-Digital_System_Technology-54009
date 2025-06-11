module S1254040_q03 (clk, rst, speed_sel, led);
    input clk, rst;
    input [1:0] speed_sel;
    output [2:0] led;

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
    
    rom r0(cnt, led);
endmodule
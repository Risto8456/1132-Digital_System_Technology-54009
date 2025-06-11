module led_top (clk, rst, ptn_sel, led);
    input clk, rst;
    input [1:0] ptn_sel;
    output [9:0] led;

    wire clk_cnt;
    wire [4:0] cnt_a, cnt_b, cnt_c, cnt_d;
    wire [9:0] w0, w1, w2, w3;

    freq_div #(24) f1 (clk, ~rst, clk_cnt);

    // #() : led pattern 之圖案數量
    // 1'b1 : updn 固定為 1,因為只需要上數
    updn_count #(10) cnt0(clk_cnt, ~rst, 1'b1, cnt_a);
    updn_count #(22) cnt1(clk_cnt, ~rst, 1'b1, cnt_b);
    updn_count #(18) cnt2(clk_cnt, ~rst, 1'b1, cnt_c);
    updn_count #(18) cnt3(clk_cnt, ~rst, 1'b1, cnt_d);

    rom_a r0(cnt_a, w0);
    rom_b r1(cnt_b, w1);
    rom_c r2(cnt_c, w2);
    rom_d r3(cnt_d, w3);

    // mux 4x1
    assign led = (ptn_sel == 2'b00 ? w0 : 
                  ptn_sel == 2'b01 ? w1 : 
                  ptn_sel == 2'b10 ? w2 : w3);
endmodule
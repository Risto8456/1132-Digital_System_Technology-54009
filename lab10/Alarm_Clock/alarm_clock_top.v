module alarm_clock_top (
    clk, rst, hr1, hr0, min1, min0, 
    seg7_5, seg7_5_dpt, seg7_4, seg7_4_dpt, 
    seg7_3, seg7_3_dpt, seg7_2, seg7_2_dpt, led);

    input clk, rst;
    // input 信號未接 switch 時，預設值為 1
    // 因此 hr0, min1, min0 的 bit 數要縮減成 switch 個數
    input [1:0] hr1;
    input [2:0] hr0;  // [3:0] => [2:0]
    input [1:0] min1; // [2:0] => [1:0]
    input [2:0] min0; // [3:0] => [2:0]

    output [6:0] seg7_5, seg7_4, seg7_3, seg7_2;
    output seg7_5_dpt, seg7_4_dpt, seg7_3_dpt, seg7_2_dpt;
    output led;

    wire [1:0] cnt3;
    wire [3:0] cnt2;
    wire [2:0] cnt1;
    wire [3:0] cnt0;
    wire clk_clock;
    wire led;

    alarm_clock m0(clk_clock, ~rst, hr1, hr0, min1, min0, 
                   cnt3, cnt2, cnt1, cnt0, led);

    // rst 必須先反相: ~rst
    num_to_seg7_0_9 m1(cnt3, seg7_5, seg7_5_dpt);
    num_to_seg7_0_9 m2(cnt2, seg7_4, seg7_4_dpt);
    num_to_seg7_0_9 m3(cnt1, seg7_3, seg7_3_dpt);
    num_to_seg7_0_9 m4(cnt0, seg7_2, seg7_2_dpt);

    wire clk_fast, clk_slow;
    freq_div #(24)  m5(clk, ~rst, clk_slow);
    freq_div #(20)  m6(clk, ~rst, clk_fast);
    assign clk_clock = (led == 1'b0) ? clk_fast : clk_slow;
endmodule
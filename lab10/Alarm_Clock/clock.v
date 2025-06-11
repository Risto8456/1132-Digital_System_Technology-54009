module clock (clk, rst, cnt3, cnt2, cnt1, cnt0); 
    input clk, rst;
    output [1:0] cnt3;
    output [3:0] cnt2;
    output [2:0] cnt1;
    output [3:0] cnt0;

    wire carry0;

    // hour
    cnt_00_23_bcd m0(clk, rst, carry0, cnt3, cnt2);
    // minute 
    cnt_00_59_bcd m1(clk, rst, carry0, cnt1, cnt0);
endmodule
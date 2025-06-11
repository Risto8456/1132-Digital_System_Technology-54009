module keyboard2_top (
    clk, rst, J4_col, J4_row, press, scan_code, 
    seg7_0, seg7_0_dpt, seg7_1, seg7_1_dpt, 
    seg7_2, seg7_2_dpt);
    
    input clk, rst;
    input [3:0] J4_col;
    output [3:0] J4_row;
    output press;
    output [3:0] scan_code;
    output [6:0] seg7_0, seg7_1, seg7_2;
    output seg7_0_dpt, seg7_1_dpt, seg7_2_dpt;

    wire [3:0] kr_sel, kc_sel;
    
    assign J4_row[0] = kr_sel[0];
    assign J4_row[1] = kr_sel[1];
    assign J4_row[2] = kr_sel[2];
    assign J4_row[3] = kr_sel[3];
    assign kc_sel[0] = J4_col[0];
    assign kc_sel[1] = J4_col[1];
    assign kc_sel[2] = J4_col[2];
    assign kc_sel[3] = J4_col[3];
    
    wire clk_key;
    wire [20:0] sum; // 運算結果,輸出8-bit (0-255)
    wire [11:0] key_buf_code; // 顯示12-bit(3-digit)於seg7
    
    freq_div #(21)  m0 (clk, ~rst, clk_key);
    kr_scan         m1 (clk_key, ~rst, kr_sel);
    keyboard        m2 (kr_sel, kc_sel, press, scan_code);
    
    key_buffer      m3(clk_key, ~rst, press, scan_code, sum);
    bin2bcd         m7(sum[7:0], key_buf_code[11:0]);
    // 8-bit 運算結果 sum[7:0],轉為12-bit BCD編碼 key_buf_code[11:0]
    
    num_to_seg7_0_F m4 (1, key_buf_code[3 :0], seg7_0, seg7_0_dpt);
    num_to_seg7_0_F m5 (1, key_buf_code[7 :4], seg7_1, seg7_1_dpt);
    num_to_seg7_0_F m6 (1, key_buf_code[11:8], seg7_2, seg7_2_dpt);
endmodule
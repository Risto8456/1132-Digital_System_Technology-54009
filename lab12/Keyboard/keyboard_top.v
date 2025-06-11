module keyboard_top (
    clk, rst, J4_col, J4_row, press, scan_code, 
    seg7_0, seg7_0_dpt, seg7_1, seg7_1_dpt, 
    seg7_2, seg7_2_dpt, seg7_3, seg7_3_dpt, 
    seg7_4, seg7_4_dpt, seg7_5, seg7_5_dpt);
    input clk, rst;
    input [3:0] J4_col;
    output [3:0] J4_row;
    output press;
    output [3:0] scan_code;
    output [6:0] seg7_0, seg7_1, seg7_2, seg7_3, seg7_4, seg7_5;
    output seg7_0_dpt, seg7_1_dpt, seg7_2_dpt, seg7_3_dpt, seg7_4_dpt, seg7_5_dpt;

    wire [3:0] kr_sel, kc_sel;

    // 配合外接keyboard之I/O port
    assign J4_row[0] = kr_sel[0];
    assign J4_row[1] = kr_sel[1];
    assign J4_row[2] = kr_sel[2];
    assign J4_row[3] = kr_sel[3];
    assign kc_sel[0] = J4_col[0];
    assign kc_sel[1] = J4_col[1];
    assign kc_sel[2] = J4_col[2];
    assign kc_sel[3] = J4_col[3];

    wire clk_key;
    wire [5:0] buf_flag;
    wire [23:0] key_buf_code;
    
    freq_div #(21)  m0(clk, ~rst, clk_key);
    kr_scan         m1(clk_key, ~rst, kr_sel);
    keyboard        m2(kr_sel, kc_sel, press, scan_code);
    key_buffer      m3(clk_key, ~rst, press, scan_code, 
                       buf_flag, key_buf_code);
    
	num_to_seg7_0_F	m4(buf_flag[0], key_buf_code[3 :0],  seg7_0, seg7_0_dpt);
	num_to_seg7_0_F	m5(buf_flag[1], key_buf_code[7 :4],  seg7_1, seg7_1_dpt);
	num_to_seg7_0_F	m6(buf_flag[2], key_buf_code[11:8],  seg7_2, seg7_2_dpt);
	num_to_seg7_0_F	m7(buf_flag[3], key_buf_code[15:12], seg7_3, seg7_3_dpt);
	num_to_seg7_0_F	m8(buf_flag[4], key_buf_code[19:16], seg7_4, seg7_4_dpt);
	num_to_seg7_0_F	m9(buf_flag[5], key_buf_code[23:20], seg7_5, seg7_5_dpt);
	
    // row_scan及資料存入buffer之頻率
    // rst要反相-> ~rst
    // 按鍵二進位值對Seg7之編碼
    // 若無資料則Seg7為暗
endmodule
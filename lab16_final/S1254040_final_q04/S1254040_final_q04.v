module S1254040_final_q04 (
    clk, rst, kc_sel, kr_sel, key_buf_code, sum);
    input           clk, rst;
    input   [3:0]   kc_sel;
    output  [3:0]   kr_sel;
    output  [31:0]  key_buf_code;
    output  [7:0]   sum;

    wire press;
    wire [6:0] buf_flag;
    wire [3:0] scan_code;

    kr_scan         m1(clk, rst, kr_sel);
    keyboard        m2(kr_sel, kc_sel, press, scan_code);
    key_buffer      m3(clk, rst, press, scan_code, 
                       buf_flag, key_buf_code);
    add_num         m4(clk, rst, press, scan_code, sum);
endmodule
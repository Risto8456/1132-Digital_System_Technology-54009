module S1254040_final_q03 (
    clk, rst, kc_sel, kr_sel, key_buf_code, key_buf_code2);
    input clk, rst;
    input [3:0] kc_sel;
    output [3:0] kr_sel;
    output [27:0] key_buf_code, key_buf_code2;

    wire press, press2;
    wire [6:0] buf_flag, buf_flag2;
    wire [3:0] scan_code;

    assign press2 = scan_code[0]; // even
    
    kr_scan         m1(clk, rst, kr_sel);
    keyboard        m2(kr_sel, kc_sel, press, scan_code);
    key_buffer      m3(clk, rst, press, scan_code, 
                       buf_flag, key_buf_code);
    key_buffer      m4(clk, rst, press2, scan_code, 
                       buf_flag2, key_buf_code2);
endmodule
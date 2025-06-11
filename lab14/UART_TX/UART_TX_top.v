module UART_TX_top (
    input i_clk,
    input i_rst_b,
    input [7:0] i_TX_Byte,
    output [7:0] o_TX_Byte_b, 
    output o_TX_Bit
);
    
    // 1. i_TX_Byte[7:0]:接至switch的8-bit輸入信號
    // 2. o_TX_Byte_b[7:0]:接至led的8-bit輸出信號
    // 3. o_TX_Bit:接至FTDI232接收端之輸出信號

    assign o_TX_Byte_b = i_TX_Byte;

    wire rst = ~i_rst_b;
    wire clk_div;
    
    freq_div_n #(868, 10) m0 (i_clk, rst, clk_div);
    
    wire r_TX_Bit;
    UART_TX m1 (clk_div, rst, i_TX_Byte, r_TX_Bit);
    assign o_TX_Bit = r_TX_Bit;
endmodule
// DE10實驗板之工作時脈為50MHz,
// 假設資料傳輸之 baud rate 57,600,
// 則實驗板時脈必須先經過除頻, 
// 50,000,000/57,600 = 868,
// 因此除頻電路需要10個bits
module key_buffer(
    clk, rst, press, scan_code, 
    buf_flag, key_buf_code);
    input clk, rst, press;
    input [3:0] scan_code;
    output reg [7:0] buf_flag;
    output reg [31:0] key_buf_code;
    
    always@ (posedge clk or posedge rst) begin
        if (rst) begin
            buf_flag = 8'b00000000;
            key_buf_code = 32'h00000000;
        end
        else
            if (press == 1'b1) begin
                buf_flag = {buf_flag[6:0], 1'b1};
                key_buf_code[31:0] = {key_buf_code[27:0], scan_code};
            end
    end
endmodule
module add_num(
    clk, rst, press, scan_code, sum);
    input clk, rst, press;
    input [3:0] scan_code;
    output reg [7:0] sum;
    
    always@ (posedge clk or posedge rst) begin
        if (rst)
            sum = 8'd0;
        else
            if (press == 1'b1)
                sum = sum + scan_code;
    end
endmodule
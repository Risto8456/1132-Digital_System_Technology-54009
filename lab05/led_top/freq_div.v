module freq_div(clk, rst, clk_out);
    parameter EXP = 3;
    // divided by default power(2, 3)

    input clk, rst;
    output clk_out;

    reg [EXP - 1:0] divider;

    assign clk_out = divider[EXP - 1];

    always @(posedge clk or posedge rst) begin
        if(rst)
            divider = 0;
        else
            divider = divider + 1;
    end // always
endmodule
module addmux_4(a, b, sel, cout, y);
    input [3:0] a, b;
    input [1:0] sel;
    output cout;
    output [3:0] y;

    wire [3:0] w0, sum;
    wire cout_temp;

    addsub_4 a0(a, b, sel, cout_temp, sum);

    assign w0 = (sel[0] == 1) ? b : a;
    assign y = (sel[1] == 1) ? sum : w0;
    assign cout = cout_temp & sel[1];
endmodule
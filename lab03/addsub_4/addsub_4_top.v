module addsub_4_top(a, b, sel, cout, sum);
    input [3:0] a, b;
    input sel;
    output cout;
    output [3:0] sum;

    addsub_4 m0(a, b, sel, cout, sum);
endmodule
module addseg7_top(a, b, sel, a_seg7, a_dpt, b_seg7, b_dpt, sel_out, cout, sum_seg7, sum_dpt);
    input [3:0] a, b;
    input [1:0] sel;
    output [6:0] a_seg7, b_seg7, sum_seg7;
    output a_dpt, b_dpt, sum_dpt;
    output [1:0] sel_out;
    output cout;

    wire [3:0] sum;

    num_to_seg7 m0(a, a_seg7, a_dpt);
    num_to_seg7 m1(b, b_seg7, b_dpt);
    assign sel_out = sel;

    addmux_4 m2(a, b, sel, cout, sum);
    num_to_seg7 m3(sum, sum_seg7, sum_dpt);
endmodule
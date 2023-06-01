module double_top (
    input wire t_clk,
    input wire rst_n,

    input wire f_layer_0, f_layer_1,

    output wire sort_finish_0, sort_finish_1,
    output wire data_out    
);

wire data_out_dut0;

top dut0 (
.t_clk(t_clk),
.rst_n(rst_n),
.f_layer(f_layer_0),
.data_in(data_out),

.sort_finish(sort_finish_0),
.data_out(data_out_dut0)
);

top dut1 (
.t_clk(t_clk),
.rst_n(rst_n),
.f_layer(f_layer_1),
.data_in(data_out_dut0),

.sort_finish(sort_finish_1),
.data_out(data_out)
);

endmodule

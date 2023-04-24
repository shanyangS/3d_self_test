module top
(
	input wire t_clk,
	input wire rst_n,
	input wire f_layer,
	input wire data_in,

	output wire tx_out,
	output wire sort_finish,
	output wire data_out
);
	wire clk_out8;
	wire tx_out;
	wire[31:0] data_de_out;
	wire[31:0] data_self_out;
	
eight_div u0
(
.clk(t_clk),
.rst_n(rst_n),
.clk_out8(clk_out8)
);

deserializer u1
(
.clk(clk_out8),
.rst_n(rst_n),
.data_in(data_in),
.data_out(data_de_out)
);

self_test u2
(
.clk(clk_out8),
.rst_n(rst_n),
.f_layer(f_layer),
.data_in(data_de_out),

.tx_out(tx_out),
.sort_finish(sort_finish),
.data_out(data_self_out)
);

serializer u3
(
.clk(clk_out8),
.rst_n(rst_n),
.en(tx_out),
.data_in(data_de_out),
.data_out(data_out)
);

endmodule

module top
(
	input wire t_clk,
	input wire rst_n,
	input wire f_layer,
	input wire data_in,

	output reg data_out
);

	wire[31:0] data_de_in;
	wire[31:0] data_de_out;

deserializer u0
(
.clk(t_clk),
.rst_n(rst_n),
.data_in(data_in),
.data_out(data_de)
);

self_test u1
(
.clk(t_clk),
.rst_n(rst_n),
.f_layer(f_layer),
.data_in(data_de_in),
.data_out(data_de_out)
);

serializer u2
(
.clk(t_clk),
.rst_n(rst_n),
.en(),
.data_in(data_de_out),
.data_out(data_out)
);

endmodule

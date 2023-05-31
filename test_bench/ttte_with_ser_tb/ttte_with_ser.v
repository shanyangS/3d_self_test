module ttte_with_ser (
    input wire t_clk,
    input wire rst_n,

    input wire tx_out,
    input wire[31:0] data_in,

    output wire data_out
);

wire div_8_clk;
wire rst_sync_o;
wire[7:0] data_out_8;

thirty_two_to_eight thirty_two_to_eight (
.div_8_clk(div_8_clk),
.rst_n(rst_sync_o),
.tx_out(tx_out),
.data_in(data_in),

.data_out(data_out_8)
);

serializer serializer (
.t_clk(t_clk),
.rst_n(rst_sync_o),
.data_in(data_out_8),

.data_out(data_out)
);

sync_async_reset sync_async_reset (
.div_8_clk(div_8_clk),
.rst_n(rst_n),

.rst_sync_o(rst_sync_o)
);

clk_eight_div clk_eight_div(
.clk(t_clk),
.rst_n(rst_n),

.clk_out8(div_8_clk)
);

endmodule

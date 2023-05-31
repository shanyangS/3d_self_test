module des_with_ettt(
    input wire t_clk,
    input wire rst_n,
    input wire data_in,
    
    output wire[31:0] data_out
);

wire rst_sync_o;
wire div_8_clk;
wire[7:0] data_out_8;

deserializer deserializer(
.t_clk(t_clk),
.rst_n(rst_sync_o),
.data_in(data_in),

.data_out(data_out_8)
);

eight_to_thirty_two ettt(
.div_8_clk(div_8_clk),
.rst_n(rst_sync_o),
.data_in(data_out_8),

.data_out(data_out)
);

clk_eight_div clk_eight_div(
.clk(t_clk),
.rst_n(rst_n),

.clk_out8(div_8_clk)
);

sync_async_reset reset(
.div_8_clk(div_8_clk),
.rst_n(rst_n),

.rst_sync_o(rst_sync_o)
);

endmodule
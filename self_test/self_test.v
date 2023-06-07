module top (
    input wire t_clk,
    input wire rst_n,

    input wire f_layer,

    input wire data_in,

    output wire sort_finish,
    output wire data_out   
);

/* general */
wire div_8_clk;
wire rst_sync_o;

/* deserializer */
wire[7:0] des_data_out;

/* eight_to_thirty_two */
wire[31:0] ettt_data_out;

/* self_test */
wire tx_out;
wire[31:0] st_data_out; 

/* thirty_two_to_eight */
wire[7:0] ttte_data_out;

clk_eight_div clk_eight_div (
.t_clk(t_clk),
.rst_n(rst_n),

.div_8_clk(div_8_clk)
);

sync_async_reset sync_async_reset (
.div_8_clk(div_8_clk),
.rst_n(rst_n),

.rst_sync_o(rst_sync_o)
);

deserializer deserializer (
.t_clk(t_clk),
.rst_n(rst_sync_o),

.data_in(data_in),

.data_out(des_data_out)
);

eight_to_thirty_two eight_to_thirty_two (
.div_8_clk(div_8_clk),
.rst_n(rst_sync_o),
.data_in(des_data_out),

.data_out(ettt_data_out)
);

self_test self_test (
.div_8_clk(div_8_clk),
.rst_n(rst_sync_o),
.f_layer(f_layer),
.data_in(ettt_data_out),

.tx_out(tx_out),
.sort_finish(sort_finish),
.data_out(st_data_out)
);

thirty_two_to_eight thirty_two_to_eight (
.div_8_clk(div_8_clk),
.rst_n(rst_sync_o),
.tx_out(tx_out),

.data_in(st_data_out),

.data_out(ttte_data_out)
);

serializer serializer (
.t_clk(t_clk),
.rst_n(rst_sync_o),

.data_in(ttte_data_out),

.data_out(data_out)
);
    
endmodule

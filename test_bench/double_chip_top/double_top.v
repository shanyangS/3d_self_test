module double_top (
    input wire t_clk,
    input wire rst_n,

    input wire f_layer_0, f_layer_1,

    output wire sort_finish_0, sort_finish_1,
    
    output wire[3:0] chip_id_0, chip_id_1,

    output wire[3:0] power_value_upper_0, power_value_upper_1,
    output wire[3:0] power_value_lower_0, power_value_lower_1,

    output wire data_out    
);

wire data_out_dut0;

top dut0 (
.t_clk(t_clk),
.rst_n(rst_n),
.f_layer(f_layer_0),
.data_in(data_out),

.sort_finish(sort_finish_0),

.chip_id(chip_id_0),

.power_value_upper(power_value_upper_0),
.power_value_lower(power_value_lower_0),

.data_out(data_out_dut0)
);

top dut1 (
.t_clk(t_clk),
.rst_n(rst_n),
.f_layer(f_layer_1),
.data_in(data_out_dut0),

.sort_finish(sort_finish_1),

.chip_id(chip_id_1),

.power_value_upper(power_value_upper_1),
.power_value_lower(power_value_lower_1),

.data_out(data_out)
);

endmodule

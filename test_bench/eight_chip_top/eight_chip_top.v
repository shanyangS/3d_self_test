module double_top (
    input wire t_clk,
    input wire rst_n,

    input wire f_layer_0, f_layer_1, f_layer_2, f_layer_3, f_layer_4, f_layer_5, f_layer_6, f_layer_7,

    output wire sort_finish_0, sort_finish_1, sort_finish_2, sort_finish_3, sort_finish_4, sort_finish_5, sort_finish_6, sort_finish_7,
        
    output wire[3:0] chip_id_0, chip_id_1, chip_id_2, chip_id_3, chip_id_4, chip_id_5, chip_id_6, chip_id_7,
    
    output wire[3:0] power_value_upper_0, power_value_upper_1, power_value_upper_2, power_value_upper_3, power_value_upper_4, power_value_upper_5, power_value_upper_6, power_value_upper_7,
    output wire[3:0] power_value_lower_0, power_value_lower_1, power_value_lower_2, power_value_lower_3, power_value_lower_4, power_value_lower_5, power_value_lower_6, power_value_lower_7, 

    output wire data_out    
);

wire data_out_dut0;
wire data_out_dut1;
wire data_out_dut2;
wire data_out_dut3;
wire data_out_dut4;
wire data_out_dut5;
wire data_out_dut6;

top dut0 (
.t_clk(t_clk),
.rst_n(rst_n),
.f_layer(f_layer_0),
.data_in(data_out_dut1),

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

.data_out(data_out_dut1)
);

top dut2 (
.t_clk(t_clk),
.rst_n(rst_n),


.f_layer(f_layer_2),

.data_in(data_out_dut1),

.sort_finish(sort_finish_2),

.chip_id(chip_id_2),

.power_value_upper(power_value_upper_2),
.power_value_lower(power_value_lower_2),

.data_out(data_out_dut2)
);

top dut3 (
.t_clk(t_clk),
.rst_n(rst_n),


.f_layer(f_layer_3),
.data_in(data_out_dut2),

.sort_finish(sort_finish_3),

.chip_id(chip_id_3),

.power_value_upper(power_value_upper_3),
.power_value_lower(power_value_lower_3),

.data_out(data_out_dut3)
);

top dut4 (
.t_clk(t_clk),
.rst_n(rst_n),


.f_layer(f_layer_4),
.data_in(data_out_dut3),

.sort_finish(sort_finish_4),

.chip_id(chip_id_4),

.power_value_upper(power_value_upper_4),
.power_value_lower(power_value_lower_4),

.data_out(data_out_dut4)
);

top dut5 (
.t_clk(t_clk),
.rst_n(rst_n),


.f_layer(f_layer_5),
.data_in(data_out_dut4),

.sort_finish(sort_finish_5),

.chip_id(chip_id_5),

.power_value_upper(power_value_upper_5),
.power_value_lower(power_value_lower_5),

.data_out(data_out_dut5)
);

top dut6 (
.t_clk(t_clk),
.rst_n(rst_n),


.f_layer(f_layer_6),
.data_in(data_out_dut5),

.sort_finish(sort_finish_6),

.chip_id(chip_id_6),

.power_value_upper(power_value_upper_6),
.power_value_lower(power_value_lower_6),

.data_out(data_out_dut6)
);

top dut7 (
.t_clk(t_clk),
.rst_n(rst_n),


.f_layer(f_layer_7),
.data_in(data_out_dut6),

.sort_finish(sort_finish_7),

.chip_id(chip_id_7),

.power_value_upper(power_value_upper_7),
.power_value_lower(power_value_lower_7),

.data_out(data_out)
);

endmodule

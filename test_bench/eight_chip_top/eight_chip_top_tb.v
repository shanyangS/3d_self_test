`timescale 1ns/1ns

module eight_chip_top_tb;
    reg t_clk, rst_n;
    reg f_layer_0, f_layer_1, f_layer_2, f_layer_3, f_layer_4, f_layer_5, f_layer_6, f_layer_7;
    wire sort_finish_0, sort_finish_1, sort_finish_2, sort_finish_3, sort_finish_4, sort_finish_5, sort_finish_6, sort_finish_7;
    wire data_out;
    
    wire[3:0] chip_id_0, chip_id_1, chip_id_2, chip_id_3, chip_id_4, chip_id_5, chip_id_6, chip_id_7;
    wire[3:0] power_value_upper_0, power_value_upper_1, power_value_upper_2, power_value_upper_3, power_value_upper_4, power_value_upper_5, power_value_upper_6, power_value_upper_7;
    wire[3:0] power_value_lower_0, power_value_lower_1, power_value_lower_2, power_value_lower_3, power_value_lower_4, power_value_lower_5, power_value_lower_6, power_value_lower_7;

initial begin            
    $dumpfile("wave_eight_chip_top.vcd");
    $dumpvars(0, eight_chip_top_tb);
end

double_top dut (
.t_clk(t_clk),
.rst_n(rst_n),

.f_layer_0(f_layer_0),
.f_layer_1(f_layer_1),
.f_layer_2(f_layer_2),
.f_layer_3(f_layer_3),
.f_layer_4(f_layer_4),
.f_layer_5(f_layer_5),
.f_layer_6(f_layer_6),
.f_layer_7(f_layer_7),

.sort_finish_0(sort_finish_0), 
.sort_finish_1(sort_finish_1),
.sort_finish_2(sort_finish_2), 
.sort_finish_3(sort_finish_3),
.sort_finish_4(sort_finish_4), 
.sort_finish_5(sort_finish_5),
.sort_finish_6(sort_finish_6), 
.sort_finish_7(sort_finish_7),

.chip_id_0(chip_id_0),
.chip_id_1(chip_id_1),
.chip_id_2(chip_id_2),
.chip_id_3(chip_id_3),
.chip_id_4(chip_id_4),
.chip_id_5(chip_id_5),
.chip_id_6(chip_id_6),
.chip_id_7(chip_id_7),

.power_value_upper_0(power_value_upper_0),
.power_value_upper_1(power_value_upper_1),
.power_value_upper_2(power_value_upper_2),
.power_value_upper_3(power_value_upper_3),
.power_value_upper_4(power_value_upper_4),
.power_value_upper_5(power_value_upper_5),
.power_value_upper_6(power_value_upper_6),
.power_value_upper_7(power_value_upper_7),

.power_value_lower_0(power_value_lower_0),
.power_value_lower_1(power_value_lower_1),
.power_value_lower_2(power_value_lower_2),
.power_value_lower_3(power_value_lower_3),
.power_value_lower_4(power_value_lower_4),
.power_value_lower_5(power_value_lower_5),
.power_value_lower_6(power_value_lower_6),
.power_value_lower_7(power_value_lower_7),

.data_out(data_out)  
);

initial begin
    t_clk = 0;
    forever #5 t_clk = ~t_clk;
end

initial begin
    rst_n = 0;
    #10 rst_n = 1; 
    f_layer_0 = 1;
    f_layer_1 = 0;

    #8000 $finish;
end

endmodule

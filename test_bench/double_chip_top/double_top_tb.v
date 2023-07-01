`timescale 1ns/1ns

module double_top_tb;
    reg t_clk, rst_n, f_layer_0, f_layer_1;
    wire sort_finish_0, sort_finish_1, data_out;
    
    wire[3:0] chip_id_0, chip_id_1;
    wire[3:0] power_value_upper_0, power_value_upper_1;
    wire[3:0] power_value_lower_0, power_value_lower_1;

initial begin            
    $dumpfile("wave_double_top.vcd");
    $dumpvars(0, double_top_tb);
end

double_top dut (
.t_clk(t_clk),
.rst_n(rst_n),

.f_layer_0(f_layer_0),
.f_layer_1(f_layer_1),

.sort_finish_0(sort_finish_0), 
.sort_finish_1(sort_finish_1),

.chip_id_0(chip_id_0),
.chip_id_1(chip_id_1),

.power_value_upper_0(power_value_upper_0),
.power_value_upper_1(power_value_upper_1),

.power_value_lower_0(power_value_lower_0),
.power_value_lower_1(power_value_lower_1),

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

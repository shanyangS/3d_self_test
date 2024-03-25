`timescale 1ns/1ns
module self_test_tb;

	reg div_8_clk;
	reg rst_n;
	reg f_layer;
	reg [31:0] data_in;

	wire tx_out;
	wire sort_finish;
	wire [31:0] data_out;

	wire[3:0] chip_id;
	wire[4:0] power_value_upper;
	wire[4:0] power_value_lower;
	wire[4:0] power_value;

	initial begin            
		$dumpfile("wave_st.vcd");        //生成的vcd文件名称
		$dumpvars(0, self_test_tb);    //tb模块名称
	end

	self_test dut (
		.div_8_clk(div_8_clk),
		.rst_n(rst_n),
		.f_layer(f_layer),
		.data_in(data_in),
		
		.tx_out(tx_out),
		.sort_finish(sort_finish),
		.data_out(data_out),

		.chip_id(chip_id),
		.power_value_upper(power_value_upper), // change
		.power_value_lower(power_value_lower), // change
		.power_value(power_value) // change
	);

	initial begin
		div_8_clk = 0;
		forever #40 div_8_clk = ~div_8_clk;
	end

	initial begin
		div_8_clk = 0; rst_n = 0; f_layer = 0; data_in = 32'd0; // Test IDLE TO Receive

		#100 rst_n = 1;

		#1000 data_in = 32'b1010_00100_0001_0010_1011_1110_1110_111; // Test Receive to Response (Wait on purpose)

		// #8000 rst_n = 0; #2000 rst_n = 1;

		// #1000 data_in = 32'b1010_01100_0001_0010_1011_1110_1110_111;

		// #2000 rst_n = 0; #2000 rst_n = 1;

		// #1000 data_in = 32'b1010_01100_0010_0011_1011_1110_1110_111;

		#8000 rst_n = 0; f_layer = 1; 
		#2000 rst_n = 1; 

		#480000 $finish; // Wait a very long time to test the limit time
	end

endmodule

`timescale 1ns/1ns
module self_test_tb;

	reg clk;
	reg rst_n;
	reg f_layer;
	reg [31:0] data_in;

	wire tx_out;
	wire sort_finish;
	wire [31:0] data_out;

    initial
        begin            
            $dumpfile("wave_st.vcd");        //生成的vcd文件名称
            $dumpvars(0, self_test_tb);    //tb模块名称
        end

	self_test dut (
		.clk(clk),
		.rst_n(rst_n),
		.f_layer(f_layer),
		.data_in(data_in),
        
        .tx_out(tx_out),
		.sort_finish(sort_finish),
		.data_out(data_out)
	);

	initial begin
		clk = 0;
		rst_n = 1;
		f_layer = 0;
		data_in = 32'd3;

		#100;
		rst_n = 0;
		#100;
		rst_n = 1;

		#100;
        data_in = 32'b11_1010_10101_10110_1011_1010_1110_0001;

		#100;
		rst_n = 0;
		#100;
		rst_n = 1;

		#1000;
		data_in = 32'b11_1010_00001_00010_1011_1110_1010_1111;

        #100;
		rst_n = 0;
		#100;
		rst_n = 1;

		#1000;
		data_in = 32'b11_1010_00111_01000_1011_1110_1010_1111;

        #100;
		rst_n = 0;
		#100;
		rst_n = 1;

        #1000;
        f_layer = 1;

        #2000;
		$finish;
	end

	always #20 clk = ~clk;

endmodule
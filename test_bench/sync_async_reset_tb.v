`timescale 1ns/1ns

module sync_async_reset_tb();
	reg clk;
	reg rst_n;
	wire rst_sync_o;
	
	initial
		begin            
    			$dumpfile("wave_sync.vcd");        
    			$dumpvars(0, sync_async_reset_tb);   
		end

	
	sync_async_reset u1
	(
	.clk(clk),
	.rst_n(rst_n),
	.rst_sync_o(rst_sync_o)	
	);
	
	initial
		begin
			clk = 0;
			rst_n = 1;
			
			#20 rst_n = 0; #20 rst_n = 1;
			#200 rst_n = 0; #20 rst_n = 1;
			#300 rst_n = 0; #20 rst_n = 1;
			
			$finish;
		end
		
	always #50 clk = ~clk;

endmodule

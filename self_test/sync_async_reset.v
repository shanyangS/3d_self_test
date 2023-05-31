module sync_async_reset
(
	input wire div_8_clk,
	input wire rst_n,
	output wire rst_sync_o
);

reg rst_s1, rst_s2;

 always@(posedge div_8_clk or negedge rst_n)
	if(!rst_n) begin
		rst_s1 <= 1'b0;
		rst_s2 <= 1'b0;
	end else begin
		rst_s1 <= 1'b1;
		rst_s2 <= rst_s1;	
	end

assign rst_sync_o = rst_s2;

endmodule

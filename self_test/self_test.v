module self_test
(
	input wire clk,
	input wire rst_n,
	input wire f_layer,
	input wire[31:0] data_in,

	output reg[31:0] data_out
);

	parameter idle=0, rx_0=1, tx_0=2, rx_1=3, standby=4;
	
	reg[2:0] state, next_state;
	reg[3:0] sub_state, sub_next_state;
	reg[2:0] chip_id;

/* main_fsm */
	always@(*)
		begin
			case(state)
				idle: next_state = f_layer?tx_0:rx_0;
				rx_0: next_state = (data[15:0] = 16'hBEAF)?tx_0:rx_0;
				tx_0: //需要嵌套状态机
					begin
						case(sub_state)
							0001:;
							0010:;
							0011:;
							0100:;
							0101:;
							0110:;
							0111:;
							1000:;
							1001:;
							1010:;
							1011:;
							1100:;
							1101:;
							1110:;
							1111:;
						endcase
					end
				rx_1: next_state = (data_in ||)?standby:rx_1;
				standby:;
				default: next_state <= state;
			endcase
		end

	always@(posedge clk or negedge rst_n)
		begin
			if(!rst_n)
				state <= idle;
			else
				state <= next_state;
		end


	always@(*)
		begin
		end

/* main_fsm */

/* sub_fsm */
	always@(posedge clk or negedge rst_n)
		begin
			if(!rst_n)
				sub_state <= 4'b0001;
			else
				sub_state <= sub_next_state;
		end
/* sub_fsm */

endmodule

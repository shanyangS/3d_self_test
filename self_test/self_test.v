module self_test
(
	input wire clk,
	input wire rst_n,
	input wire f_layer,
	input wire[31:0] data_in,

	output reg tx_out,
	output wire sort_finish,
	output reg[31:0] data_out
);

	parameter idle=0, rx_0=1, tx_0=2, rx_1=3, standby=4;
	reg[2:0] state, next_state;
	reg[5:0] cnt;
	
	reg[3:0] p_state, power_value;
	reg[4:0] chip_id; 


/* main_fsm */
	always@(*)
		begin
			case(state)
				idle:
					begin
						if(f_layer) begin
							next_state = tx_0;
							chip_id = 5'b0001;
						end
						else
							next_state = rx_0;
					end
				rx_0: //receive_stage
					begin
						if(data_in[15:0] == 16'hBEAF)
							begin
								chip_id = data_in[20:16];
								next_state = tx_0;
							end
						else
							next_state = rx_0;
					end
				tx_0: //transfer_stage
					begin
						data_out = {2'b11, p_state, chip_id, (chip_id + 1'b1), 16'hBEAF};
						tx_out = 1'b1;
						power_value = p_state; //reg
						begin
							if(p_state < 4'b1111)
								p_state = p_state + 1;
							else
								p_state = p_state;
						end
						next_state = rx_1;
					end
				rx_1: 
					begin
						tx_out = 1'b0;
						if((cnt <= 6'd35 && data_in[15:0] == 16'hBEAF) || (cnt >= 6'd35 && p_state == 4'b1111))
							begin
								next_state = standby;
							end
						else
							next_state = tx_0;
					end
				standby:
					next_state = standby;
				default: next_state = state;
			endcase
		end

	always@(posedge clk or negedge rst_n)
		begin
			if(!rst_n)
				begin
					state <= idle;
					data_out <= 'b0;
					chip_id <= 0;
					cnt <= 0;
					p_state <= 4'b0001;
				end
			else if(state == rx_1)
				begin
					if(cnt == 6'd35)
						cnt <= 'b0;
					else
						begin
							cnt <= cnt + 1'b1;
							state <= next_state;
						end
				end
			else
				begin
					state <= next_state;
				end
		end

	assign sort_finish = (state == standby) || f_layer;

endmodule

module self_test
(
	input wire clk,
	input wire rst_n,
	input wire f_layer,
	input wire upper_story
	input wire[31:0] data_in,

	output reg en,
	output reg receive,
	output reg[31:0] data_out,
	output wire sort_finish
);

	parameter idle=0, rx_0=1, tx_0=2, rx_1=3, standby=4;
	reg[2:0] state, next_state;
	reg[5:0] cnt;
	reg[3:0] power_set;
	reg[4:0] chip_id; 

/* main_fsm */
	always@(*)
		begin
			case(state)
				idle: next_state = f_layer?tx_0:rx_0;
				rx_0:
					begin
						if(data[15:0] = 16'hBEAF)
							begin
								power_set = data[29:16];
								chip_id = data[20:16];
								next_state = tx_0;
							end
						else
							next_state = rx_0;
					end
				tx_0:
					begin
						power;
						data_out = {2'b10, p_state, chip_id, (chip_id + 1'b1), 16'hBEAF};
					end
				rx_1: 
					begin
						if(cnt == 6'd32 && (data_in <= 32'd3))
							next_state <= tx_0;
						else if(data[15:0] == 16'hBEAF || p_state == 4'b1111)
							next_state <= standby;
					end
				standby:
					next_state <= standby;
				default: next_state = state;
			endcase
		end

	always@(posedge clk or negedge rst_n)
		begin
			if(!rst_n)
				begin
					state <= idle;
					data_out <= 'b0;
					en <= 0;
					chip_id <= 0;
					cnt <= 0;
				end
			else
				cnt <= cnt + 1'b1;
				state <= next_state;
		end

assign sort_finish = (state == standby);

/* sub_fsm */
reg[3:0] p_cnt;
reg[3:0] p_state,p_next_state;

task power;
	begin
		case(p_state)
			4'b0001:
				begin
					if(p_cnt == 0)
						begin
							p_next_state <= p_state;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b0010:
				begin
					if(p_cnt == 1)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b0011:
				begin
					if(p_cnt == 2)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state_next <= p_state + 1'b1;
				end

			4'b0100:
				begin
					if(p_cnt == 3)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b0101:
				begin
					if(p_cnt == 4)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b0110:
				begin
					if(p_cnt == 5)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b0111:
				begin
					if(p_cnt == 6)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b1000:
				begin
					if(p_cnt == 7)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b1001:
				begin
					if(p_cnt == 8)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b1010:
				begin
					if(p_cnt == 9)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b1011:
				begin
					if(p_cnt == 10)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b1100:
				begin
					if(p_cnt == 11)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b1101:
				begin
					if(p_cnt == 12)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b1110:
				begin
					if(p_cnt == 13)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

			4'b1111:
				begin
					if(p_cnt == 14)
						begin
							p_next_state <= p_state;
							p_cnt <= p_cnt + 1'b1;
						end
					else	
						p_next_state <= p_state + 1'b1;
				end

		endcase
	end
endtask

	always@(posedge clk or negedge rst_n)
		begin
			if(!rst_n)
				p_state <= 4'b0001;
			else
				p_state <= p_next_state;
		end

endmodule

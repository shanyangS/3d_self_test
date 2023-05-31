module self_test
(
	input wire clk,
	input wire rst_n,
	input wire f_layer,
	input wire[31:0] data_in,

	output wire tx_out,
	output wire sort_finish,
	output reg[31:0] data_out
);

	parameter idle=0, rx_0=1, tx_0=2, rx_1=3, standby=4;
	reg[2:0] state, next_state;
	reg[3:0] cnt;
	
	reg[3:0] p_state, power_value;
	reg[3:0] chip_id; 


/* main_fsm */
always@(*) begin
	case(state)
		idle: begin
				if(f_layer) begin
					next_state = tx_0;
					chip_id = 4'b0000;
				end
				else
					next_state = rx_0;
		end
		rx_0: begin //receive_stage 
			if(data_in[15:0] == 16'hBEAF)
				begin
					chip_id = data_in[19:16];
					next_state = tx_0;
				end
			else
				next_state = rx_0;
		end
		tx_0: begin//transfer_stage
			data_out = {4'b1010, p_state, chip_id, (chip_id + 1'b1), 16'hBEAF};
			power_value = p_state; //reg
			begin
				if(p_state < 4'b1111)
					p_state = p_state + 1;
				else
					p_state = p_state;
			end
			next_state = rx_1;
		end
		rx_1: begin
			if((cnt <= 4'd14 && data_in[15:0] == 16'hBEAF && data_in[23:20] == (chip_id + 1'b1)) || (cnt >= 4'd14 && p_state == 4'b1111))
				next_state = standby;
			else if(cnt >= 4'd14)
				next_state = tx_0;
			else
				next_state = rx_1;
		end
		standby:
			next_state = standby;
		default: next_state = state;
	endcase
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		state <= idle;
		data_out <= 'b0;
		chip_id <= 0;
		cnt <= 0;
		power_value <= 4'b0001;
		p_state <= 4'b0001;
	end else if(state != rx_1) begin
		cnt <= 'b0;
		state <= next_state;
	end else if(state == rx_1) begin
		if(cnt == 4'd15)
			cnt <= 'b0;
		else begin
			cnt <= cnt + 1'b1;
			state <= next_state;
		end
	end else
		state <= next_state;
end

assign tx_out = (state == tx_0);
assign sort_finish = (state == standby) || f_layer;

endmodule

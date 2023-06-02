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
	reg[4:0] cnt;
	
	reg[3:0] p_state, power_value;
	reg[3:0] chip_id;


/* main_fsm */
always@(*) begin
	case(state)
		idle: begin
			power_value = 4'b0001;
			p_state = 4'b0001;
			if(f_layer)
				next_state = tx_0;
			else
				next_state = rx_0;
		end
		rx_0: begin //receive_stage 
			if(data_in[15:0] == 16'hBEEF)
				next_state = tx_0;
			else
				next_state = rx_0;
		end
		tx_0: begin//transfer_stage
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
			if((cnt <= 5'd20 && data_in[15:0] == 16'hBEEF && data_in[23:20] == (chip_id + 1'b1)) || (cnt >= 5'd20 && p_state == 4'b1111))
				next_state = standby;
			else if(cnt >= 5'd20)
				next_state = tx_0;
			else
				next_state = rx_1;
		end
		standby: begin
			next_state = standby;
		end
		default: next_state = state;
	endcase
end

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		state <= idle;
		cnt <= 0;
	end else if(state != rx_1) begin
		cnt <= 'b0;
		state <= next_state;
	end else if(state == rx_1) begin
		if(cnt == 5'd21)
			cnt <= 'b0;
		else begin
			cnt <= cnt + 1'b1;
			state <= next_state;
		end
	end else
		state <= next_state;
end

/* chip_id */
always@(*) begin
	case(state)
		idle: begin
			if(f_layer)
				chip_id = 4'b0001;
			else
				chip_id = 4'b0000;
		end
		rx_0: begin
			if(data_in[15:0] == 16'hBEEF)
				chip_id = data_in[19:16];
			else
				chip_id = chip_id;
		end
		default: chip_id = chip_id;	
	endcase
end

/* data_out */
always@(*) begin
	case(state)
		tx_0: data_out = {4'b1010, p_state, chip_id, (chip_id + 1'b1), 16'hBEEF};
		default: data_out = 'b0;
	endcase
end

assign tx_out = (state == tx_0);
assign sort_finish = (state == standby) || f_layer;

endmodule

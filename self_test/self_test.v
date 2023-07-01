module self_test
(
	input wire div_8_clk,
	input wire rst_n,
	input wire f_layer,
	input wire[31:0] data_in,

	output wire tx_out,
	output wire sort_finish,
	output reg[31:0] data_out,

	output reg[3:0] chip_id,
	output reg[3:0] power_value_upper,
	output reg[3:0] power_value_lower
);

	parameter idle=0, rx_0=1, reply=2, tx_0=3, rx_1=4, standby=5;
	reg[2:0] state, next_state;
	reg[4:0] cnt;

/* main_fsm */
always@(*) begin
	case(state)
		idle: begin
			if(f_layer)
				next_state = tx_0;
			else
				next_state = rx_0;
		end
		rx_0: begin //receive_stage 
			if(data_in[15:0] == 16'hBEEF)
				next_state = reply;
			else
				next_state = rx_0;
		end
		reply: begin
			next_state = tx_0;
		end
		tx_0: begin //transfer_stage
			next_state = rx_1;
		end
		rx_1: begin
			if((cnt <= 5'd20 && data_in[15:0] == 16'hBEEF && data_in[23:20] == (chip_id + 1'b1)) || (cnt >= 5'd20 && power_value_lower == 4'b1111))
				next_state = standby;
			else if(cnt >= 5'd20)
				next_state = tx_0;
			else
				next_state = rx_1;
		end
		standby: begin
			next_state = standby;
		end
		default: next_state = idle;
	endcase
end

/* state */
always@(posedge div_8_clk or negedge rst_n) begin
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

/* power_value_upper */
always@(posedge div_8_clk or negedge rst_n) begin
    if(!rst_n)
		power_value_upper <= 4'b0000;
	else if(state == rx_0 || next_state == reply)
		power_value_upper <= data_in[27:24]; //test
	else
		power_value_upper <= power_value_upper;
end

/* power_value_lower */
always@(posedge div_8_clk or negedge rst_n) begin
    if(!rst_n)
		power_value_lower <= 4'b0000;
    else if(next_state == tx_0 && power_value_lower < 4'b1111)
        power_value_lower <= power_value_lower + 1'b1;
	else
		power_value_lower <= power_value_lower;
end

/* chip_id */
always@(posedge div_8_clk or negedge rst_n) begin
	if(!rst_n)
		chip_id <= 4'b0000;
	else case(state)
		idle: begin
			if(f_layer)
				chip_id <= 4'b0001;
			else
				chip_id <= 4'b0000;
		end
		rx_0: begin
			if(data_in[15:0] == 16'hBEEF)
				chip_id <= data_in[19:16];
			else
				chip_id <= chip_id;
		end
		default: chip_id <= chip_id;	
	endcase
end

/* data_out */
always@(*) begin
	case(state)
		reply: data_out = {4'b1010, power_value_upper, chip_id, (chip_id + 1'b1), 16'hBEEF};
		tx_0: data_out = {4'b1010, power_value_lower, chip_id, (chip_id + 1'b1), 16'hBEEF};
		default: data_out = 'b0;
	endcase
end

assign tx_out = (state == tx_0);
assign sort_finish = (state == standby) || f_layer;

endmodule

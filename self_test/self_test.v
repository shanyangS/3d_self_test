module self_test (
	input wire div_8_clk,
	input wire rst_n,
	input wire f_layer,
	input wire[31:0] data_in,

	output wire tx_out,
	output wire sort_finish,
	output reg[31:0] data_out,

	output reg[3:0] chip_id,
	output reg[4:0] power_value_upper, // change
	output reg[4:0] power_value_lower, // change
	output reg[4:0] power_value // change
);

	parameter idle=0, rx_0=1, reply=2, wait_state=3, 
	tx_0=4, rx_1=5, standby=6;
	reg[2:0] state, next_state;
	reg[4:0] cnt;
	reg[3:0] count_wait_state;

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
			if((data_in[22:19] < data_in[18:15]) && data_in[14:0] == 15'b1011_1110_1110_111) // this section change from 16'hBEEF to 15'h5F77
				next_state = reply;
			else
				next_state = rx_0;
		end
		reply: begin
			next_state = wait_state;
		end
		wait_state: begin
			if(count_wait_state >= 4'd8)
				next_state = tx_0;
			else
				next_state = wait_state;
		end
		tx_0: begin //transfer_stage
			next_state = rx_1;
		end
		rx_1: begin
			if((cnt <= 5'd20 && data_in[14:0] == 15'b1011_1110_1110_111 && data_in[22:19] == (chip_id + 1'b1)) || (cnt >= 5'd20 && power_value_lower == 5'b11111)) // change
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
		power_value_upper <= 5'b00000; // change
	else if(state == rx_0 || next_state == reply)
		power_value_upper <= data_in[27:23]; //test
	else
		power_value_upper <= power_value_upper;
end

/* power_value_lower */
always@(posedge div_8_clk or negedge rst_n) begin
    if(!rst_n)
		power_value_lower <= 5'b00000;
    else if(next_state == tx_0 && power_value_lower < 5'b11111)
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
			if((data_in[22:19] < data_in[18:15]) && data_in[14:0] == 15'b1011_1110_1110_111) // change
				chip_id <= data_in[18:15];
			else
				chip_id <= chip_id;
		end
		default: chip_id <= chip_id;	
	endcase
end

/* data_out */
always@(*) begin
	case(state)
		reply: data_out = {4'b1010, power_value_upper, chip_id, (chip_id - 1'b1), 15'b1011_1110_1110_111};
		tx_0: data_out = {4'b1010, power_value_lower, chip_id, (chip_id + 1'b1), 15'b1011_1110_1110_111};
		default: data_out = 'b0;
	endcase
end

assign tx_out = (state == tx_0) || (state == reply);
assign sort_finish = (state == standby) || f_layer;

/* count_wait_state */
always@(posedge div_8_clk or negedge rst_n) begin
	if(!rst_n)
		count_wait_state <= 'b0;
	else if(state == wait_state)
		count_wait_state <= count_wait_state + 1'b1;
	else
		count_wait_state <= 'b0;
end

/* power_value */
always@(posedge div_8_clk or negedge rst_n) begin
	if(!rst_n)
		power_value <= 'b0;
	else if((state == wait_state) || (state == reply))
		power_value <= power_value_upper;
	else if((state == tx_0) || (state == rx_1))
		power_value <= power_value_lower;
	else
		power_value <= 'b0;
end

endmodule

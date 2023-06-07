module deserializer (
    input wire t_clk,
    input wire rst_n,

    input wire data_in,
    
    output reg[7:0] data_out
);

reg[2:0] state, next_state;
reg[4:0] cnt;
reg[7:0] data_reg;
reg receive_finish;

/* FSM_en */
always@(*) begin //parity_bit:11
    case(state)
        3'b000: next_state = (data_in)?3'b001:3'b000;
        3'b001: next_state = (!data_in)?3'b010:3'b001;
        3'b010: next_state = (data_in)?3'b011:3'b000;
        3'b011: next_state = (!data_in)?3'b100:3'b001;
        3'b100: next_state = 3'b101;
        3'b101: next_state = (cnt == 5'd28)?((data_in)?3'b001:3'b000):3'b101;
        default: next_state = 3'b000;
    endcase
end

//state
always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n)
        state <= 3'b000;    
    else
        state <= next_state;
end

//cnt
always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n)
        cnt <= 'b0;
    else if(cnt >= 5'd28)
        cnt <= 'b0;
    else if(next_state == 3'b101)
        cnt <= cnt + 1'b1;
end

//data_reg
always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n)
        data_reg <= 'b0;
    else begin
        case(next_state)
            3'b001: data_reg <= {data_reg[6:0],1'b1};
            3'b010: data_reg <= {data_reg[6:0],1'b0};
            3'b011: data_reg <= {data_reg[6:0],1'b1};
            3'b100: data_reg <= {data_reg[6:0],1'b0};
            3'b101: data_reg <= {data_reg[6:0],data_in};
            default: data_reg <= data_reg;
        endcase
    end
end

//data_out
always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n)
        data_out <= 'b0;
    else if(cnt == 5'd4 || cnt == 5'd12 || cnt == 5'd20 || cnt == 5'd28)
        data_out <= data_reg;
    else
        data_out <= data_out;
end

endmodule

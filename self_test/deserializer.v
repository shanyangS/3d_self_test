module deserializer (
    input wire t_clk,
    input wire rst_n,

    input wire data_in,
    
    output reg[7:0] data_out
);

reg[2:0] state, next_state;
reg[4:0] cnt;
reg[7:0] data_reg;

/* FSM_en */
always@(*)
    begin //parity_bit:11
        case(state)
            3'b000: begin
                if(data_in)
                    next_state = 3'b001;
                else
                    next_state = 3'b000;
            end
            3'b001: begin
                if(!data_in)
                    next_state = 3'b010;
                else
                    next_state = 3'b001; 
            end
            3'b010: begin
                if(data_in)
                    next_state = 3'b011;
                else
                    next_state = 3'b000;
            end
            3'b011: begin
                if(!data_in)
                    next_state = 3'b100;
                else
                    next_state = 3'b001;
            end
            3'b100:
                next_state = 3'b101;
            3'b101:
                if(cnt >= 5'd28) begin
                    if(data_in)
                        next_state = 3'b001;
                    else
                        next_state = 3'b000;
                end else
                    next_state = 3'b101;
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

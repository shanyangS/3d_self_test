module eight_to_thirty_two (
    input wire div_8_clk,
    input wire rst_n,
    input wire[7:0] data_in,

    output reg[31:0] data_out
);

reg state, next_state;
reg[2:0] cnt;
reg[31:0] data_reg;

always@(*) begin
    case(state)
        1'b0: begin
            if(data_in[7:4] == 4'b1010)
                next_state = 1'b1;
            else
                next_state = 1'b0;
        end
        1'b1: begin
            if(cnt >= 4)
                next_state = 1'b0;
            else
                next_state = 1'b1; 
        end
    endcase
end

always@(posedge div_8_clk or rst_n)
    if(!rst_n)
        state <= 1'b0;
    else
        state <= next_state;

always@(posedge div_8_clk or rst_n)
    if(!rst_n)
        data_reg <= 'b0;
    else if(next_state == 1'b1)
        data_reg <= {data_reg[23:0],data_in};
    else
        data_reg <= data_reg;

always@(posedge div_8_clk or rst_n)
    if(!rst_n)
        data_out <= 'b0;
    else if(data_reg[31:28] == 4'b1010 && data_reg[15:0] == 16'hBEAF)
        data_out <= data_reg;
    else
        data_out <= data_out;

always@(posedge div_8_clk or rst_n)
    if(!rst_n)
        cnt <= 'b0;
    else if(cnt >= 4)
        cnt <= 'b0;
    else if(next_state == 1'b1)
        cnt <= cnt + 1'b1;
    else
        cnt <= 'b0;

endmodule

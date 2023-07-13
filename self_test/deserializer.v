module deserializer (
    input wire t_clk,
    input wire rst_n,

    input wire data_in,
    
    output reg data_i_o,
    output reg[7:0] data_out
);

reg state, next_state;
reg[7:0] data_reg;
reg[4:0] cnt;

always@(*) begin
    case(state)
        1'b0: next_state = (data_reg[3:0] == 4'b1010)?1'b1:1'b0;
        1'b1: next_state = (cnt == 5'd28)?1'b0:1'b1;
        default: next_state = 1'b0; 
    endcase
end

/* state */
always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n)
        state <= 1'b0;
    else
        state <= next_state;
end

/* recognize 1010 */
always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n)
        data_reg <= 4'b0000;
    else
        data_reg <= {data_reg[6:0], data_in};
end

/* cnt */
always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n)
        cnt <= 5'b00000;
    else if(next_state == 1'b1)
        cnt <= cnt + 1'b1;
    else
        cnt <= 'b0;
end

/* data_out */
always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n)
        data_out <= 'b0;
    else if(cnt == 5'd4 || cnt == 5'd12 || cnt == 5'd20 || cnt == 5'd28)
        data_out <= data_reg;
    else
        data_out <= data_out;
end

always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n)
        data_i_o <= 'b0;
    else
        data_i_o <= data_in;
end

endmodule

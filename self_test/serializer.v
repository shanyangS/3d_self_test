module serializer (
input wire t_clk,    
input wire rst_n,

input wire[7:0] data_in,

output reg data_out
);

reg[2:0] counter;
reg[7:0] shift_reg; 

always@(*) begin
    if(counter == 3'b000)
        shift_reg = data_in;
end

always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n) begin
        shift_reg <= 'b0;
    end else begin
        shift_reg <= {shift_reg[6:0], 1'b0};
    end
end

always@(posedge t_clk or negedge rst_n) begin
    if(!rst_n)
        counter <= 'b0;
    else
        counter <= counter + 1'b1;
end

always@(*) begin
    if(!rst_n)
        data_out = 'b0;
    else
        data_out = shift_reg[7];
end

endmodule

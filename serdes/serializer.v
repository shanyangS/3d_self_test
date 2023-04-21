module serializer
(
    input wire clk,
    input wire rst_n,
    input wire en, //data_i change
    input wire[31:0] data_in,

    output reg data_out
);

reg[31:0] data_buf;
wire clk_out8;

eight_div s1
(
.rst_n(rst_n),
.clk(clk),
.clk_out8(clk_out8)
);

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        data_o <= 1'b0;
        data_buf <= 32'b0;
    end
    else if(en)
        data_buf <= data_i;
    else
        data_buf <= data_buf << 1;
end

assign data_o = data_buf[31];

endmodule
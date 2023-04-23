module serializer
(
    input wire clk,
    input wire rst_n,
    input wire en,
    input wire[31:0] data_in,

    output reg data_out
);

reg[31:0] data_buf;

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        data_out <= 1'b0;
        data_buf <= 32'b0;
    end
    else if(en)
        data_buf <= data_in;
    else
        data_buf <= data_buf << 1;
end

always@(*)
begin
    data_out = data_buf[31];
end

endmodule

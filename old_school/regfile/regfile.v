module regfile (
	input wire clk,
    input wire en,
    input wire[191:0] data_in,

    output reg shift_out
);

    reg[191:0] rf;

    initial begin
        rf = 'b0;
        shift_out = 'b0;
    end

    always @(posedge clk) begin
        if(~en)
            rf <= data_in;
        else begin
            rf <= {rf[190:0],1'b0};
        end
    end

    always@(posedge clk)
        shift_out <= rf[191];

endmodule


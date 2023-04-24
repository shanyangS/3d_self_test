module eight_div
    (
    input     wire clk,
    input     wire rst_n,

    output    reg clk_out8
    );
		
		reg clk_out2;
		reg clk_out4;

    always@(posedge clk_in or negedge rst)
        begin
            if(!rst)
                clk_out2 <= 0;
            else
                clk_out2 <= ~clk_out2;
        end
    
    always@(posedge clk_out2 or negedge rst)
        begin
            if(!rst)
                clk_out4 <= 0;
            else
                clk_out4 <= ~clk_out4;
        end

    always@(posedge clk_out4 or negedge rst)
        begin
            if(!rst)
                clk_out8 <= 0;
            else
                clk_out8 <= ~clk_out8;
        end

endmodule

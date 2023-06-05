module clk_eight_div (
input wire t_clk,
input wire rst_n,

output reg div_8_clk
);
    
reg clk_out2;
reg clk_out4;

always@(posedge t_clk or negedge rst_n)
    begin
        if(!rst_n)
            clk_out2 <= 0;
        else
            clk_out2 <= ~clk_out2;
    end

always@(posedge clk_out2 or negedge rst_n)
    begin
        if(!rst_n)
            clk_out4 <= 0;
        else
            clk_out4 <= ~clk_out4;
    end

always@(posedge clk_out4 or negedge rst_n)
    begin
        if(!rst_n)
            div_8_clk <= 0;
        else
            div_8_clk <= ~div_8_clk;
    end

endmodule

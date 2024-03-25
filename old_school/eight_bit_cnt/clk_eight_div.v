module clk_eight_div (
input wire t_clk,
input wire rst_n,

output wire div_8_clk
);
    
reg [2:0]cnt;

always@(posedge t_clk or negedge rst_n)
    if(!rst_n)
        cnt <= 3'b011;
    else
        cnt <= cnt+1;
    
assign div_8_clk = cnt[2];

endmodule

module eight_bit_cnt (
    input wire clk, trig,
    output reg[8:0] count,
    output reg en
);
    reg trig_pulse;
    reg trig_reg;

    reg[8:0] c_reg;

    initial begin
        c_reg = 'b0;
        count = 'b0;
    end

    /* trig_pulse */
    always @(posedge clk) begin
        if (trig_reg == 1'b1 && trig == 1'b0) 
            trig_pulse <= 1'b1;
        else 
            trig_pulse <= 1'b0;
        trig_reg <= trig;
    end

    /* cnt */
    always@(posedge clk) begin
        c_reg <= c_reg + 1'b1;
    end
    
    /* count */
    always@(posedge clk) begin
        if (trig_pulse && en)
            count <= c_reg;
    end
    
    /* en */
    always@(posedge clk) begin
    	en = c_reg[8];
    end

endmodule


module deserializer
(
    input wire clk,
    input wire rst_n,
    input wire data_in,

    output reg[31:0] data_out
);

reg[1:0] state, next_state;
reg en;
wire clk_out8;

eight_div d1
(
    .rst_n(rst_n),
    .clk(clk),
    .clk_out8(clk_out8)
);

/* FSM_en */
always@(*)
    begin
        case(state)
            2'b00:
                begin
                    if(data_in)
                        state <= 2'b01;
                    else
                        state <= 2'b00;
                end
            2'b01:
                begin
                    if(data_in)
                        state <= 2'b10;
                    else
                        state <= 2'b01; 
                end
            2'b10:
                begin
                    if(cnt == 30)
                        state <= 2'b10;
                    else
                        state <= 2'b00;
                end
        endcase
    end

always@(posedge clk_out8 or negedge rst_n) 
    begin
        if(!rst_n)
            begin
                state <= 2'b00;
                en <= 0;
            end
        else if(cnt == 30)
            begin
                state <= next_state;
                cnt <= 0;
            end
        else if(en)
            begin
                state <= next_state;
                cnt <= cnt + 1;    
            end
        else
            begin
                state <= next_state;
                cnt <= cnt;
            end
    end

assign en = (state == 2'b10);

/* Right_Shift */
always@(posedge clk_out8 or negedge rst_n)
    begin
        if(!rst_n)
            data_o <= 32'b0000_0000_0000_0000_0000_0000_0000_0011;
        else if(en)
            data_o <= {data_o[30:0], data_i};
        else
            data_o <= data_o;
    end

endmodule
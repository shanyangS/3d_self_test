module deserializer
(
    input wire t_clk,
    input wire clk,
    input wire rst_n,
    input wire data_in,

    output reg[31:0] data_out
);

reg[1:0] state, next_state;
reg[4:0] cnt;
reg gg;
wire en;

/* FSM_en */
always@(*)
    begin //parity_bit:11
        case(state)
            2'b00:
                begin
                    if(data_in)
                        begin
                            next_state <= 2'b01;
                            gg <= 1'b0;
                        end
                    else
                            next_state <= 2'b00;
                end
            2'b01:
                begin
                    if(data_in)
                        next_state <= 2'b10;
                    else
                        next_state <= 2'b00; 
                end
            2'b10:
                begin
                    if(cnt == 5'd30)
                        begin
                            next_state <= 2'b00;
                            gg <= 1'b1; //ok to send
                        end
                    else
                        next_state <= 2'b10;
                end
        endcase
    end

always@(posedge clk or negedge rst_n) 
    begin
        if(!rst_n)
            begin
                state <= 2'b00;
                cnt <= 'b0;
                gg <= 'b0;
            end
        else if(cnt == 5'd30)
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
always@(posedge clk or negedge rst_n)
    begin
        if(!rst_n || gg)
            data_out <= 32'b0000_0000_0000_0000_0000_0000_0000_0011;
        else if(en)
            data_out <= {data_out[31:0], data_in};
        else
            data_out <= data_out;
    end

endmodule

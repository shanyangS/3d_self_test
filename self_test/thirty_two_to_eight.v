module thirty_two_to_eight (
    input wire div_8_clk,
    input wire rst_n,
    input wire tx_out,
    
    input wire[31:0] data_in,

    output reg[7:0] data_out
);

localparam[2:0] idle = 3'b000,
                S_0 = 3'b001,
                S_1 = 3'b010,
                S_2 = 3'b011,
                S_3 = 3'b100,
                wait_state = 3'b101;

reg[2:0] state, next_state;
reg[31:0] data_buffer;

always@(posedge div_8_clk) begin
    if(tx_out)
        data_buffer <= data_in;
    else
        data_buffer <= data_buffer;
end

always @(*) begin
    case (state)
        idle: begin 
            if(tx_out)
                next_state = S_0;
            else
                next_state = idle;
        end
        S_0: next_state = S_1;
        S_1: next_state = S_2;
        S_2: next_state = S_3;
        S_3: next_state = wait_state;
        wait_state: begin
            if(tx_out)
                next_state = S_0;
            else
                next_state = wait_state;
        end
        default: next_state = S_0;
    endcase
end

always @(posedge div_8_clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= idle;
        data_out <= 'b0;
        data_buffer <= 'b0;
    end else
        state <= next_state;
end

always@(*) begin
    case(state)
        S_0: begin
            data_out <= data_buffer[31:24];
            
        end
        S_1: begin
            data_out <= data_buffer[23:16];
        end
        S_2: begin
            data_out <= data_buffer[15:8];
        end
        S_3: begin
            data_out <= data_buffer[7:0];
        end
        default: data_out <= 'b0;
    endcase
end

endmodule
module spi_slave (input i_Rst_L,          // FPGA Reset, active low
                  input i_Clk,            // FPGA Clock// PLL ref clock
                  output o_RX_DV,         // Data Valid pulse (1 clock cycle)
                  output [7:0] o_RX_Byte, // Byte received on MOSI
                  input i_TX_DV,          // Data Valid pulse to register i_TX_Byte
                  input [7:0] i_TX_Byte,  // Byte to serialize to MISO.
                  input i_SPI_Clk,
                  output o_SPI_MISO,
                  input i_SPI_MOSI,
                  output o_TX_Busy,
                  input i_SPI_CS_n);      // active low
    
    
    // SPI Interface (All Runs at SPI Clock Domain)
    //   wire w_CPOL;     // Clock polarity
    //   wire w_CPHA;     // Clock phase
    // wire w_SPI_Clk;  // Inverted/non-inverted depending on settings
    wire w_SPI_CLK_P;// spi_clk rising edge
    wire w_SPI_CLK_N;// spi_clk falling edge
    wire w_SPI_CS_Vaild;// spi_cs vaild(drop low)
    wire w_SPI_MISO_Mux;
    
    reg [1:0]r_SPI_CLK;// SPI_CLK reg
    reg [1:0]r_SPI_CS; // SPI_CS reg
    reg [2:0] r_RX_Bit_Count;
    reg [2:0] r_TX_Bit_Count;
    reg [7:0] r_Temp_RX_Byte;
    reg [7:0] r_RX_Byte;
    reg r_RX_Done;
    reg [7:0] r_TX_Byte;
    reg [7:0] r_TX_Byte_Temp;
    reg r_SPI_MISO_Bit;
    reg r_TX_Busy;
    // CPOL: Clock Polarity
    // CPOL = 0 means clock idles at 0, leading edge is rising edge.
    // CPOL = 1 means clock idles at 1, leading edge is falling edge.
    //   assign w_CPOL = (SPI_MODE == 2) | (SPI_MODE == 3);
    
    // CPHA: Clock Phase
    // CPHA = 0 means the "out" side changes the data on trailing edge of clock
    //              the "in" side captures data on leading edge of clock
    // CPHA = 1 means the "out" side changes the data on leading edge of clock
    //              the "in" side captures data on the trailing edge of clock
    //   assign w_CPHA = (SPI_MODE == 1) | (SPI_MODE == 3);
    
    //   assign w_SPI_Clk = w_CPHA ? ~i_SPI_Clk : i_SPI_Clk;
    
    
    // Purpose: Get the edge of the spi_clk
    always @(posedge i_Clk or negedge i_Rst_L) begin
        if (~i_Rst_L) begin
            r_SPI_CLK <= {2'b00};
        end
        else begin
            r_SPI_CLK[0] <= r_SPI_CLK[1];
            r_SPI_CLK[1] <= i_SPI_Clk;
        end
    end
    
    // Purpose : to get the edge of the clock
    assign w_SPI_CLK_N = r_SPI_CLK[0] & ~r_SPI_CLK[1];
    assign w_SPI_CLK_P = ~r_SPI_CLK[0] & r_SPI_CLK[1];
    
    // Purpose : to get the edge of the SPI_CS
    always @(posedge i_Clk or negedge i_Rst_L) begin
        if (~i_Rst_L) begin
            r_SPI_CS <= {2'b00};
        end
        else begin
            r_SPI_CS[0] <= r_SPI_CS[1];
            r_SPI_CS[1] <= i_SPI_CS_n;
        end
    end
    assign w_SPI_CS_Vaild = r_SPI_CS[0] & ~r_SPI_CS[1];
    
    // Purpose: Recover SPI Byte in SPI Clock Domain
    // Samples line on correct edge of SPI Clock
    always @(posedge i_Clk or negedge i_Rst_L) begin
            //if (~i_Rst_L || w_SPI_CS_Vaild) begin
        if (~i_Rst_L) begin
            r_RX_Bit_Count <= 0;
            r_RX_Done      <= 0;
            r_Temp_RX_Byte <= 0;
        end
        else begin
            if (w_SPI_CS_Vaild) begin
                r_RX_Bit_Count <= 0;
                r_RX_Done      <= 0;
                r_Temp_RX_Byte <= 0;
            end
            else begin
                if (w_SPI_CLK_P) begin
                    // Receive in LSB, shift up to MSB
                    r_Temp_RX_Byte <= {r_Temp_RX_Byte[6:0], i_SPI_MOSI};
                    if (r_RX_Bit_Count < 3'b111) begin
                        r_RX_Bit_Count <= r_RX_Bit_Count + 1;
                    end
                    else if (r_RX_Bit_Count == 3'b111)begin
                        r_RX_Bit_Count <= 0;
                        r_RX_Done      <= 1'b1;
                        r_RX_Byte      <= {r_Temp_RX_Byte[6:0], i_SPI_MOSI};
                    end
                    else begin
                        r_Temp_RX_Byte <= r_Temp_RX_Byte;
                        r_RX_Bit_Count <= r_RX_Bit_Count;
                        r_RX_Done      <= 0;
                    end
                end
                else begin
                    r_RX_Done <= 0;
                end
            end
        end
    end
    assign o_RX_Byte = r_RX_Byte;
    assign o_RX_DV   = r_RX_Done;
    
    
    // Purpose: Transmits 1 SPI Byte whenever SPI clock is toggling
    // Will transmit read data back to SW over MISO line.
    // Want to put data on the line immediately when CS goes low.
    always @(posedge i_Clk or negedge i_Rst_L) begin
            //if (~i_Rst_L || w_SPI_CS_Vaild) begin
        if (~i_Rst_L) begin
            r_TX_Bit_Count <= 3'b111;
            //r_SPI_MISO_Bit <= i_TX_Byte[3'b111];
            r_SPI_MISO_Bit <= 0;
        end
        else begin
            if(w_SPI_CS_Vaild) begin
                r_TX_Bit_Count <= 3'b111;
                r_SPI_MISO_Bit <= i_TX_Byte[3'b111];
            end
            else begin
                if(w_SPI_CLK_N) begin // Mode 0 : Data change in the sceond edge(falling)
                    if(r_TX_Bit_Count > 0) begin
                        r_TX_Bit_Count <= r_TX_Bit_Count - 1'b1;
                        r_SPI_MISO_Bit <= i_TX_Byte[r_TX_Bit_Count - 1];
                    end
                    else begin
                        r_TX_Bit_Count <= 3'b111;
                        r_SPI_MISO_Bit <= i_TX_Byte[3'b111];
                    end
                end
            end
        end
    end
    
    assign o_SPI_MISO = i_SPI_CS_n ? 1'b0 : r_SPI_MISO_Bit;



    always @(posedge i_Clk or negedge i_Rst_L) begin
            //if(~i_Rst_L || i_SPI_CS_n) begin
        if(~i_Rst_L ) begin
            r_TX_Busy <= 1'b0;
        end
        else begin
            if(i_SPI_CS_n)begin
                r_TX_Busy <= 1'b0;
            end
            else begin
                if(r_RX_Bit_Count == 7 && w_SPI_CLK_P) begin
                    r_TX_Busy <= 0;
                end
                else begin
                    r_TX_Busy <= 1;
                end
            end
        end
    end    
    assign o_TX_Busy = r_TX_Busy;

    always @(posedge i_Clk or negedge i_Rst_L) begin
        if(~i_Rst_L) begin
            r_TX_Byte <= 0;
        end
        else begin
            if(i_TX_DV) begin
                r_TX_Byte <= i_TX_Byte;
            end
        end
    end



        
 endmodule // SPI_Slave

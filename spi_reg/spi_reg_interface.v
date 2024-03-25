module spi_reg_interface (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       SPI_CLK,
    input  wire       SPI_MOSI,
    input  wire       SPI_SS,
    output wire       SPI_MISO,
    // pll
    output wire [5:0] reg_addr,
    output wire [7:0] wr_data,
    input  wire [7:0] rd_data,
    output wire       wr_en,
    output wire       rd_en,
    input  wire       rd_ready
);


    `define CMD_PLL_WR_RD_MODE 7

    `define STATE_IDLE 4'd0
    `define STATE_WRITE_PLL_REG 4'd7
    `define STATE_READ_PLL_REG 4'd8


    wire       spi_rx_vaild;
    wire [7:0] spi_rx_byte;
    reg        spi_tx_vaild;
    wire       spi_tx_busy;
    reg  [7:0] spi_tx_byte;



    reg  [3:0] state;
    reg   byte_cnt;


    // reg         axi_busy;

    // pll signal

    reg  [5:0] reg_reg_addr;
    reg  [7:0] reg_wr_data;
    reg        reg_wr_en;
    reg        reg_rd_en;

    assign wr_data = reg_wr_data;
    assign reg_addr    = reg_reg_addr;
    assign wr_en   = reg_wr_en;
    assign rd_en   = reg_rd_en;


    spi_slave u_spi_slave (
        .i_Rst_L   (rst_n),
        .i_Clk     (clk),
        .o_RX_DV   (spi_rx_vaild),
        .o_RX_Byte (spi_rx_byte),
        .i_TX_DV   (spi_tx_vaild),
        .i_TX_Byte (spi_tx_byte),
        .i_SPI_Clk (SPI_CLK),
        .o_TX_Busy (spi_tx_busy),
        .o_SPI_MISO(SPI_MISO),
        .i_SPI_MOSI(SPI_MOSI),
        .i_SPI_CS_n(SPI_SS)
    );


    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state               <= 0;
            spi_tx_vaild        <= 0;
            spi_tx_byte         <= 0;
            byte_cnt            <= 0;
            reg_reg_addr    <= 0;
            reg_wr_data <= 0;
            reg_wr_en   <= 0;
            reg_rd_en   <= 0;
        end else begin
            case (state)
                `STATE_IDLE: begin
                    // 接收到了有效的指令 
                    if (spi_rx_vaild && spi_rx_byte != 8'd0 && spi_rx_byte != 8'hff) begin  // 模式译码
                        //if(spi_rx_byte[`CMD_MODE_PLL_AXI] == 1'b1 && spi_rx_byte[1:0] == 2'b10) begin // 操作 PLL 寄存器
                            reg_reg_addr <= spi_rx_byte[5:0];
                            if(spi_rx_byte[7:6] == 2'b10) begin // PLL 寄存器写
                                state <= `STATE_WRITE_PLL_REG;
                            end
                            else if(spi_rx_byte[7:6] == 2'b01) begin // PLL 寄存器读
                                reg_reg_addr <= spi_rx_byte[5:0];
                                reg_rd_en <= 1'b1;
                                byte_cnt <= 1'd1;
                                state <= `STATE_READ_PLL_REG;
                            end
                        //end
                    end
                end


                `STATE_WRITE_PLL_REG: begin
                    if (spi_rx_vaild) begin
                        reg_wr_data <= spi_rx_byte;
                        reg_wr_en   <= 1'b1;
                    end
                    if (reg_wr_en == 1'b1) begin
                        reg_wr_en <= 1'b0;
                        state             <= `STATE_IDLE;
                    end
                end

                `STATE_READ_PLL_REG: begin
                    reg_rd_en <= 1'b0;
                    spi_tx_byte       <= rd_data;
                    spi_tx_vaild      <= 1'b1;
                    if (spi_tx_vaild) begin
                        spi_tx_vaild <= 1'b0;
                    end
                    if (~spi_tx_busy) begin
                        if (byte_cnt == 1'd1) begin
                            byte_cnt <= 1'b0;
                        end else begin
                            state <= `STATE_IDLE;
                        end
                    end

                end

            endcase
        end
    end


endmodule


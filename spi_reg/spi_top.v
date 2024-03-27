`timescale 1ns / 1ps
module spi_top 
(
    input  wire clk,
    input  wire rst_n,
    // SPI Interface
    input  wire SPI_CLK,
    input  wire SPI_MOSI,
    input  wire SPI_SS,
    output wire SPI_MISO,

    // CSR interface
    output wire [8*24-1:0] control_o,
    input wire [8*40-1:0] status_i
);

    wire [5:0] reg_addr;
    wire [7:0] reg_wr_data;
    wire [7:0] reg_rd_data;
    wire       reg_wr_en;
    wire       reg_rd_en;
    wire       reg_rd_ready;

    spi_reg_interface u_spi_reg_interface (
        .clk             (clk),
        .rst_n           (rst_n),
        .SPI_CLK         (SPI_CLK),
        .SPI_MOSI        (SPI_MOSI),
        .SPI_SS          (SPI_SS),
        .SPI_MISO        (SPI_MISO),
        .reg_addr    (reg_addr),
        .wr_data (reg_wr_data),
        .rd_data (reg_rd_data),
        .wr_en   (reg_wr_en),
        .rd_en   (reg_rd_en),
        .rd_ready(reg_rd_ready)
    );


    inst_reg  #(8,49,19)
    u_inst_reg (
        .clk     (clk),
        .rst_n   (rst_n),
        .reg_addr(reg_addr),
        .wr_data (reg_wr_data),
        .rd_data (reg_rd_data),
        .wr_en   (reg_wr_en),
        .rd_en   (reg_rd_en),
        .rd_ready(reg_rd_ready),
        .control_o(control_o),
        .status_i(status_i)
    );


endmodule

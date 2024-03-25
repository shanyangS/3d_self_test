
`default_nettype none 
`timescale 1ns / 1ps

module tb_spi_top;
    reg        clk;
    reg        pll_ref_clk;
    reg        rst_n;
    reg        SPI_CLK;
    reg        SPI_MOSI;
    reg        SPI_SS;
    wire       SPI_MISO;

wire [8*24-1:0] control_o;
reg  [8*40-1:0] status_i=0;

    initial begin
`ifdef DUMP_VPD
        $vcdpluson();
        $fsdbDumpfile("spi_sim.fsdb");
        $fsdbDumpvars(0);
`endif
    end
    localparam SPI_CLK_PERIOD = 50;
    localparam CLK_PERIOD = 10;
    localparam PLL_REF_CLOCK_PERIOD = 100;
    task spiTxStart;
        begin
            SPI_SS = 0;
            #120;
        end
    endtask
    task spiTxStop;
        begin
            SPI_SS = 1;
            #120;
        end
    endtask

    task spiExchByte;
        input [7:0] byteToSend;
        output [7:0] recvByte;
        reg     [7:0] recvByte;
        integer       bitIndex;
        begin
            SPI_CLK  = 1'b0;
            bitIndex = 7;
            while (bitIndex >= 0) begin
                SPI_MOSI = byteToSend[bitIndex];
                SPI_CLK  = 1'b0;
                #(SPI_CLK_PERIOD / 2);
                SPI_CLK            = 1'b1;
                recvByte[bitIndex] = SPI_MISO;
                bitIndex           = bitIndex - 1;
                #(SPI_CLK_PERIOD / 2);
            end
            SPI_CLK = 0;
        end
    endtask

    task spiSendByte;
        input [7:0] byteToSend;
        reg [7:0] recvByte;
        begin
            spiExchByte(byteToSend, recvByte);
        end
    endtask

    task spiRecvByte;
        output [7:0] recvByte;
        reg [7:0] recvByte;
        begin
            spiExchByte(8'hFF, recvByte);
            // $display("recvByte: %x", recvByte);
        end
    endtask



    task spiWritePLLReg;
        input [5:0] reg_addr;
        input [7:0] reg_wr_data;
        begin
            spiTxStart();
            spiSendByte( {2'b10,reg_addr});
            spiSendByte(reg_wr_data);
            spiTxStop();
            $display("%0d\t\t write pllreg: %0h \tval: %0h", $time,
                     reg_addr, reg_wr_data);
        end
    endtask

    task spiReadPLLReg;
        input [5:0] reg_addr;
        reg [7:0] recvByte;
        begin
            spiTxStart();
            spiSendByte({2'b01,reg_addr});
            spiSendByte(8'hff);
            spiRecvByte(recvByte);
            $display("%0d\t\t read pllreg: %0h \tval: %0h", $time,
                     reg_addr, recvByte);
            spiTxStop();
        end
    endtask






    spi_top u_spi_top (
        .clk    (clk),
        .rst_n      (rst_n),
        .SPI_CLK    (SPI_CLK),
        .SPI_MOSI   (SPI_MOSI),
        .SPI_SS     (SPI_SS),
        .SPI_MISO   (SPI_MISO),
        .control_o(control_o),
        .status_i(status_i)
    );

    initial begin
        clk <= 0;
        forever begin
            #(CLK_PERIOD / 2) clk <= ~clk;
        end
    end
    initial begin
        pll_ref_clk <= 0;
        forever begin
            #(PLL_REF_CLOCK_PERIOD / 2) pll_ref_clk <= ~pll_ref_clk;
        end
    end

    initial begin
        rst_n <= 0;
        #(CLK_PERIOD * 10);
        rst_n <= 1;
    end

    initial begin
        SPI_MOSI = 0;
        SPI_SS   = 1;
        SPI_CLK  = 0;
    end

    reg     [64:0] rx_reg;
    integer        i;
    integer        error = 0;
    
    initial begin
        for(i=0;i<40;i=i+1) begin
            status_i[i*8 +:8]<=i;
        end
    end
    
    initial begin
        @(posedge rst_n);
        #(CLK_PERIOD);
        
spiWritePLLReg(0, 0);
spiReadPLLReg(0);

spiWritePLLReg(5, 08'hbc);
spiReadPLLReg(5);
    
// for (i=0;i<24;i=i+1) begin
//     spiWritePLLReg(i, i);
//     #10 spiReadPLLReg(i);
// end
// for (i=0;i<64;i=i+1) begin
//     spiReadPLLReg(i);
// end


        //LD_OUT <= 1;
        //wait (pll_locked);
        //$display("%0d\t\t pll locked ", $time);
        #(CLK_PERIOD * 1000);
        $finish;
    end


endmodule
`default_nettype wire

module inst_reg 
#(parameter REG_WIDTH=8,
parameter REG_DEEPTH_O=24,
parameter REG_DEEPTH_I=40) (
    input  wire       clk,
    input  wire       rst_n,
    // from spi
    input  wire [5:0] reg_addr,
    input  wire [REG_WIDTH-1:0] wr_data,
    output wire [REG_WIDTH-1:0] rd_data,
    input  wire       wr_en,
    input  wire       rd_en,
    output wire       rd_ready,
    // output reg 
    output wire [REG_WIDTH*REG_DEEPTH_O-1:0] control_o,
    //input reg
    input wire [REG_WIDTH*REG_DEEPTH_I-1:0] status_i
);

    reg [7:0] reg_array[REG_DEEPTH_O+REG_DEEPTH_I-1:0];

    reg       r_rd_ready;
    assign rd_ready = r_rd_ready;

    reg [REG_WIDTH-1:0] r_rd_data;
    assign rd_data  = r_rd_data;

    genvar  i;
    for (i=0;i<REG_DEEPTH_O;i=i+1) begin: control_o_assignment
        assign control_o[i*REG_WIDTH +: REG_WIDTH]=reg_array[i];
    end

integer ii;
// write reg
always @(posedge clk or negedge rst_n) begin  
    if (~rst_n) begin
        for (ii=0;ii<REG_DEEPTH_O;ii=ii+1) begin: RST_REG_O
            reg_array[ii]<={REG_WIDTH{1'b0}};
        end
    end
    else begin
        if(wr_en) begin
            for (ii=0;ii<REG_DEEPTH_O;ii=ii+1) begin: REG_O_WR  //from 0 to REG_DEEPTH_O can be write
                if(reg_addr==ii)begin
                    reg_array[ii] <= wr_data;
                end
            end
        end
        for(ii=0;ii<REG_DEEPTH_I;ii=ii+1) begin: REG_I_WR  //from 0 to REG_DEEPTH_O can be write
            reg_array[ii+REG_DEEPTH_O]<=status_i[ii*REG_WIDTH +: REG_WIDTH];
        end
    end
end

// read reg
always @(posedge clk or negedge rst_n) begin  
    if (~rst_n) begin
        r_rd_data  <= {REG_WIDTH{1'b0}};
        r_rd_ready <= 1'b0;
    end else begin
        if(rd_en) begin
            for(ii=0;ii<(REG_DEEPTH_O+REG_DEEPTH_I);ii=ii+1) begin: REG_RD   //from 0 to REG_DEEPTH_O+REG_DEEPTH_I can be write
                if(reg_addr==ii) begin
                    r_rd_data<=reg_array[ii];
                end
            end
        end
    end
end




endmodule

module FIFO(data_in,wr_en,clk,rst,data_out,rd_en,full,empty);
parameter data_width  =8;
parameter address_width = 4;
parameter ram_depth = 16;

input rst,Wr_en,rd_en,clk;
input [data_width-1:0]data_in;
output [data_width-1:0]data_out;
output full,empty;

reg [address_width-1:0]wr_pointer,rd_pointer;
reg[address_width:0]status_counter;
wire [data_width-1:0] data_ram;

always @(posedge clk, posedge rst)
begin
    if(rst)
    begin
        wr_pointer <= 0;
    end
    else
    begin
        if(wr_en)
        begin
            wr_pointer <= wr_pointer+1;
        end
    end
end

always @(posedge clk, posedge rst)
begin
    if(rst)
    begin
        rd_pointer <= 0;
    end
    else
    begin
        if(rd_en)
        begin
            rd_pointer <= rd_pointer+1;
        end
    end
end

always @(posedge clk, posedge rst)
begin
    if(rst)
    begin
        data_out <= 0;
    end
    else
    begin
        if(rd_en)
        begin
            data_out <= data_ram;
        end
    end
end

always @(posedge clk, posedge rst)
begin
    if(rst)
    begin
        status_counter <= 0;
    end
    else if((wr_en && ! rd_en) && (status_counter != ram_depth))
    begin
        status_counter <= status_counter+1;
    end
    else if((rd_en && !wr_en) && (status_counter != 0))
    begin
        status_counter <= status_counter-1;
    end
end

assign full = (status_counter == (ram_depth));
assign empty = (status_counter == 0);

Dual_ram UUT (.Clk(clk),.wr_en(wr_en), .rd_en(rd_en), .wr_addr(wr_pointer), .rd_addr(rd_pointer), .Din(data_in), .Dout(data_out))

endmodule

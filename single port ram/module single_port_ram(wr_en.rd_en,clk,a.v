module single_port_ram(wr_en,rd_en,clk,addr,data);
input clk,wr_en,rd_en;
input [3:0]addr;
inout [7:0]data;
reg [7:0] mem [15:0];
reg temp;
assign data = (rd_en ==1 && !wr_en==1)?temp:8'bz;
always @(posedge clk)
begin
    if(wr_en && !rd_en)
    begin
        mem[addr] <= data;
    end
    else if(rd_en && !wr_en)
    begin
        temp <= mem[addr];
    end
end
endmodule
    
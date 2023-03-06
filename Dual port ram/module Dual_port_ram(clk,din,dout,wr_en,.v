module Dual_port_ram(clk,din,dout,wr_en,rd_en,wr_addr,rd_addr);
input clk,wr_en,rd_en;
input [7:0]din;
input [3:0]wr_addr,rd_addr;
output reg [7:0]dout;
reg [7:0] mem [15:0];
always @(posedge clk)
begin
    if(wr_en)
      mem[wr_addr] <= din;
    
    if(rd_en)
      dout <= mem[rd_addr];
end
endmodule
module dualport(clk,Din,Dout,re,we,wa,ra);
input [7:0]Din;
input clk,re,we;
input [3:0]wa,ra;
output reg[7:0]Dout;
reg [7:0]mem[15:0];
always@(posedge clk)
begin
    if(we)
    mem[wa]<=Din;
    if(re)
    Dout<=mem[ra];
end
endmodule

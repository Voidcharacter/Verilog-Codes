module Asynch(rst,clk,Q);
input rst,clk;
output wire[2:0]Q;
wire[2:0]w;
T_ff a(1'b1,clk,rst,Q[0],w[0]);
T_ff b(1'b1,w[0],rst,Q[1],w[1]);
T_ff c(1'b1,w[1],rst,Q[2],w[2]);
endmodule
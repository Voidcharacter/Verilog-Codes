module Asynch(rst,clk,Qa);
input rst,clk;
output wire[2:0]Qa;
wire[2:0]w;
T_ff a(1'b1,clk,rst,Qa[0],w[0]);
T_ff b(1'b1,w[0],rst,Qa[1],w[1]);
T_ff c(1'b1,w[1],rst,Qa[2],w[2]);
endmodule
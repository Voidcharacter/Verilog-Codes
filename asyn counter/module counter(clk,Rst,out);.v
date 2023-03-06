module counter(clk,Rst,out);
  input clk,Rst;
  output [2:0]out;
  wire [2:0]w;
  T_ff t1(1'b1,clk,Rst,out[1],w[1]);
  T_ff t2(1'b1,w[0],Rst,out[2],w[2]);
  T_ff t3(1'b1,w[1],Rst,out[3],w[3]);
endmodule
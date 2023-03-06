module t_ff(clk,T,rst,Q,Qa);
input clk,rst,T;
output reg Q,Qa;
always@(posedge clk)
begin
if(rst)
Q<=0;
else
begin
    if(T==1)
    Q<=~Q;
    else
    Q<=Q;
end
end
assign Qa=~Q;
endmodule


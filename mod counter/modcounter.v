module modcounter(clk,rst,Q,ld,lde);
input clk,rst,lde;
input [3:0]ld;
output reg [3:0]Q;
always@(posedge clk)
begin
    if(rst==1)
    begin
        Q<=0;
    end
    else
        begin
           if(lde==1)
           begin
            Q=ld;
           end
           else if(Q==10)
           begin
            Q<=0;
           end
           else
           begin
            Q<=Q+1;
           end
        end
end
endmodule

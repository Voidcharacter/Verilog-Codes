module melay(Din,Dout,clk,rst);
input Din,clk,rst;
output reg Dout;

reg [2:0] cur_state, nxt_state;

parameter s0=3'b000,s1=3'b001,s10=3'b010,s101 = 3'b011,s1010=3'b100;

always @(posedge clk, posedge rst)
begin
    if(rst)
        cur_state <= s1;
    else
    cur_state <= nxt_state;
end

always @(Din,cur_state)
begin
    case(cur_state)
    s0:  if(Din==0)
            nxt_state <= s0;
        else
            nxt_state <= s1;
    s1:  if(Din==1)
            nxt_state <= s1;
        else
            nxt_state <= s10;
    s10: if(Din==0)
            nxt_state <= s0;
        else
            nxt_state <= s101;
    s101:if(Din==1)
            nxt_state <= s1;
        else
            nxt_state <= s1010;
    s1010:if(Din==0)
            nxt_state <= s0;
        else
            nxt_state <= s101;
    default:nxt_state <= s1;
    endcase
end

always @(posedge clk)
begin
    case(cur_state)
    s0:  if(Din==0 || Din==1)
             Dout <= 0;
    s1:  if(Din ==0 || Din==1)
             Dout <= 0;
    s10: if(Din==0 || Din==1)
             Dout <= 0;
    s1010: if(Din==0 || Din==1)
             Dout <= 0;
    s101: if(Din==0)
             Dout <=1;
          else
             Dout <=0;
    endcase
end

endmodule


module moore2(Din,Dout,clk,rst);
input Din,clk,rst;
output Dout;

reg [2:0] cur_state,nxt_state;

parameter Idle = 3'b000,s1=3'b001,s11=3'b010,s110=3'b011,s10=3'b100,s101=3'b101;

always @(posedge clk,posedge rst)
begin
    if(rst)
    cur_state <= Idle;
    else
    cur_state <= nxt_state;
end

always @(Din,cur_state)
begin
    case(cur_state)
    Idle:if(Din ==0)
            nxt_state <= Idle;
        else
            nxt_state <= s1;
    s1:if(Din==1)
            nxt_state <= s11;
        else
            nxt_state <= s10;
    s11:if(Din==1)
            nxt_state <= s11;
        else
            nxt_state <= s110;
    s10:if(Din==0)
            nxt_state <= Idle;
        else
            nxt_state <= s101;
    s101:if(Din ==1)
            nxt_state <= s11;
        else
            nxt_state <= s10;
    s110:if(Din==0)
            nxt_state <= Idle;
        else
            nxt_state <= s101;
    default:nxt_state <= Idle;
    endcase
end

assign Dout = (cur_state == s101 || cur_state == s110)? 1'b1:1'b0;
endmodule
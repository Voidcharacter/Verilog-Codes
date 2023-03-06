module t_ff_tb();
reg clk,T,rst;
wire Q,Qa;
t_ff DUT(clk,T,rst,Q,Qa);
always 
begin
clk<=0;
#5;
clk<=1;
#5;
end
task initialize;
  begin
      T<=0;
      rst<=0;
  end
endtask
task reset_op(input a);
begin
    @(negedge clk)
    begin
    rst<=a;
    end
end
endtask
task T_op(input b);
begin
    @(negedge clk)
    begin
        T<=b;
    end
end
endtask
initial 
begin
    initialize;
    reset_op(1);
    #10;
    reset_op(0);
    #10;
    T_op(1);
    #20;
    T_op(0);
    #20;
end
endmodule





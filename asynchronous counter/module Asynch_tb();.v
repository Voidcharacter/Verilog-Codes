module Asynch_tb();
reg rst,clk;
wire[2:0]Q;
Asynch DUT(rst,clk,Q);
always
begin
    clk<=0;
    #5;
    clk<=1;
    #5;
end
task initialize;
begin
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
initial
begin
    initialize;
    #50;
    reset_op(1);
    #10
    reset_op(0);
    #10;
end 
endmodule       

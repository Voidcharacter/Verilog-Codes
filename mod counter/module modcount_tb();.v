module modcounter_tb();
reg clk,rst,lde;
reg [3:0]ld;
wire [3:0]Q;
modcounter DUT(clk,rst,Q,ld,lde);
integer i;
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
task reset_task(input a);
begin
    @(negedge clk)
    begin
    rst<=a;
    end
end
endtask
task load(input[3:0]b);
begin
    @(negedge clk)
    lde<=1;
    ld<=b;
end
endtask
initial
begin
    initialize;
    #10;
    reset_task(1);
    #50
    reset_task(0);
    #50
   for (i=0;i<4;i=i+1'b0)
   begin
    load(i);
    #10;
   end
end
endmodule


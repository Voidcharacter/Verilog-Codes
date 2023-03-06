module melay_tb();
reg Din,clk,rst;
wire Dout;

melay DUT (Din,Dout,clk,rst);

always
begin
    clk <= 0;
    #10;
    clk <= 1;
    #10;
end

// Initialize task
task initialize;
begin
    Din <=0 ;
    rst <= 0;
end
endtask

//reset task 
task Reset();
begin
    @(negedge clk)
       rst <= 1;
       #20;
    @(negedge clk)
       rst <= 0;
       #20;
end
endtask

// Din Task
task Din_task(input a);
begin
    @(negedge clk)
       Din <= a;
end
endtask

// Initial Block 
initial
begin
    initialize;
    Reset;
    Din_task(1'b1);
    Din_task(1'b0);
    Din_task(1'b1);
    Din_task(1'b0);
    Din_task(1'b1);
    Din_task(1'b1);
    Din_task(1'b0);
    Din_task(1'b1);
    Din_task(1'b0);
    Din_task(1'b1);
end
endmodule
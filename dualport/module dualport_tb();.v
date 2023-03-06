module dualport_tb();
reg clk,re,we;
reg [3:0]ra,wa;
reg [7:0]Din;
wire [7:0]Dout;
integer i,j;
dualport DUT(clk,Din,Dout,re,we,wa,ra);
always 
begin    
    clk<=0;
    #5;
    clk<=1;
    #5;
end
task initialize;
begin
wa<=0;
ra<=0;
Din<=0;
end
endtask
task read_task(input[3:0]a);
begin
    @(negedge clk)
    begin
    re=1;
    ra<=a;
    end
end
endtask
task write_task(input[3:0]b,input[7:0]c);
begin
     @(negedge clk)
    begin
    we=1;
    wa<=b;
    Din<=c;
    end
end
endtask
initial
fork
    for(i=0;i<16;i=i+1)
    begin
        write_task(i,i);
    end
   #10 for(j=0;j<16;j=j+1)
    begin
        read_task(j);
    end
join
endmodule




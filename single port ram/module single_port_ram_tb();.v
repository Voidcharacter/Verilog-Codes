module single_port_ram_tb();
reg wr_en,rd_en,clk;
reg [3:0]addr;
wire [7:0]data;
reg [7:0]temp;
single_port_ram r1(wr_en,rd_en,clk,addr,data);
integer i,j;
always
begin
    clk<=1;
    #5;
    clk <= 0;
    #5;
end

task initialize;
begin
    wr_en <= 0;
    rd_en <= 0;
    addr <=0;
end
endtask

task write_task(input [3:0]a, input [7:0]b);
begin
    @(negedge clk)
    begin
        wr_en <=1;
        rd_en <=0;
        addr <= a;
        temp <= b;
    end
end
endtask

task read_task(input [3:0]c);
begin
    @(negedge clk)
    begin
        rd_en <= 1;
        wr_en <= 0;
        addr <= c;
    end
end
endtask

assign data = (wr_en && !rd_en)? temp:8'bz;
initial
begin
    initialize;
    for (i=0;i<16;i=i+1)
    begin
        write_task(i,i+1);
    end
    for(j=0;j<16;j=j+1)
    begin
        read_task(i);
    end
end
endmodule
module Dual_port_ram_tb();
reg clk,wr_en,rd_en;
reg [7:0]din,temp;
reg [3:0]wr_addr,rd_addr;
wire [7:0]dout;
Dual_port_ram DUT(clk,din,dout,wr_en,rd_en,wr_addr,rd_addr);
integer i,j;
always
begin
    clk <= 1;
    #10;
    clk <= 0;
    #10;
end

task initialize();
begin
    wr_en <= 0;
    rd_en <= 0;
    din <= 0;
    wr_addr <= 0;
    rd_addr <= 0;
end
endtask

task write_task(input [3:0]a,[7:0]data);
begin
    @(negedge clk)
    begin
        wr_en <= 1'b1;
        wr_addr <=  a;
        din <= data;
    end
end
endtask

task read_task(input [3:0]b);
begin
    @(negedge clk)
    begin
        rd_en <= 1'b1;
        rd_addr <= b;
        temp <= b;
    end
end
endtask

initial
fork
    initialize;
    for (i=0;i<16;i=i+1)
    begin
        write_task(i,i);
    end

    for(j=0;j<16;j=j+1)
    begin
        read_task(j);
    end
join
endmodule


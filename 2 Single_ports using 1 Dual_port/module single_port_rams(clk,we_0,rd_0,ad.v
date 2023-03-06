module single_port_rams(clk,wr_0,rd_0,addr_0,data_0,wr_1,rd_1,addr_1,data_1);
input clk,wr_0,wr_1,rd_0,rd_1;
input [3:0]addr_0,addr_1;
inout [7:0]data_0,data_1;
reg [7:0]temp_0,temp_1;
reg [7:0] mem [15:0];
always @(posedge clk)
begin
    if(rd_0 && !wr_0)
    begin
        temp_0 <= mem[addr_0];
    end
    else if(wr_0 && !rd_0)
    begin
        mem[addr_0] <= data_0;
    end
end

always @(negedge clk)
begin
    if(rd_1 && !wr_1)
    begin
        temp_1 <= mem[addr_1];
    end
    else if(wr_1 && !rd_1)
    begin
        mem[addr_1] <= data_1;
    end
end

assign data_0 = (rd_0 && !wr_0)? temp_0:8'bz;
assign data_1 = (rd_1 && !wr_1)? temp_1:8'bz;
endmodule
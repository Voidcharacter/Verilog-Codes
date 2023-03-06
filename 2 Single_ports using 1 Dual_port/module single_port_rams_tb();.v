module single_port_rams_tb();
reg clk,wr_0,wr_1,rd_0,rd_1;
reg [3:0]addr_0,addr_1;
wire [7:0]data_0,data_1;
reg [7:0]temp_0,temp_1;
single_port_rams DUT(clk,wr_0,rd_0,addr_0,data_0,wr_1,rd_1,addr_1,data_1);
integer i,j;
// Clock Generation
always
begin
    clk <=0;
    #5;
    clk <=1;
    #5;
end

// Initialize task
task initialize;
begin
    wr_0 <= 0;
    wr_1 <= 0;
    rd_0 <= 0;
    rd_1 <= 0;
    addr_0 <= 0;
    addr_1 <= 0;
end
endtask

// Write enable  task to drive two data's parallel
task write;
begin
    @(negedge clk)
    begin
        wr_0 <= 1;
        rd_0 <= 0;
    end
    @(posedge clk)
    begin
        wr_1 <= 1;
        rd_1 <= 0;
    end
end
endtask

// Read enable task to retrieve two data's at a time
task read();
begin
    @(negedge clk)
    begin
        wr_0 <= 0;
        rd_0 <= 1;
    end
    @(posedge clk)
    begin
        wr_1 <= 0;
        rd_1 <= 1;
    end
end
endtask

// Inpat data at negative edge without overriding //
task stimulus_0(input [3:0]a,input [7:0]b);
begin
    @(negedge clk)
    addr_0 <= a;
    temp_0 <= b;
end
endtask

// Input data at positive edge without overriding
task stimulus_1(input [3:0]c,input [7:0]d);
begin
    @(posedge clk)
    addr_1 <= c;
    temp_1 <= d;
end
endtask

initial
begin
    initialize;
    #10;
end

// Generating all possible addresses to input the specific data into specific address 
initial
fork
    #10 write;
    for(i=0;i<16;i=i+2'b10)
    begin
        stimulus_0(i,i);
    end
    for(j=1;j<16;j=j+2'b10)
    begin
        stimulus_1(j,j);
    end
join

initial 
begin
    #20 read;
end

// Reading all the possible data values from the specific address
initial
fork
    #40 for(i=0;i<16;i=1+2'b10)
    begin
        stimulus_0(i,i);
    end
    #40 for(j=1;j<16;j=j+2'b10)
    begin
        stimulus_1(j,j);
    end
join

// Terinary operator 
assign data_0 = (wr_0 && !rd_0)? temp_0:8'bz;
assign data_1 = (wr_1 && !rd_1)? temp_1:8'bz;
endmodule




 
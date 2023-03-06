module priorityencoder_tb();
reg [7:0]d;
wire [2:0]t;
integer i;
priorityencoder DUT(d,t);
always@(*)
begin
initial
begin
    for(i=0;i<256;i=i+1'b1)
    begin
        d=i;
        #10;
    end
end
end
endmodule

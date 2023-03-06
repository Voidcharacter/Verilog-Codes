module priorityencoder(d,t);
input[7:0]d;
output reg[2:0]t;
always@(*)
begin
casex (d)
    8'b00000001:t=3'b000;
    8'b0000001x:t=3'b001;
    8'b000001xx:t=3'b010;
    8'b00001xxx:t=3'b011;
    8'b0001xxxx:t=3'b100;
    8'b001xxxxx:t=3'b101;
    8'b01xxxxxx:t=3'b110;
    8'b1xxxxxxx:t=3'b111;
    default:t=1'b0; 
endcase
end
endmodule
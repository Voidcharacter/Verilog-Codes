module syn_counter(clk,Rst,out,ld_en,load);
   input clk,Rst,ld_en;
   input [3:0]load;
   output reg [3:0]out;
   always @(posedge clk)
     begin
        if(Rst==1)
            out<=0;

        else
            if(ld_en)
               out <= load;
            else
              out <= out+1;
     end
endmodule

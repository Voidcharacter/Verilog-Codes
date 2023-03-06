module syn_counter_tb();
   reg clk,Rst,ld_en;
   reg [3:0]load;
   wire [3:0]out;
   reg temp;
   assign out = (ld_en==0 | ld_en==1)? temp:4'bz;
   syn_counter d1(clk,Rst,out,ld_en,load);

   // clock Generation //
   always 
     begin
      clk <= 1;
      #10;
      clk <= 0;
      #10;
    end

    // Initialize the values to the ports //
    task initialize;
    begin
        Rst <= 0;
        ld_en <= 0;
        load <= 0;
        temp <= 0;
    end
    endtask

    // task for load 
    task load_task(input [3:0]a);
    begin
        @(negedge clk)
            begin
                ld_en <= 1;
                load <= a;
            end
        @(negedge clk)
           begin
                ld_en <= 0;
                temp <= temp+1;
           end
    end
    endtask

    // Reset task 
    task rst_tsk();
    begin
        @(negedge clk)
        Rst <=1;
        #10;
        @(negedge clk)
        Rst <= 0;
        #10;
    end
    endtask
    initial 
    begin
        initialize;
        load_task(4'b0011);
        #10;
        load_task(4'b0110);
        #10;        
    end
   endmodule





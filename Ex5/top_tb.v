//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Traffic Lights
// Student Name: Alex Goldie
// Date: 9/6/2020
//
// Description: A testbench module to test Ex5 - Traffic Lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    
    //Parameters
    parameter CLK_PERIOD = 10;

    //Registers and wires
    reg clk;
    wire [2:0] rag;
    reg [2:0] rag_prev;
    reg err;

    //rag[2:0] = [red amber green]


    //Clock generation
    initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
    
 //Todo: User logic
	initial begin
       	err=0;
       	rag_prev=rag;
    	clk = 0;
       forever begin
       #10

	 if ((rag_prev == 3'b111)|(rag_prev == 3'b101)|(rag_prev == 3'b011)|(rag_prev == 3'b000))
        begin
		if ((rag!=3'b100)|(rag!=3'b110)|(rag!=3'b001)|(rag!=3'b010)) begin
           $display("***TEST FAILED! Didn't recover from bad state, rag_prev==%d, rag='%d'***", rag_prev,rag,);
           err=1;
		end
     end

	 if ((rag_prev == 3'b100) & (rag != 3'b110))
		begin
		
           $display("***TEST FAILED! Red -> red amber! rag_prev==%d, reg==%d***", rag_prev,rag);
           err=1;
		end

	if ((rag_prev == 3'b110) & (rag != 3'b001))
		begin
		
           $display("***TEST FAILED! Red amber -> green! rag_prev==%d, reg==%d***", rag_prev,rag);
           err=1;
		end

	if ((rag_prev == 3'b001) & (rag != 3'b010))
		begin
		
           $display("***TEST FAILED! green -> amber! rag_prev==%d, reg==%d***", rag_prev,rag);
           err=1;
		end
	if ((rag_prev == 3'b010) & (rag != 3'b100))
		begin
		
           $display("***TEST FAILED! amber -> red! rag_prev==%d, reg==%d***", rag_prev,rag);
           err=1;
		end

	rag_prev = rag;
	
end
end

//Todo: Finish test, check for success
      initial begin
        #300 
        if (err==0)
          $display("***TEST PASSED! :) ***");
        $finish;
      end


    //User's module
    traffic top (
	 .clk (clk),
     .red (rag[2]),
     .amber (rag[1]),
	 .green (rag[0])
     );
     
endmodule 

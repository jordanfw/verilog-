// EE454 Lab7 ALU Design
// sample_func.v
// Written by Jordan Woods
// March 18, 2016
`timescale 1 ns / 1 ps

module sample_unary_tb ;

//UUT Params
reg  Clk_tb,Reset_tb;
reg  [7:0] init0_tb,init1_tb;
wire  [7:0] unary0_tb,unary1_tb;

//test changes.
reg [7:0] in0,in1;
 
parameter CLK_PERIOD = 20;

sample_unary UUT (Clk_tb,Reset_tb,init0_tb,init1_tb,unary0_tb,unary1_tb);

initial
  begin  : CLK_GENERATOR
    Clk_tb = 0;
    forever
       begin
	      #(CLK_PERIOD/2) Clk_tb = ~Clk_tb;
       end 
  end

initial
  begin  : RESET_GENERATOR
    Reset_tb = 1;
    #(2 * CLK_PERIOD) Reset_tb = 0;
  end
	


task func_test;
    begin

    Reset_tb = 0;
		init0_tb = in0;
		init1_tb = in1;    
		#(2 * CLK_PERIOD) Reset_tb = 1;
		
		#(CLK_PERIOD+5);
		Reset_tb=0;
		
		#(CLK_PERIOD+5);
		end
  endtask
  
initial
  begin  : STIMULUS
	wait (!Reset_tb);    // wait until reset is over
	@(posedge Clk_tb);    // wait for a clock

	
// test #1 begin -- test newGrade
	in0 = 10;
	in1 = 15;
	#(4 * CLK_PERIOD + 2);
  func_test;
// test #1 end
	
#(2*CLK_PERIOD);


// test #2 begin -- test newGrade
	in0 = 10;
	in1 = 15;
	#(4 * CLK_PERIOD + 2);
  func_test;
// test #2 end


#(10*CLK_PERIOD);

// test #3 begin -- test newGrade
	in0 = 112;
	in1 = 150;
	#(4 * CLK_PERIOD + 2);
  func_test;
// test #3 end

// test #4 begin -- test newGrade
	in0 = 2;
	in1 = 0;
	#(4 * CLK_PERIOD + 2);
  func_test;
// test #4 end



 // $stop; // ends simulation and enters interactive mode
  end // STIMULUS  
endmodule  // make_A_close_to_B_tb
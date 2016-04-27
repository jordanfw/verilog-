// EE454 Lab7 ALU Design
// sample_func.v
// Written by Jordan Woods
// March 18, 2016
`timescale 1 ns / 1 ps

module sample_func_tb ;

//UUT Params
reg  Clk_tb,Reset_tb;
reg  [7:0] grade0In_tb,grade1In_tb,grade2In_tb,intel0In_tb,intel1In_tb,diff0In_tb,diff1In_tb; //surrounding variable vals.
wire [7:0] grade0_tb,grade1_tb,grade2_tb,intel0_tb,intel1_tb,diff0_tb,diff1_tb; // propagated outward beliefs

//test changes.
reg [7:0] g0,g1,g2,i0,i1,d0,d1;
reg [1:0] new_change;
reg [7:0] new0, new1,new2; 
parameter CLK_PERIOD = 20;

sample_func UUT (Clk_tb,Reset_tb,grade0In_tb,grade1In_tb,grade2In_tb,intel0In_tb,intel1In_tb,diff0In_tb,diff1In_tb,
                 grade0_tb,grade1_tb,grade2_tb,intel0_tb,intel1_tb,diff0_tb,diff1_tb);

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

    Reset_tb = 1;
		grade0In_tb = g0;
		grade1In_tb = g1;
		grade2In_tb = g2;
		intel0In_tb = i0;
		intel1In_tb = i1;
		diff0In_tb  = d0;
		diff1In_tb  = d1;
    #(3 * CLK_PERIOD) Reset_tb = 0;
		

		if (new_change == 1)
		 begin
		  	grade0In_tb = new0;
			  grade1In_tb = new1;
			  grade2In_tb = new2;
		end
		if (new_change == 2)
		 begin
		  	intel0In_tb = new0;
			  intel1In_tb = new1;
		end		
	  if (new_change == 3)
		 begin
		  	diff0In_tb = new0;
			  diff1In_tb = new1;
		end		
		
		#(3 * CLK_PERIOD);
		end
  endtask
  
initial
  begin  : STIMULUS
	wait (!Reset_tb);    // wait until reset is over
	@(posedge Clk_tb);    // wait for a clock

	
// test #1 begin -- test newGrade
	g0 = 1;
	g1 = 1;
	g2 = 1;
	i0 = 1;
	i1 = 1;
	d0 = 1;
	d1 = 1;
	new_change = 1;
	new0 = 1;
	new1 = 0;
	new2 = 0;
	#(4 * CLK_PERIOD + 2);
  func_test;
// test #1 end

#(10*CLK_PERIOD);


// test #2 begin -- test newGrade
	g0 = 1;
	g1 = 1;
	g2 = 1;
	i0 = 1;
	i1 = 1;
	d0 = 1;
	d1 = 1;
	new_change = 2;
	new0 = 2;
	new1 = 4;
	new2 = 0;
	#(2 * CLK_PERIOD + 2);
  func_test;
// test #2 end


#(10*CLK_PERIOD);

// test #3 begin -- test newGrade
	g0 = 1;
	g1 = 1;
	g2 = 1;
	i0 = 1;
	i1 = 1;
	d0 = 1;
	d1 = 1;
	new_change = 3;
	new0 = 5;
	new1 = 2;
	new2 = 0;
	#(2 * CLK_PERIOD + 2);
  func_test;
// test #3 end

 // $stop; // ends simulation and enters interactive mode
  end // STIMULUS  
endmodule  // make_A_close_to_B_tb
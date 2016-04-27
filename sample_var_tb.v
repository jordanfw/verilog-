// EE454 Lab7 ALU Design
// sample_func.v
// Written by Jordan Woods
// March 18, 2016
`timescale 1 ns / 1 ps

module sample_var_tb ;

//UUT Params
reg  Clk_tb,Reset_tb,Stop_tb;
reg  [7:0] unary0_tb,unary1_tb;
reg  [7:0] fun0_0In_tb,fun0_1In_tb,fun1_0In_tb,fun1_1In_tb,fun2_0In_tb,fun2_1In_tb,fun3_0In_tb,fun3_1In_tb; //surrounding variable vals.
wire [7:0] var0_tb,var1_tb; // propagated outward beliefs
wire [7:0] var00_tb,var01_tb, var10_tb,var11_tb, var20_tb,var21_tb, var30_tb,var31_tb;  // propagated outward beliefs

//test changes.
reg [7:0] un0,un1,fun00,fun01,fun10,fun11,fun20,fun21,fun30,fun31;
reg [1:0] new_change;
reg [7:0] new0, new1; 
parameter CLK_PERIOD = 20;

sample_var UUT (Clk_tb,Reset_tb,Stop_tb, unary0_tb,unary1_tb,
									fun0_0In_tb,fun0_1In_tb,fun1_0In_tb,fun1_1In_tb,fun2_0In_tb,fun2_1In_tb,fun3_0In_tb,fun3_1In_tb,
									var00_tb,var01_tb, var10_tb,var11_tb, var20_tb,var21_tb, var30_tb,var31_tb,
									var0_tb,var1_tb);

initial
  begin  : CLK_GENERATOR
    Clk_tb = 0;
    forever
       begin
	      #(CLK_PERIOD/2) Clk_tb = ~Clk_tb;
       end 
  end

initial
	begin : rst
		    Reset_tb = 1;

    #(2 * CLK_PERIOD) Reset_tb = 0;
	end
	

task func_test;
    begin
		if (new_change == 0)
		 begin
			fun0_0In_tb = new0;
			fun0_1In_tb = new1;
		end
		if (new_change == 1)
		 begin
			fun1_0In_tb = new0;
			fun1_1In_tb = new1;
		end
		if (new_change == 2)
		 begin
		  fun2_0In_tb = new0;
			fun2_1In_tb = new1;
		end		
	  if (new_change == 3)
		 begin
		  fun3_0In_tb = new0;
			fun3_1In_tb = new1;
		end		
		
		#(CLK_PERIOD+1);
		end
  endtask
  
initial
  begin  : STIMULUS
	wait (!Reset_tb);    // wait until reset is over
	@(posedge Clk_tb);    // wait for a clock

	
// test #1 begin -- test newGrade
		Stop_tb = 0;
		un0 = 1;
		un1 = 1;
		fun00 = 1;
		fun01 = 1;
		fun10 = 2;
		fun11 = 2;
		fun20 = 10;
		fun21 = 13;
		fun30 = 3;
		fun31 = 4;
	#(4 * CLK_PERIOD + 2);
			unary0_tb = un0;
		unary1_tb = un1;
		fun0_0In_tb = fun00;
		fun0_1In_tb = fun01;
		fun1_0In_tb = fun10;
		fun1_1In_tb = fun11;
		fun2_0In_tb = fun20;
		fun2_1In_tb = fun21;
		fun3_0In_tb = fun30;
		fun3_1In_tb = fun31;
		new_change = 1;
		new0 = 2;
		new1 = 1; 
		func_test;
		new_change = 2;
		new0 = 2;
		new1 = 1; 
		func_test;
		new_change = 3;
		new0 = 2;
		new1 = 1; 
		func_test;
		
/* test #1 end
	
#(10*CLK_PERIOD);


// test #2 begin -- test newGrade
		un0 = 1;
		un1 = 1;
		fun00 = 1;
		fun01 = 1;
		fun10 = 2;
		fun11 = 2;
		fun20 = 10;
		fun21 = 13;
		fun30 = 3;
		fun31 = 4;
		new_change = 1;
		new0 = 15;
		new1 = 3; 
	#(2 * CLK_PERIOD + 2);
  func_test;
// test #2 end


#(10*CLK_PERIOD);

// test #3 begin -- test newGrade
		un0 = 12;
		un1 = 8;
		fun00 = 1;
		fun01 = 1;
		fun10 = 2;
		fun11 = 2;
		fun20 = 10;
		fun21 = 13;
		fun30 = 3;
		fun31 = 4;
		new_change = 2;
		new0 = 20;
		new1 = 1; 
	#(2 * CLK_PERIOD + 2);
  func_test;
// test #3 end

// test #4 begin -- test newGrade
		un0 = 4;
		un1 = 10;
		fun00 = 1;
		fun01 = 1;
		fun10 = 2;
		fun11 = 2;
		fun20 = 10;
		fun21 = 13;
		fun30 = 3;
		fun31 = 4;
		new_change = 3;
		new0 = 0;
		new1 = 5; 
	#(2 * CLK_PERIOD + 2);
  func_test;
// test #4 end */



 // $stop; // ends simulation and enters interactive mode
  end // STIMULUS  
endmodule  // make_A_close_to_B_tb
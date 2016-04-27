`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USC EE 454 - Intro to SoC
// Engineer: Jordan Woods, Himanshu Joshi, John Ellis
// 
// Create Date: 04/02/2016 03:42:26 PM
// Design Name: Initial Loop Trial
// Module Name: loopy_bp_1
// Project Name: sample variable
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments: THIS IS A non-loopy implementation
//////////////////////////////////////////////////////////////////////////////////


module (
    input  CLK100MHZ,
    input  Reset,
		input  [2:0] modified,  //unary inputs
    input  [7:0] moded0_In,moded1_In,  //surrounding function "beliefs".
		output [2:0] varOut,
    output [7:0] var0,var1 // propagated outward beliefs
    );
		
		reg  [7:0] moded0_In_reg,moded1_In_reg;  //surrounding function "beliefs".
		reg [2:0] varOut_reg;
    reg [7:0] var0_reg,var1_reg;
		
		//Difficulty declarations
		reg [7:0] unaryDiff0_reg, unary_Diff1_reg;
		wire [7:0] unaryDiff0, unaryDiff1, diff_in0, diff_in1, diff0, diff1;
		assign unaryDiff0 = unaryDiff0_reg;
		assign unaryDiff1 = unaryDiff1_reg;
		
		//grade declarations
		reg [7:0] unaryGr0_reg, unaryGr1_reg, unaryGr2_reg;
		wire [7:0] unaryGr0,unaryGr1,unaryGr2,Gr_in0, Gr_in1, Gr_in2,Gr1_in0,Gr1_in1,Gr1_in2,Gr0,Gr1,Gr2;
		assign unaryGr0 = unaryGr0_reg;
		assign unaryGr1 = unaryGr1_reg;
		assign unaryGr2 = unaryGr2_reg;
		
		//Intelligence Declarations
		reg [7:0] unaryIntel0_reg, unary_Intel1_reg;
		wire [7:0] unaryIntel0, unaryIntel1, Intel_in0, Intel_in1,Intel1_in0, Intel1_in1, Intel0, Intel1;
		assign unaryIntel0 = unaryIntel0_reg;
		assign unaryIntel1 = unaryIntel1_reg;
		
		always @ (posedge CLK100MHZ) 
    begin
			if (Reset) //on reset
        begin
					modified_reg <= modified;
					moded0_In_reg <= moded0_In;
					moded1_In_reg <= moded1_In;
					unaryDiff0_reg <= 6;
					unaryDiff1_reg <= 4;
					unaryGr0_reg <= 1;
					unaryGr1_reg <= 1;
					unaryGr2_reg <= 1;
					unaryIntel0_reg <= 1;
					unaryIntel1_reg <= 1;
				end
			else
				begin
					if (modified != 0)
					begin
						
					end
				end
	  end
		
		/********************
			Variables
		********************/
		diff_var sample_var0(.CLK100MHZ(CLK100MHZ),.Reset(Reset),.unary0(unaryDiff0), unary1(unaryDiff1),
												.fun0_0In(diff_in0),.fun0_1In(diff_in1),.var0(diff0),.var1(diff1));
												
		Grade_var sample_var1(.CLK100MHZ(CLK100MHZ),.Reset(Reset),.unary0(unaryGr0),.unary1(unaryGr1),.unary2(unaryGr2),
				//to fix									.fun0_0In(Gr_in0),.fun0_1In(Gr_in1),.fun0_2In(Gr_in2),.fun1_0In(Gr1_in0),.fun1_1In(Gr1_in1),.fun1_2In(Gr1_in2),
													.var0(Gr0),.var1(Gr1),.var2(Gr2));
											 unaryIntel0, unaryIntel1, Intel_in0, Intel_in1, Intel0, Intel1;		
		Intel_var sample_var2(.CLK100MHZ(CLK100MHZ),.Reset(Reset),.unary0(unaryIntel0), .unary1(unaryIntel1),
													.fun0_0In(Intel_in0),.fun0_1In(Intel_in1),.fun1_0In(intel1_in0),fun1_1In(intel1_in1),
													.var0(Intel0),.var1(Intel1));

		sat_var sample_var0(.CLK100MHZ(CLK100MHZ),.Reset(Reset),.unary0(unaryDiff0), unary1(unaryDiff1),
												.fun0_0In(diff_in0),.fun0_1In(diff_in1),.var0(diff0),.var1(diff1));											
		/********************
			Diff-Grade-Intel
	  ********************/ 
		mult_func sample_func(.CLK100MHZ(CLK100MHZ),.Reset(Reset),.grade0In(),.grade1In(),.grade2In(),.intel0In(),.intel1In(),.diff0In(diff0),.diff1In(diff1),
							grade0,grade1,grade2,intel0,intel1,.diff0(diff_in0),.diff1(diff_in1));
		
	endmodule
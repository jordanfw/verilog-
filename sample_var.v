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
// Additional Comments: THIS IS A "MIDDLE VARIABLE". 
//  										I.E. IT HAS 4 NEIGHBORING FUNCS	& 1 UNARY FUNCTION
// 											NOTE: it is a variable of size "2"
//////////////////////////////////////////////////////////////////////////////////


module sample_var(
    input  CLK100MHZ, 	// remove for async
    input  Reset, Stop,			  // this is currently not the global reset, it kicks off the BP calculations
		input  [7:0] unary0, unary1, // unary inputs
    input  [7:0] fun0_0In,fun0_1In, fun1_0In,fun1_1In, fun2_0In,fun2_1In, fun3_0In,fun3_1In, //surrounding function "beliefs".
    output [7:0] var00,var01, var10,var11, var20,var21, var30,var31,  // propagated outward beliefs
		output [7:0] var0, var1 // final beliefs
    );
    // initializations
		// currently, everything is sized to be an 8-bit char.
    reg [7:0] fun0_0In_reg,fun0_1In_reg, 	fun1_0In_reg,fun1_1In_reg, 	fun2_0In_reg,fun2_1In_reg, 	fun3_0In_reg,fun3_1In_reg; 	//surrounding function vals. input savings
    reg [7:0] var00_reg,var01_reg, 				var10_reg,var11_reg, 				var20_reg,var21_reg, 				var30_reg,var31_reg;				//values to be propagated
    assign var00 = var00_reg;
    assign var01 = var01_reg;
    assign var10 = var10_reg;
    assign var11 = var11_reg;
    assign var20 = var20_reg;
    assign var21 = var21_reg;
		// Internal values
		reg [7:0] var0_reg, var1_reg;
    assign var0 = var0_reg;
		assign var1 = var1_reg;
    // Using Asynchronous reset
    
    // flags used for ::some reason
    reg flag; // initializing flag
    reg [2:0] changes0, changes1, changes2, changes3; //poll for changes until ready to pass messages
		//always block
    always @ (posedge CLK100MHZ, posedge Reset) //change to * for async 
    begin
			if (Reset) //on reset
        begin
					changes0  <= 0; 
					changes1  <= 0;
					changes2  <= 0;
					changes3  <= 0;
					flag 			<= 1;
					var00_reg <= unary0;
					var01_reg <= unary1;
					var10_reg <= unary0;
					var11_reg <= unary1;
					var20_reg <= unary0;
					var21_reg <= unary1;
					var30_reg <= unary0;
					var31_reg <= unary1;
					fun0_0In_reg <= fun0_0In;
					fun0_1In_reg <= fun0_1In;
					fun1_0In_reg <= fun1_0In;
					fun1_1In_reg <= fun1_1In;
					fun2_0In_reg <= fun2_0In;
					fun2_1In_reg <= fun2_1In;
					fun3_0In_reg <= fun3_0In;
					fun3_1In_reg <= fun3_1In;
					var0_reg <= 1;
					var1_reg <= 1;
				end
      else if (Stop)
				begin 
					flag <= 0;
				end
			else if (flag == 1)//wait one clock for functions to initialize correctly
			  if ((fun0_0In_reg != fun0_0In) || (fun0_1In_reg != fun0_1In)) //0 item changed
					begin
					fun0_0In_reg <= fun0_0In;
					fun0_1In_reg <= fun0_1In;
					changes1[0] <= 1'b1;
					changes2[0] <= 1'b1;
					changes3[0] <= 1'b1;
					end
			  if ((fun1_0In_reg != fun1_0In) || (fun1_1In_reg != fun1_1In)) //1 item changed
					begin
					fun1_0In_reg <= fun1_0In;
					fun1_1In_reg <= fun1_1In;
					changes0[0] <= 1'b1;
					changes2[1] <= 1'b1;
					changes3[1] <= 1'b1;
					end
				if ((fun2_0In_reg != fun2_0In) || (fun2_1In_reg != fun2_1In)) //2 item changed
					begin
					fun2_0In_reg <= fun2_0In;
					fun2_1In_reg <= fun2_1In;
					changes0[1] <= 1'b1;
					changes1[1] <= 1'b1;
					changes3[2] <= 1'b1;
					end
				if ((fun3_0In_reg != fun3_0In) || (fun3_1In_reg != fun3_1In)) //3 item changed
					begin
					fun3_0In_reg <= fun3_0In;
					fun3_1In_reg <= fun3_1In;
					changes0[2] <= 1'b1;
					changes1[2] <= 1'b1;
					changes2[2] <= 1'b1;
					end
			  if (changes0 == 3'b111) //propagate toward the 0 item
					begin
					var00_reg <= (fun1_0In*fun2_0In*fun3_0In*unary0) / 8; //to limit the explosion of data
					var01_reg <= (fun1_1In*fun2_1In*fun3_1In*unary1) / 8; //to limit the explosion of data
					var0_reg <= (fun0_0In*fun1_0In*fun2_0In*fun3_0In*unary0) / 8;
					var1_reg <= (fun0_1In*fun1_1In*fun2_1In*fun3_1In*unary1) / 8;
					changes0 <= 3'b000;
				  end
				if (changes1 == 3'b111) //propagate toward the 1 item
				  begin
					var10_reg <= (fun0_0In*fun2_0In*fun3_0In*unary0) / 8; //to limit the explosion of data
					var11_reg <= (fun0_1In*fun2_1In*fun3_1In*unary1) / 8; //to limit the explosion of data
					var0_reg <= (fun0_0In*fun1_0In*fun2_0In*fun3_0In*unary0) / 8;
					var1_reg <= (fun0_1In*fun1_1In*fun2_1In*fun3_1In*unary1) / 8;
					changes1 <= 3'b000;
					end
				if (changes2 == 3'b111) //propagate toward the 2 item
				  begin
					var20_reg <= (fun1_0In*fun0_0In*fun3_0In*unary0) / 8; //to limit the explosion of data
					var21_reg <= (fun1_1In*fun0_1In*fun3_1In*unary1) / 8; //to limit the explosion of data
					var0_reg <= (fun0_0In*fun1_0In*fun2_0In*fun3_0In*unary0) / 8;
					var1_reg <= (fun0_1In*fun1_1In*fun2_1In*fun3_1In*unary1) / 8;
					changes2 <= 3'b000;
					end
				if (changes3 == 3'b111) //propagate toward the 3 item
					begin
					var30_reg <= (fun1_0In*fun2_0In*fun3_0In*unary0) / 8; //to limit the explosion of data
					var31_reg <= (fun1_1In*fun2_1In*fun3_1In*unary1) / 8; //to limit the explosion of data
					var0_reg <= (fun0_0In*fun1_0In*fun2_0In*fun3_0In*unary0) / 8;
					var1_reg <= (fun0_1In*fun1_1In*fun2_1In*fun3_1In*unary1) / 8;
					changes3 <= 3'b000;
					end
    end  
		
		
endmodule
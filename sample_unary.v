`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////
// Company: USC EE 454 - Intro to SoC
// Engineer: Jordan Woods, Himanshu Joshi, John Ellis
// 
// Create Date: 04/02/2016 03:42:26 PM
// Design Name: function
// Module Name: sample_unary
// Project Name: Sample Unary Function
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: This could possibly be input directly into variable functions.    
//											Just a sample that we can discuss later.
// 
//////////////////////////////////////////////////////////////////////////////////////


module sample_unary(
    input CLK100MHZ,
    input Reset,
		input [7:0] init0, init1, //Initializers
    output [7:0] unary0,unary1 // propagated outward beliefs on reset
    );
		
    //initializations
		//possibly change to integers?
    reg [7:0] unary0_reg,unary1_reg;
    assign unary0 = unary0_reg;
    assign unary1 = unary1_reg;

    //main matrix for f1;
    
		//always block
    always @ (posedge CLK100MHZ) 
     begin
			if (Reset) 
        begin
					unary0_reg <= init0;
					unary1_reg <= init1;
				end
     end  
		
		
endmodule
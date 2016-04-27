`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: USC EE 454 - Intro to SoC
// Engineer: Jordan Woods, Himanshu Joshi, John Ellis
// 
// Create Date: 04/02/2016 03:42:26 PM
// Design Name: function
// Module Name: sample_func
// Project Name: 
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sample_func(
    input CLK100MHZ,
    input Reset,
    input [7:0] grade0In,grade1In,grade2In,intel0In,intel1In,diff0In,diff1In, //surrounding variable vals.
    output [7:0] grade0,grade1,grade2,intel0,intel1,diff0,diff1 // propagated outward beliefs
    );
    //initializations
    integer grade0In_reg,grade1In_reg,grade2In_reg,intel0In_reg,intel1In_reg,diff0In_reg,diff1In_reg; //surrounding variable vals.
    
    reg [7:0] grade0Out,grade1Out,grade2Out,intel0Out,intel1Out,diff0Out,diff1Out;
    assign grade0 = grade0Out;
    assign grade1 = grade1Out;
    assign grade2 = grade2Out;
    assign intel0 = intel0Out;
    assign intel1 = intel1Out;
    assign diff0  = diff0Out;
    assign diff1  = diff1Out;

    //using Asynchronous reset
    //reg reset;
    //always @ (posedge CLK100MHZ) 
    //    reset <= Reset;
    
    //main matrix for f1;
     integer f1[0:2][0:1][0:1]; //systems belief matrix. f1_sys[grade][intel][diff];
    reg [1:0] flag; // initializing flag
    
		//always block
    always @ (posedge CLK100MHZ) 
    begin
			if (Reset) 
        begin
					grade0In_reg <= grade0In;
					grade1In_reg <= grade1In;
					grade2In_reg <= grade2In;
					intel0In_reg <= intel0In;
					intel1In_reg <= intel1In;
					diff0In_reg  <= diff0In;
					diff1In_reg  <= diff1In;
					f1[0][0][0] <= 30;
					f1[1][0][0] <= 40;
					f1[2][0][0] <= 30;
					f1[0][0][1] <= 5;
					f1[1][0][1] <= 25;
					f1[2][0][1] <= 7;
					f1[0][1][0] <= 90;
					f1[1][1][0] <= 8;
					f1[2][1][0] <= 2;
					f1[0][1][1] <= 50;
					f1[1][1][1] <= 30;
					f1[2][1][1] <= 20;
					grade0Out <= grade0In;
					grade1Out <= grade1In;
					grade2Out <= grade2In;
					intel0Out <= intel0In;
					intel1Out <= intel1In;
					diff0Out  <= diff0In;
					diff1Out  <= diff1In;
					flag <= 0 ;
				end
      else if ((grade0In_reg != grade0In) || (grade1In_reg != grade1In) || (grade2In_reg != grade2In)) //change in grade
        begin //propagates a new belief on intel/diff
					flag <=1;
					intel0Out <= (diff0In*(f1[0][0][0]*grade0In + f1[1][0][0]*grade1In + f1[2][0][0]*grade2In) + diff1In*(f1[0][0][1]*grade0In + f1[1][0][1]*grade1In + f1[2][0][1]*grade2In)) / 16;
					intel1Out <= (diff0In*(f1[0][1][0]*grade0In + f1[1][1][0]*grade1In + f1[2][1][0]*grade2In) + diff1In*(f1[0][1][1]*grade0In + f1[1][1][1]*grade1In + f1[2][1][1]*grade2In)) / 16;
					diff0Out <= (intel0In*(f1[0][0][0]*grade0In + f1[1][0][0]*grade1In + f1[2][0][0]*grade2In) + intel1In*(f1[0][1][0]*grade0In + f1[1][1][0]*grade1In + f1[2][1][0]*grade2In)) / 16;
					diff1Out <= (intel0In*(f1[0][0][1]*grade0In + f1[1][0][1]*grade1In + f1[2][0][1]*grade2In) + intel1In*(f1[0][1][1]*grade0In + f1[1][1][1]*grade1In + f1[2][1][1]*grade2In)) / 16;
					
					//update to avoid self propagation
					grade0In_reg <= grade0In;
					grade1In_reg <= grade1In;
					grade2In_reg <= grade2In;
        end
		  else if ((intel0In_reg != intel0In) || (intel1In_reg != intel1In)) // change in intel
        begin // propagates a new belief on grade/diff
					flag <= 2;
					grade0Out <= (diff0In*(f1[0][0][0]*intel0In + f1[0][1][0]*intel1In) + diff1In*(f1[0][0][1]*intel0In + f1[0][1][1]*intel1In)) / 16;
					grade1Out <= (diff0In*(f1[1][0][0]*intel0In + f1[1][1][0]*intel1In) + diff1In*(f1[1][0][1]*intel0In + f1[1][1][1]*intel1In)) / 16;
					grade2Out <= (diff0In*(f1[2][0][0]*intel0In + f1[2][1][0]*intel1In) + diff1In*(f1[2][0][1]*intel0In + f1[2][1][1]*intel1In)) / 16;
					
		      diff0Out <= (intel0In*(f1[0][0][0]*grade0In + f1[1][0][0]*grade1In + f1[2][0][0]*grade2In) + intel1In*(f1[0][1][0]*grade0In + f1[1][1][0]*grade1In + f1[2][1][0]*grade2In)) / 16;
					diff1Out <= (intel0In*(f1[0][0][1]*grade0In + f1[1][0][1]*grade1In + f1[2][0][1]*grade2In) + intel1In*(f1[0][1][1]*grade0In + f1[1][1][1]*grade1In + f1[2][1][1]*grade2In)) / 16;
					//update to avoid self propagation
					intel0In_reg <= intel0In;
					intel1In_reg <= intel1In;
        end
      else if ((diff0In_reg != diff0In) || (intel0In_reg != intel0In)) 
        begin // propagates a new belief on grade/intel
					flag <= 3;
					grade0Out <= (diff0In*(f1[0][0][0]*intel0In + f1[0][1][0]*intel1In) + diff1In*(f1[0][0][1]*intel0In + f1[0][1][1]*intel1In)) / 16;
					grade1Out <= (diff0In*(f1[1][0][0]*intel0In + f1[1][1][0]*intel1In) + diff1In*(f1[1][0][1]*intel0In + f1[1][1][1]*intel1In)) / 16;
					grade2Out <= (diff0In*(f1[2][0][0]*intel0In + f1[2][1][0]*intel1In) + diff1In*(f1[2][0][1]*intel0In + f1[2][1][1]*intel1In)) / 16;
					
		      intel0Out <= (diff0In*(f1[0][0][0]*grade0In + f1[1][0][0]*grade1In + f1[2][0][0]*grade2In) + diff1In*(f1[0][0][1]*grade0In + f1[1][0][1]*grade1In + f1[2][0][1]*grade2In)) / 16;
					intel1Out <= (diff0In*(f1[0][1][0]*grade0In + f1[1][1][0]*grade1In + f1[2][1][0]*grade2In) + diff1In*(f1[0][1][1]*grade0In + f1[1][1][1]*grade1In + f1[2][1][1]*grade2In)) / 16;
					
					//update to avoid self propagation
					diff0In_reg  <= diff0In;
					diff1In_reg  <= diff1In;
        end
    end  
		
		
endmodule
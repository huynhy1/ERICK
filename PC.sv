// Design Name:    basic_proc
// Module Name:    IF 
// Project Name:   CSE141L
// Description:    instruction fetch (pgm ctr) for processor
//
// Revision:  2019.01.27
//
module PC #(parameter W=16)( // W = PC Width
	input Branch_abs,		   	// jump to Target value
	input B_TAKEN,
//	input [W-1:0] Target,		// jump ... "how high?"
	input Init,				  	// reset, start, etc. 
	input CLK,				  	// PC can change on pos. edges only
	output logic Halt,				  	// 1: freeze PC; 0: run PC
	output logic[W-1:0] PC		// program counter
	);
	 
  always_ff @(posedge CLK)	  // or just always; always_ff is a linting construct
	if(Init)
	  PC <= 0;				  // for first program; want different value for 2nd or 3rd
	else if(PC == 143)
	  Halt <= 1;
	else if(Branch_abs && B_TAKEN)	      // conditional absolute jump
	  PC <= 4;
	else
	  PC <= PC+1;		      // default increment (no need for ARM/MIPS +4 -- why?)

endmodule
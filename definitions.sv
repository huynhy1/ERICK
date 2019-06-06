//This file defines the parameters used in the alu
// CSE141L
package definitions;
	
// Instruction map
	const logic [3:0]kRXOR      = 4'b0000;
	const logic [3:0]kXOR       = 4'b0001;
	const logic [3:0]kMOVE      = 4'b0010;
	const logic [3:0]kMOVEACC   = 4'b0011;
	const logic [3:0]kSLT       = 4'b0100;
	const logic [3:0]kLB      	= 4'b0101;
	const logic [3:0]kSB       	= 4'b0110;
	const logic [3:0]kFLIP      = 4'b0111;
	const logic [3:0]kADD  		= 4'b1000;
	const logic [3:0]kSUB       = 4'b1001;
	const logic [3:0]kSLL       = 4'b1010;
	const logic [3:0]kSR        = 4'b1011;
	const logic [3:0]kMOVEI     = 4'b1100;
	const logic [3:0]kBEQ       = 4'b1101;
	const logic [3:0]kBNE       = 4'b1110;
// enum names will appear in timing diagram
	typedef enum logic[3:0] {
		RXOR, XOR, MOVE, MOVEACC, SLT, LB, SB, FLIPI, 
		ADD, SUB, SLL, SR, MOVEI, BEQ, BNE } op_mne;
// note: kADD is of type logic[2:0] (3-bit binary)
//   ADD is of type enum -- equiv., but watch casting
//   see ALU.sv for how to handle this   
endpackage // definitions

// Create Date:    2016.10.15
// Module Name:    ALU 
// Project Name:   CSE141L
//
// Revision 2018.01.27
// Additional Comments: 
//   combinational (unclocked) ALU
import definitions::*;			  // includes package "definitions"
module ALU(
	input [7:0] INPUTA,      	  // data inputs
				INPUTB,
	input [3:0] OP,				  // ALU opcode, part of microcode
	input        B_K,             // shift in/carry in 
	output logic [7:0] OUT,		  // or:  output reg [7:0] OUT,
	output logic B_TAKEN              // zero out flag

	);

	op_mne op_mnemonic;			  // type enum: used for convenient waveform viewing

	always_comb begin
	OUT = 8'b00000000;
	B_TAKEN = 1'b0;
	case(OP)
	kRXOR: begin
		OUT = {7'b0000000,((INPUTA[0] ^ INPUTA[1]) ^ (INPUTA[2] ^ INPUTA[3])) ^ 
		((INPUTA[4] ^ INPUTA[5]) ^ (INPUTA[6] ^ INPUTA[7]))};
	end
	kXOR: begin
		OUT = INPUTA ^ INPUTB;
	end
	kMOVE: begin
		OUT = INPUTA;
	end
	kMOVEACC: begin
		OUT = INPUTB;
	end
	kSLT: begin
		if (INPUTB < INPUTA) OUT = 8'b00000001;
	end
	kLB: begin
	end
	kSB: begin
	end
	//kFLIP: begin
	//TODO P2
	//end
	kADD: begin
		OUT = INPUTA + INPUTB;
	end
	kSUB: begin
		OUT = INPUTA - INPUTB;
	end
	kSLL: begin
		OUT = INPUTB << INPUTA;
	end
	kSR: begin
		OUT = INPUTB >> INPUTA;
	end
	kMOVEI: begin
		OUT = INPUTA;
	end
	kBEQ: begin
		OUT = INPUTB;
		if (INPUTB == {7'b0000000,B_K}) B_TAKEN = 1'b1;
	end
	kBNE: begin
		OUT = INPUTB;
		if (INPUTB != {7'b0000000,B_K}) B_TAKEN = 1'b1;
	end
	endcase

//$display("ALU Out %d \n",OUT);
		op_mnemonic = op_mne'(OP);					  // displays operation name in waveform viewer
end
endmodule
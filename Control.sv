import definitions::*;
module Control(
  input [3:0] Instr_i,
  output logic   Branch,
	         MemRead,
	         MemWrite,
	         ALUSrc,
	         MoveAcc,		// Only on moveacc inst
  output logic[2:0] ALUOp
);

always_comb begin
Branch    	= 1'b0;
MemRead   	= 1'b0;
MemWrite  	= 1'b0;
MoveAcc    	= 1'b0;
ALUSrc		= 1'b0;
ALUOp     	= 3'b000;
casez(Instr_i)
	kRXOR: begin
	end
	kXOR: begin
	end
	kMOVE: begin
	end
	kMOVEACC: begin
		MoveAcc = 1'b1;
	end
	kSLT: begin
	end
	kLB: begin
		MemRead = 1'b1;
	end
	kSB: begin
		MemWrite = 1'b1;

	end
	kFLIP: begin
		
	end
	kADD: begin
	end
	kSUB: begin
	end
	kSLL: begin
		ALUSrc = 1'b1;
	end
	kSR: begin
		ALUSrc = 1'b1;
	end
	kMOVEI: begin
		ALUSrc = 1'b1;
	end
	kBEQ: begin
		Branch = 1'b1;
	end
	kBNE: begin
		Branch = 1'b1;
	end
endcase



end


endmodule
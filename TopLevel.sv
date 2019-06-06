// Create Date:    2018.04.05
// Design Name:    BasicProcessor
// Module Name:    TopLevel 
// CSE141L
// partial only										   
module TopLevel(			// you will have the same 3 ports
	input     start,		// init/reset, active high
	input     CLK,			// clock -- posedge used inside design
	output    halt			// done flag from DUT
	);

wire [ 15:0] PC;            // program count
wire [ 8:0] Instruction;   	// our 9-bit opcode

wire [ 7:0] ReadReg;  		// reg_file outputs
wire	MemRead,
        MemWrite,
        ALUSrc,
        MoveAcc;
wire [2:0] ALUOp;

wire [ 7:0] InA, InB, 	   // ALU operand inputs
			ALU_Out;       // ALU result
wire B_TAKEN;
wire [ 7:0] regWriteValue, // data in to reg file
			memWriteValue, // data in to data_memory
			Mem_Out;	   // data out from data_memory
wire 		
			branch_en;	   // to program counter: branch enable
logic[15:0] cycle_ct;	   // standalone; NOT PC!s

// Fetch = Program Counter + Instruction ROM
// Program Counter
PC PC1 (
	.Branch_abs(branch_en),				// jump to Target value
	.B_TAKEN,	 
//	TODO,				// jump ... "how high?"
	.Init(start),				// reset, start, etc. 
	.CLK,				  // PC can change on pos. edges only
	.Halt(halt),				// 1: freeze PC; 0: run PC
	.PC	
	);					  

// Control decoder
Control Ctrl1 (
	.Instr_i (Instruction[8:5]),    // from instr_ROM
	.Branch(branch_en),
	.MemRead,
	.MemWrite,
	.ALUSrc,
	.MoveAcc,
	.ALUOp
	);
// instruction ROM
InstROM instr_ROM1(
	.InstAddress   (PC), 
	.InstOut       (Instruction)
	);

assign RegWriteValue = MemRead ? Mem_Out :    // LD
						ALU_Out; // ALU operation
// reg file
reg_file #(.W(8),.D(4)) reg_file1 (
	.CLK   ,
	.write_en  (MoveAcc)    , 
	.addr 		(Instruction[4:1]),
	.data_in   (ALU_Out) ,
	.data_out  (ReadReg),
	.acc_out  	(Acc_Out)
		);
// one pointer, two adjacent read accesses: (optional approach)
//	.raddrA ({Instruction[5:3],1'b0});
//	.raddrB ({Instruction[5:3],1'b1});

	assign InA = ALUSrc ? Instruction[4:0] : ReadReg;						          // connect RF out to ALU in
	assign InB = Acc_Out;
ALU ALU1  (
.INPUTA  (InA),
.INPUTB  (InB), 
.OP      (Instruction[8:5]),
.B_K 	(Instruction[0]),
.OUT     (ALU_Out),//regWriteValue),
.B_TAKEN
);

assign data_address = ReadReg;
data_mem data_mem1(
	.CLK 		  		     ,
	.reset		  (start),
	.DataAddress  (data_address)    , 
	.ReadMem      (MemRead),          //(MEM_READ) ,   always enabled 
	.WriteMem     (MemWrite), 
	.DataIn       (ALU_Out), 
	.DataOut      (Mem_Out)
);
	
// count number of instructions executed
always_ff @(posedge CLK)
  if (start == 1)	   // if(start)
	cycle_ct <= 0;
  else if(halt == 0)   // if(!halt)
	cycle_ct <= cycle_ct+16'b1;

// always_ff @(posedge CLK)    // carry/shift in/out register
//   if(sc_clr)				// tie sc_clr low if this function not needed
// 	SC_IN <= 0;             // clear/reset the carry (optional)
//   else if(sc_en)			// tie sc_en high if carry always updates on every clock cycle (no holdovers)
// 	SC_IN <= SC_OUT;        // update the carry  

endmodule

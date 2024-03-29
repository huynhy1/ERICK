// Create Date:   2017.01.25
// Design Name:   TopLevel Test Bench
// Module Name:   TopLevel_tb.v
//  CSE141L
// This is NOT synthesizable; use for logic simulation only
// Verilog Test Fixture created for module: TopLevel

module TopLevel_tb;	     // Lab 17

// To DUT Inputs
bit start;
bit CLK;

// From DUT Outputs
  wire halt;		   // done flag

// Instantiate the Device Under Test (DUT)
TopLevel DUT (
	.start           , 
	.CLK             , 
	.halt             
	);

initial begin
  start = 1;
// Initialize DUT's data memory
#10ns for(int i=0; i<256; i++) begin
    DUT.data_mem1.core[i] = 8'h00;	     // clear data_mem
  end
    DUT.data_mem1.core[1] = 8'b00000111;
    DUT.data_mem1.core[0] = 8'hff;
    DUT.data_mem1.core[3] = 8'b00000000;
    DUT.data_mem1.core[2] = 8'b00000001;
    DUT.data_mem1.core[5] = 8'b00000000;
    DUT.data_mem1.core[4] = 8'b00000001;
  
// students may also pre_load desired constants into data_mem
// Initialize DUT's register file
for(int j=0; j<16; j++)
    DUT.reg_file1.registers[j] = 8'b0;    // default -- clear it
// students may pre-load desired constants into the reg_file

// launch program in DUT
#10ns start = 0;
// Wait for done flag, then display results
wait (halt);
#10ns for(int i=30; i<60; i++) begin
 $display("Mem[%d] = %b",i,DUT.data_mem1.core[i]);
  // #10ns $displayh(DUT.data_mem1.core[30],
  //                 DUT.data_mem1.core[6],"_",
  //                 DUT.data_mem1.core[7],
  //                 DUT.data_mem1.core[8]);
end
$display("instruction = %d %t",DUT.PC,$time);

#10ns $stop;			   
end

always begin   // clock period = 10 Verilog time units
  #5ns  CLK = 1;
  #5ns  CLK = 0;
end

endmodule


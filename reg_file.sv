// Create Date:    2017.01.25
// Design Name:    CSE141L
// Module Name:    reg_file 
//
// Additional Comments: 					  $clog2

module reg_file #(parameter W=8, D=4)(		 // W = data path width; D = pointer width
  input           CLK,
                  write_en,
  input  [ D-1:0] addr,
  input  [ W-1:0] data_in, 
  output logic [W-1:0] data_out,
  output logic [W-1:0] acc_out
    );

// W bits wide [W-1:0] and 2**4 registers deep 	 
logic [W-1:0] registers[2**D];	  // or just registers[16] if we know D=4 always
logic [W-1:0] acc;

// Read
always_comb data_out = registers[addr];               // can read from addr 0, just like ARM
always_comb acc_out = acc;

// sequential (clocked) writes 
always_ff @ (posedge CLK) begin
    if (write_en && addr)	 begin                            // && waddr requires nonzero pointer address
    // if (write_en) if want to be able to write to address 0, as well
        registers[addr] <= data_in;
    end
  acc <= data_in;
end

endmodule

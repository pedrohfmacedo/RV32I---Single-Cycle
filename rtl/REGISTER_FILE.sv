// RISC-V I , 32b
// PC
// Instruction Memory 
// Register File
// Data Memory
// Inputs: 
// Outputs:

module REGISTER_FILE #( 
   int DWIDTH = 32,
   int WIDTH  = 5,
   int RWIDTH = 16
  
)(	
  input logic Clk,				 // Clock
  input logic N_Rst,			 // Reset Low-Signal
  input logic WE3,			 	 // Write Enable, enables (1) or disables (0) data recording
  input logic [WIDTH-1:0] RA1,	 //	RD1 output register selection
  input logic [WIDTH-1:0] RA2,    //RD2 output register selection	
  input  logic [DWIDTH-1:0] WD3, // Write Data 
  input  logic [WIDTH-1:0] WA3,  // Enables (1) or disables (0) data recording
  output logic [DWIDTH-1:0] RD1, // Out RD1
  output logic [DWIDTH-1:0] RD2  // Out RD2
);
  // Bank Register
  logic [DWIDTH-1:0] RegBank [0:RWIDTH-1];

  // Write Operation
  always_ff @(posedge Clk or negedge N_Rst) begin
    if (!N_Rst) begin
      for (integer i = 0; i < RWIDTH; i++) begin
        RegBank[i] <= 1'b0; // Reset each register in the bank
      end
    end else begin
      if (WE3 && WA3 != 0) begin
        RegBank[WA3] <= WD3; // Write data to the specified register
      end
    end
  end

  // Read Operation
  always_comb begin
    RD1 = RegBank[RA1];
    RD2 = RegBank[RA2];
  end

endmodule


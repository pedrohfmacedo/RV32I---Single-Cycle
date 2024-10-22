// RISC-V I , 32b
// PC
// Instruction Memory 
// Register File
// Data Memory
// Inputs: 
// Outputs:

module PC_CONTROLLER #( 
   int DWIDTH = 32
)(	
  input logic [DWIDTH-1:0] PCin,				 // Clock
  input logic N_Rst,			 // Reset Low-Signal
  input logic Clk,			 // Enables (1) or disables (0) data recording
  output logic [DWIDTH-1:0] PC  // Out 
);
  // Bank Register
  always_ff@(posedge Clk or negedge N_Rst) begin
    if(!N_Rst) begin
    	PC <= 0;
    end
    else begin
      	PC <= PCin;
    end
  end
  
endmodule

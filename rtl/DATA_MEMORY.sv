// RISC-V I , 32b
// PC
// Instruction Memory 
// Register File
// Data Memory
// Inputs: 
// Outputs:

//ROM
module DATA_MEMORY #( 
   int WIDTH = 8
)(	
  input logic Clk,
  input logic n_Rst,
  input logic WE,
  input logic [WIDTH-1:0] A,
  input logic [WIDTH-1:0] WD,
  output logic [WIDTH-1:0] RD			 // Reset Low-Signal
);
  logic [7:0] memory [255:0];
  
  always_ff @(posedge Clk or negedge n_Rst) begin
    if (!n_Rst) begin
      for (integer i = 0; i < 255; i = i + 1) begin
        memory [i] <= 0;
      end
    end
    else if (WE == 1) begin
      memory[A] <= WD;
    end
  end
  
  assign RD = memory[A];

endmodule


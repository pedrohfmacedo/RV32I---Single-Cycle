// RISC-V I , 32b
// PC
// Instruction Memory 
// Register File
// Data Memory
// Inputs: 
// Outputs:

//ROM
module INSTRUCTION_MEMORY #( 
   int DWIDTH = 32,
   int WIDTH = 8
)(	
  input logic [WIDTH-1:0] A,				 // Clock
  output logic [DWIDTH-1:0] RD			 // Reset Low-Signal
);
   always_comb begin
    case(A)
	 8'h00:RD = 32'h00300093;
	 8'h04:RD = 32'h00900113;
	 8'h08:RD = 32'h00208133;
	 8'h0C:RD = 32'h0020f1b3;
	 8'd10:RD = 32'h0020e233;
	 8'd14:RD = 32'h0041a2b3;
	 8'd18:RD = 32'h40520333;
	 default:RD = 32'h00000000;
    endcase
  end
endmodule



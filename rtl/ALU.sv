// RISC-V I , 32b
// PC
// Instruction Memory 
// Register File
// Data Memory
// Inputs: 
// Outputs:

module ALU #( 
   int DWIDTH = 8
)(	
  input logic [DWIDTH-1:0] SrcA,		// Input Data A
  input logic [DWIDTH-1:0] SrcB,   		// Input Data B
  input logic [DWIDTH-5:0] ALUControl,  // Select operationm
  output logic [DWIDTH-1:0] ALUResult,  // Out result
  output logic Z			      	// Flag to indicate the output of the operation is zero
);
  //
    typedef enum logic [3:0] {
    AND, 
    OR, 
    XOR, 
    ADD, 
    SUB, 
    SLL, 
    SRL, 
    SRA,
    SLT, 
    SLTU, 
    SGE, 
    SGEU,
    SEQ,
    SNE
  } ALUOperation;
  
  //Operations
always_comb begin
    case (ALUControl)
        AND: begin 
            ALUResult = SrcA & SrcB; 
            Z = (!ALUResult) ? 1 : 0; 
        end
        OR: begin 
            ALUResult = SrcA | SrcB; 
            Z = (!ALUResult) ? 1 : 0; 
        end
        XOR: begin 
            ALUResult = SrcA ^ SrcB; 
            Z = (!ALUResult) ? 1 : 0; 
        end
        ADD: begin 
            ALUResult = SrcA + SrcB; 
            Z = (!ALUResult) ? 1 : 0; 
        end
        SUB: begin 
            ALUResult = SrcA - SrcB; 
            Z = (!ALUResult) ? 1 : 0; 
        end
        SLL: begin 
            ALUResult = SrcA << SrcB; 
            Z = (!ALUResult) ? 1 : 0; 
        end
        SRL: begin 
            ALUResult = SrcA >> SrcB; 
            Z = (!ALUResult) ? 1 : 0; 
        end
        SRA: begin 
            ALUResult = SrcA >>> SrcB;  // Shift arithmetic right 
            Z = (!ALUResult) ? 1 : 0; 
        end
        SLT: begin 
            ALUResult = (SrcA < SrcB); 
            Z = (!ALUResult) ? 1 : 0; 
        end
        SLTU: begin 
            ALUResult = (SrcA < SrcB); 
            Z = (!ALUResult) ? 1 : 0; 
        end
        SGE: begin 
            ALUResult = (SrcA >= SrcB); 
            Z = (!ALUResult) ? 1 : 0; 
        end
        SGEU: begin 
            ALUResult = (SrcA >= SrcB); 
            Z = (!ALUResult) ? 1 : 0; 
        end
        SEQ: begin 
		  ALUResult = (SrcA == SrcB) ? 8'b00000001 : 8'b00000000; // SEQ
            Z = (!ALUResult) ? 1 : 0; 
        end
        SNE: begin  
            ALUResult = (SrcA != SrcB); 
            Z = (!ALUResult) ? 1 : 0; 
        end
        default: begin
            ALUResult = 'x; 
            Z = (!ALUResult) ? 1 : 0; 
        end
    endcase
end
  
endmodule

/* 
  always_comb  begin
    case (ALUControl)
      AND:begin ALUResult = SrcA & SrcB; Z = (!ALUResult)?1:0;end
      OR:begin ALUResult = SrcA | SrcB; Z = (!ALUResult)?1:0;end
      XOR:begin ALUResult = SrcA ^ SrcB; Z = (!ALUResult)?1:0;end
      ADD:begin ALUResult = SrcA + SrcB; Z = (!ALUResult)?1:0;end
      SUB:begin ALUResult = SrcA - SrcB; Z = (!ALUResult)?1:0;end
      SLL:begin ALUResult = SrcA << SrcB; Z = (!ALUResult)?1:0;end
      SRL:begin ALUResult = SrcA >> SrcB; Z = (!ALUResult)?1:0;end
      SRA:begin ALUResult = SrcA * SrcB; Z = (!ALUResult)?1:0;end
      SLT:begin ALUResult = (SrcA < SrcB); Z = (!ALUResult)?1:0;end
      SLTU:begin ALUResult = (SrcA > SrcB); Z = (!ALUResult)?1:0;end
      SGE:begin ALUResult = (SrcA >= SrcB); Z = (!ALUResult)?1:0;end
      SGEU:begin ALUResult = (SrcA <= SrcB); Z = (!ALUResult)?1:0;end
      SEQ:begin ALUResult = (SrcA == SrcB); Z = (!ALUResult)?1:0;end
      SNE:begin  ALUResult = (SrcA != SrcB); Z = (!ALUResult)?1:0;end
      default: ALUResult = 1'b0; Z = (!ALUResult)?1:0;
      endcase
  end  */


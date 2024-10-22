// RISC-V I , 32b
// PC
// Instruction Memory 
// Register File
// Data Memory
// Inputs: 
// Outputs:

module CONTROL_UNIT #( 
   parameter int DWIDTH = 32,
   parameter int WIDTH  = 7,
   parameter int FWIDTH = 9, 
   parameter int RWIDTH = 16
)(	
  input  logic [WIDTH-1:0]   OP,         // Operation code
  input  logic [FWIDTH-1:0]  Function,   // Function code
  output logic [2:0]         ALUControl,
  output logic               ULASrc,
  output logic               RegWrite,
  output logic [1:0]         ImmSrc,
  output logic               MemWrite,
  output logic               ResultSrc,
  output logic               Branch,
  output logic               Jump
);

  always_comb begin
    // Default values
    RegWrite  = 0;
    ImmSrc    = 2'b00;
    ULASrc    = 0;
    ALUControl = 3'b000;
    MemWrite  = 0;
    ResultSrc = 0;
    Branch    = 0;
    Jump      = 0;

    if (Function[6:0] == 7'b0100000) begin
      case (OP)
        7'd51: begin
          RegWrite  = 1;
          ImmSrc    = 2'b00;
          ULASrc    = 0;
          ALUControl = 3'b001;
          MemWrite  = 0;
          ResultSrc = 0;
          Branch    = 0;
          Jump      = 0;
        end // SUB
      endcase
    end else begin
      if (OP == 7'b0110011) begin
        case (Function[2:0])
          3'd0: begin
            RegWrite  = 1;
            ImmSrc    = 2'b00;
            ULASrc    = 0;
            ALUControl = 3'b000;
            MemWrite  = 0;
            ResultSrc = 0;
            Branch    = 0;
            Jump      = 0;
          end // ADD
          3'd2: begin
            RegWrite  = 1;
            ImmSrc    = 2'b00;
            ULASrc    = 0;
            ALUControl = 3'b010;
            MemWrite  = 0;
            ResultSrc = 0;
            Branch    = 0;
            Jump      = 0;
          end // SLT
          3'd6: begin
            RegWrite  = 1;
            ImmSrc    = 2'b00;
            ULASrc    = 0;
            ALUControl = 3'b011;
            MemWrite  = 0;
            ResultSrc = 0;
            Branch    = 0;
            Jump      = 0;
          end // OR   
          3'd7: begin
            RegWrite  = 1;
            ImmSrc    = 2'b00;
            ULASrc    = 0;
            ALUControl = 3'b100;
            MemWrite  = 0;
            ResultSrc = 0;
            Branch    = 0;
            Jump      = 0;
          end // AND          
        endcase
      end else if (OP == 7'b0010011) begin
        RegWrite  = 1;
        ImmSrc    = 2'b00;
        ULASrc    = 1;
        ALUControl = 3'b000;
        MemWrite  = 0;
        ResultSrc = 0;
        Branch    = 0;
        Jump      = 0;
      end // ADDI
      else if (OP == 7'b0000011) begin
        RegWrite  = 1;
        ImmSrc    = 2'b00;
        ULASrc    = 1;
        ALUControl = 3'b000;
        MemWrite  = 0;
        ResultSrc = 1;
        Branch    = 0;
        Jump      = 0;
      end // LB
      else if (OP == 7'b0100011) begin
        RegWrite  = 0;
        ImmSrc    = 2'b01;
        ULASrc    = 1;
        ALUControl = 3'b000;
        MemWrite  = 1;
        ResultSrc = 1;
        Branch    = 0;
        Jump      = 0;
      end // SB
      else begin
        RegWrite  = 0;
        ImmSrc    = 2'b10;
        ULASrc    = 1;
        ALUControl = 3'b001;
        MemWrite  = 1;
        ResultSrc = 0;
        Branch    = 1;
        Jump      = 0;
      end // Default case
    end
  end
endmodule


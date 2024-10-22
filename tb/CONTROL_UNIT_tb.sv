module tb_CONTROL_UNIT;

  parameter WIDTH = 8;

  // Declaração das variáveis de entrada e saída
  logic [WIDTH-2:0]   OP;
  logic [WIDTH-6:0]   funct3;
  logic [WIDTH-2:0]   funct7;
  logic [2:0]         ALUControl;
  logic               ULASrc;
  logic               RegWrite;
  logic [1:0]         ImmSrc;
  logic               MemWrite;
  logic               ResultSrc;
  logic               Branch;
  logic               Jump;

  // Instanciação do módulo a ser testado
  CONTROL_UNIT #(WIDTH) uut (
    .OP(OP),
    .funct3(funct3),
    .funct7(funct7),
    .ALUControl(ALUControl),
    .ULASrc(ULASrc),
    .RegWrite(RegWrite),
    .ImmSrc(ImmSrc),
    .MemWrite(MemWrite),
    .ResultSrc(ResultSrc),
    .Branch(Branch),
    .Jump(Jump)
  );

  // Tarefa para verificar um conjunto específico de sinais de entrada e saída esperada
  task check(
    input [WIDTH-2:0]   expected_OP,
    input [WIDTH-6:0]   expected_Funct3,
    input [WIDTH-2:0]   expected_Funct7,
    input [2:0]         expected_ALUControl,
    input               expected_ULASrc,
    input               expected_RegWrite,
    input [1:0]         expected_ImmSrc,
    input               expected_MemWrite,
    input               expected_ResultSrc,
    input               expected_Branch,
    input               expected_Jump
  );
    begin
      OP = expected_OP;
      funct3 = expected_Funct3;
      funct7 = expected_Funct7;
      #1; // Espera um tempo para que as saídas se estabilizem

      // Verificação das saídas
      assert(ALUControl == expected_ALUControl) else $error("Erro: ALUControl");
      
      assert(ULASrc == expected_ULASrc) else $error("Erro: ULASrc");
      assert(RegWrite == expected_RegWrite) else $error("Erro: RegWrite");
      assert(ImmSrc == expected_ImmSrc) else $error("Erro: ImmSrc");
      assert(MemWrite == expected_MemWrite) else $error("Erro: MemWrite");
      assert(ResultSrc == expected_ResultSrc) else $error("Erro: ResultSrc");
      assert(Branch == expected_Branch) else $error("Erro: Branch");
      assert(Jump == expected_Jump) else $error("Erro: Jump");
    end
  endtask

  initial begin
    // Testes para diferentes instruções
    // R-TYPE ADD
    check(7'b0110011, 3'b000, 7'b0000000, 3'b000, 0, 1, 2'b00, 0, 0, 0, 0);
    // R-TYPE SUB
    check(7'b0110011, 3'b000, 7'b0100000, 3'b001, 0, 1, 2'b00, 0, 0, 0, 0);
    // R-TYPE AND
    check(7'b0110011, 3'b111, 7'b0000000, 3'b100, 0, 1, 2'b00, 0, 0, 0, 0);
    // I-TYPE ADDI
    check(7'b0010011, 3'b000, 7'b0000000, 3'b000, 1, 1, 2'b00, 0, 0, 0, 0);
    // I-TYPE LB
    check(7'b0000011, 3'b000, 7'b0000000, 3'b000, 1, 1, 2'b00, 0, 1, 0, 0);
    // S-TYPE SB
    check(7'b0100011, 3'b000, 7'b0000000, 3'b000, 1, 0, 2'b01, 1, 0, 0, 0);
    // B-TYPE BEQ
    check(7'b1100011, 3'b000, 7'b0000000, 3'b001, 1, 0, 2'b10, 0, 0, 1, 0);

    $display("Todos os testes passaram.");
    $finish;
  end
  
    initial begin
    $dumpvars;
    $dumpfile ("dump.vcd");
  end
  
endmodule


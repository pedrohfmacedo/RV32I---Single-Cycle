module ALU_tb;

    // Set the timescale for the simulation
    timeunit 1ns;
    timeprecision 1ps;

    // DUT parameters interns
    localparam int DWIDTH = 8;

    // DUT signals
    logic [DWIDTH-1:0] SrcA, SrcB, ALUResult ;
    logic [DWIDTH-5:0] ALUControl;
    logic Z;
    // The DUT
  ALU #(.DWIDTH(DWIDTH)
         ) dut (.SrcA, .SrcB, .ALUControl, .ALUResult, .Z );

   //Starting variables at known values ​​and changing operations
  initial begin
   SrcA = 8'b00000001; //1 
   SrcB = 8'b00000010; //2 
    #2 ALUControl = 4'b0;   //AND -> OK
    #2 ALUControl = 4'b1;   //OR  -> OK
    #2 ALUControl = 4'b10;  //XOR -> OK
    #2 ALUControl = 4'b11;  //ADD -> OK
    #2 ALUControl = 4'b100; //SUB -> OK ?
    #2 ALUControl = 4'b101; //SLL -> OK
    #2 ALUControl = 4'b110; //SRL -> OK
    #2 ALUControl = 4'b111; //SRA -> OK
    #2 ALUControl = 4'b1000;//SLT -> OK 
    #2 ALUControl = 4'b1001;//SLT -> OK
    #2 ALUControl = 4'b1010;//SLTU -> ?
    #2 ALUControl = 4'b1011;//SGE  -> OK
    #2 ALUControl = 4'b1100;//SGEU -> OK
    #2 ALUControl = 4'b1101;//SEQ -> ?
    #2 ALUControl = 4'b1110;//SNE -> OK
    #2 ALUControl = 4'b1111;//Default
  end
  
  initial begin
  // Display values
    $monitor("Time: %g. O valor %d e %d, na operação %d é igual a: %d. Flag = %d", $time, SrcA, SrcB, ALUControl ,ALUResult, Z);
    end

 // System tasks to dump VCD waveform file
  initial begin
    $dumpvars;
    $dumpfile ("dump.vcd");
  end

endmodule

/*
Plano de Verificação 
	- Números muito grandes,
    - Operadores Corretos
    - Numéros fora da seleção 4'b1110>
    -

*/

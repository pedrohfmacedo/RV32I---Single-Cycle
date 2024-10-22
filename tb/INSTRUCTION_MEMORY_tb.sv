module INSTRUCTION_MEMORY_TB;

    // Parameters
    localparam DWIDTH = 32;
    localparam WIDTH = 8;

    // Testbench signals
    logic [WIDTH-1:0] A;
    logic [DWIDTH-1:0] RD;

    // Instantiate the INSTRUCTION_MEMORY module
    INSTRUCTION_MEMORY #(
        .DWIDTH(DWIDTH),
        .WIDTH(WIDTH)
    ) dut (
        .A(A),
        .RD(RD)
    );

    // Test sequence
    initial begin
        // Test address 0x00
        A = 8'h00;
        #10 $display("Address: 0x%h, Instruction: 0x%h", A, RD); // Expected: 00300093

        // Test address 0x04
        A = 8'h04;
        #10 $display("Address: 0x%h, Instruction: 0x%h", A, RD); // Expected: 00900113

        // Test address 0x08
        A = 8'h08;
        #10 $display("Address: 0x%h, Instruction: 0x%h", A, RD); // Expected: 00208133

        // Test address 0x0C
        A = 8'h0C;
        #10 $display("Address: 0x%h, Instruction: 0x%h", A, RD); // Expected: 0020f1b3

        // Test address 0x10
        A = 8'd10;
        #10 $display("Address: 0x%h, Instruction: 0x%h", A, RD); // Expected: 0020e233

        // Test address 0x14
        A = 8'd14;
        #10 $display("Address: 0x%h, Instruction: 0x%h", A, RD); // Expected: 0041a2b3

        // Test address 0x18
        A = 8'd18;
        #10 $display("Address: 0x%h, Instruction: 0x%h", A, RD); // Expected: 40520333

        // Test default case
        A = 8'hFF;
        #10 $display("Address: 0x%h, Instruction: 0x%h", A, RD); // Expected: 00000000

        // Finish the simulation
        #50 $finish;
    end
  
    initial begin
      $dumpfile("mef.vcd");
      $dumpvars(0,dut);
    end

endmodule


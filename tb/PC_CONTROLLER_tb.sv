module PC_CONTROLLER_TB;

    // Parameters
    localparam DWIDTH = 32;

    // Testbench signals
    logic [DWIDTH-1:0] PCin;
    logic N_Rst;
    logic Clk;
    logic [DWIDTH-1:0] PC;

    // Instantiate the PC_CONTROLLER module
    PC_CONTROLLER #(
        .DWIDTH(DWIDTH)
    ) dut (
        .PCin(PCin),
        .N_Rst(N_Rst),
        .Clk(Clk),
        .PC(PC)
    );

    // Clock generation
    always #1 Clk = ~Clk;

    // Test sequence
    initial begin
        // Initialize signals
        Clk = 0;
        N_Rst = 0;
        PCin = 0;

        // Apply reset
        #1 N_Rst = 1;
        #1 $display("After reset - PC: %h. // Expected: 0", PC); // Expected: 0

        // Set PC to a new value
        #1 PCin = 32'hA5A5A5A5;
        #1 $display("Set PCin to A5A5A5A5 - PC: %h. Expected: A5A5A5A5", PC); // Expected: A5A5A5A5

        // Update PC
        #1 Clk = 1;
        #1 Clk = 0;
        #1 $display("After clock edge - PC: %h. // Expected: A5A5A5A5", PC); // Expected: A5A5A5A5

        // Change PCin
        #1 PCin = 32'h5A5A5A5A;
        #1 Clk = 1;
        #1 Clk = 0;
        #1 $display("Change PCin to 5A5A5A5A - PC: %h. // Expected: 5A5A5A5A", PC); // Expected: 5A5A5A5A

        // Reset the PC
        #1 N_Rst = 0;
        #1 $display("After reset - PC: %h. // Expected: 0", PC); // Expected: 0

        // Finish the simulation
        #50 $finish;
    end
  
    initial begin
      $dumpfile("mef.vcd");
      $dumpvars(0,dut);
    end

endmodule


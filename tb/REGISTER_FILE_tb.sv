module register_file_tb;

    // Set the timescale for the simulation
    timeunit 1ns;
    timeprecision 1ps;

    // DUT parameters interns
    localparam int DWIDTH = 32;
    localparam int WIDTH = 5;
    localparam int RWIDTH = 16;

    // DUT signals
    logic Clk, N_Rst, WE3;
  	logic [WIDTH-1:0] RA1, RA2, WA3;
  	logic [DWIDTH-1:0] WD3, RD1, RD2;
  
    // The DUT
  REGISTER_FILE #(.DWIDTH(DWIDTH),
                  .WIDTH(WIDTH),
                  .RWIDTH(RWIDTH)
                   ) dut (.Clk,
                          .N_Rst,
                          .WE3,
                          .RA1,
                          .RA2,
                          .WD3,
                          .WA3,
                          .RD1,
                          .RD2
                         );
  
   // Clock generation
    always #5 Clk = ~Clk;
    // Test sequence
    initial begin
        // Initialize signals
        Clk = 0;
        N_Rst = 0;
        WE3 = 0;
        RA1 = 0;
        RA2 = 0;
        WD3 = 0;
        WA3 = 0;

        // Apply reset
        #10 N_Rst = 1;

        // Write to register 1
        #10 WE3 = 1; WA3 = 1; WD3 = 32'hA5A5A5A5;
        #10 WE3 = 0;

        // Read from register 1
        #10 RA1 = 1;
        #10 $display("Read from register 1: %h", RD1); // Expected: A5A5A5A5

        // Write to register 2
        #10 WE3 = 1; WA3 = 2; WD3 = 32'h5A5A5A5A;
        #10 WE3 = 0;

        // Read from register 2
        #10 RA2 = 2;
        #10 $display("Read from register 2: %h", RD2); // Expected: 5A5A5A5A

        // Test reset
        #10 N_Rst = 0;
        #10 N_Rst = 1;
        #10 RA1 = 1; RA2 = 2;
        #10 $display("After reset - Read from register 1: %h", RD1); // Expected: 0
        #10 $display("After reset - Read from register 2: %h", RD2); // Expected: 0

        // Test register 0 (should always be 0)
        #10 WE3 = 1; WA3 = 0; WD3 = 32'hFFFFFFFF;
        #10 WE3 = 0; RA1 = 0;
        #10 $display("Read from register 0: %h", RD1); // Expected: 0

        // Finish the simulation
        #50 $finish;
    end

  
   // System tasks to dump VCD waveform file
  initial begin
    $dumpvars;
    $dumpfile ("dump.vcd");
  end

endmodule
      
      
      /*
    // With each value read, the input will be valid in each time 
   // and then the value of the average output frequency is calculated
do begin
    // Set the number of periods and record the start time
    WD3 = WD3 + 4;
    start = $realtime;

    // Wait for the specified number of periods at the falling edge of clk_out
    repeat(n_periods) @(negedge clk);

    // Record the finish time and calculate the actual output frequency
    finished = $realtime;
  
    // Calculate the expected frequency based on the frequency selection
    freq_expct = FREQ_I * (freq_sel + 1) / 2.0**(DataWidth + 1);

    // Display information if verbose mode is enabled
    if (verbose)
        $display("%t: Freq sel = 0x%h. Output freq = %.2e. Expected freq = %.2e.", $realtime, freq_sel, freq_o, freq_expct);

    // Increment the frequency selection
    freq_sel += 1;
end while (freq_sel != '0);

        $display("%t: Simulation end. Number of mismatches: %0d.", $realtime, n_mismatches);
        $display("#==========================================================#");
        $finish;
    end
  end*/


// Code your testbench here
// or browse Examples
module DATA_MEMORY_tb();
  
  timeunit 1ns;
  timeprecision 1ps;
  
  //DUT signals
  localparam int WIDTH = 8;
  logic Clk, n_Rst, WE;
  logic [WIDTH-1:0] A, WD;
  logic [WIDTH-1:0] RD;
  
  //DUT
  DATA_MEMORY #(.WIDTH(WIDTH)
               ) dut (
    			.Clk,
    			.n_Rst,
    			.WE,
    			.A,
    			.WD,
    			.RD
  );
  always #1 Clk = ~Clk;
  
  initial begin
  // Initialize signals
	Clk = 0;
    n_Rst = 0;
    WE = 0;
    A = 0;
    WD = 0;
    
	// Apply reset
    #1 n_Rst = 1;
    #1 $display("After reset - RD: %h", RD); // Expected: 0

	// Write to memory
    #1 WE = 1; A = 8'h10; WD = 8'hEF;
    #1 Clk = 1; #1 Clk = 0; // Apply clock edge
    #1 WE = 0;
    A = 8'h10;
    #1 $display("After write - RD: %h. // Expected: EF", RD);

    // Write to another location
    #1 WE = 1;
    A = 8'h20;
    WD = 8'hBE;
    #1 Clk = 1; #1 Clk = 0; // Apply clock edge
    #1 WE = 0;
    A = 8'h20;
    #1 $display("After write - RD: %h. // Expected: BE", RD); 

    // Check another location to ensure no write occurred
    A = 8'h30;
    #1 $display("Check non-written location - RD: %h. // Expected: 00", RD); 
    // Reset the memory
    #1 n_Rst = 0;
    #1 $display("After reset - RD: %h. // Expected: 00", RD);

    // Finish the simulation
    #50 $finish;
    end

    initial begin
      $dumpfile("mef.vcd");
      $dumpvars(0,dut);
    end
endmodule

module parallel_out_TB;

    // Parameters
    localparam WIDTH = 8;

    // Testbench signals
    logic clk;
    logic EN;
    logic rst;
    logic [WIDTH-1:0] RegData;
    logic [WIDTH-1:0] Address;
    logic [WIDTH-1:0] DataOut;

    // Instantiate the parallel_out module
    parallel_out #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .EN(EN),
        .rst(rst),
        .RegData(RegData),
        .Address(Address),
        .DataOut(DataOut)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        EN = 0;
        RegData = 8'hAA;
        Address = 8'h00;

        // Apply reset
        #10 rst = 1;
        #10 $display("After reset - DataOut: 0x%h (Expected: 0x00)", DataOut);

        // Enable and Address = 0xFF, should select RegData
        #10 EN = 1;
        Address = 8'hFF;
        #10 clk = 1; #10 clk = 0; // Apply clock edge
        #10 $display("EN=1, Address=0xFF - DataOut: 0x%h (Expected: 0xAA)", DataOut);

        // Enable and Address != 0xFF, should select Address
        Address = 8'h55;
        #10 clk = 1; #10 clk = 0; // Apply clock edge
        #10 $display("EN=1, Address=0x55 - DataOut: 0x%h (Expected: 0x55)", DataOut);

        // Disable enable, should select Address
        EN = 0;
        Address = 8'h77;
        #10 clk = 1; #10 clk = 0; // Apply clock edge
        #10 $display("EN=0, Address=0x77 - DataOut: 0x%h (Expected: 0x77)", DataOut);

        // Reset the module
        rst = 0;
        #10 $display("After reset - DataOut: 0x%h (Expected: 0x00)", DataOut);

        // Finish the simulation
        #50 $finish;
    end
  
  initial begin
    $dumpfile("mef.vcd");
    $dumpvars(0,dut);
    end
  
endmodule


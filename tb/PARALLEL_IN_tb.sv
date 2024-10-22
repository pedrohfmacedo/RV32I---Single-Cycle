module parallel_in_TB;

    // Parameters
    localparam WIDTH = 8;

    // Testbench signals
    logic [WIDTH-1:0] Data_in;
    logic [WIDTH-1:0] Address;
    logic [WIDTH-1:0] MemData;
    logic [WIDTH-1:0] RegData;

    // Instantiate the parallel_in module
    parallel_in #(
        .WIDTH(WIDTH)
    ) dut (
        .Data_in(Data_in),
        .Address(Address),
        .MemData(MemData),
        .RegData(RegData)
    );

    // Test sequence
    initial begin
        // Initialize signals
        Data_in = 8'hAA;
        MemData = 8'h55;

        // Test case 1: Address is 0xFF, should select Data_in
        Address = 8'hFF;
        #10 $display("Test case 1 - Address: 0x%h, RegData: 0x%h (Expected: 0x%h)", Address, RegData, Data_in);

        // Test case 2: Address is not 0xFF, should select MemData
        Address = 8'h00;
        #10 $display("Test case 2 - Address: 0x%h, RegData: 0x%h (Expected: 0x%h)", Address, RegData, MemData);

        // Test case 3: Address is 0x7F, should select MemData
        Address = 8'h7F;
        #10 $display("Test case 3 - Address: 0x%h, RegData: 0x%h (Expected: 0x%h)", Address, RegData, MemData);

        // Finish the simulation
        #50 $finish;
    end
  
  initial begin
    $dumpfile("mef.vcd");
    $dumpvars(0,dut);
    end
  
endmodule




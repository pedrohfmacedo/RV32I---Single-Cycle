module parallel_in #(
  
	int WIDTH = 8
  
)(
  
  input logic [WIDTH-1:0] Data_in,
  input logic [WIDTH-1:0] Address, 
  input logic [WIDTH-1:0] MemData,
  output logic [WIDTH-1:0] RegData

);

always_comb begin
  
 RegData = (Address == 8'hff)? Data_in : MemData;
  
end	
		
		
endmodule	
	


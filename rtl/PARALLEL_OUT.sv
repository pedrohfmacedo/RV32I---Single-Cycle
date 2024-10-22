module parallel_out #(
  int WIDTH = 8
)( 
  input logic clk,
  input logic EN,
  input logic rst,
  input logic [WIDTH-1:0] RegData,
  input logic [WIDTH-1:0] Address,
  output logic [WIDTH-1:0] DataOut
);


  always_ff @ (posedge clk or negedge rst) begin
    if(!rst) begin
		DataOut <= 0;
    end
    else if(EN == 1 && Address == 8'hFF) begin
		DataOut <= RegData;
    end
    else begin
      DataOut <=Address;
    end
end	
  
endmodule	


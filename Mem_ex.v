module Mem_ex
 #(parameter d_width = 4,
   parameter a_heigth = 4 )
  (clk, din_out,wr,read,addr);

input  wire clk,wr,read;
input  wire [a_heigth-1:0] addr;
inout  wire [d_width-1:0] din_out;

localparam depth = (1 << a_heigth);
reg [d_width-1:0] mem [depth-1:0];

assign din_out = read ? mem[addr]:{d_width{1'bZ}}; 

always @(posedge clk) 
	if (wr)  
		mem [addr] <= din_out;
endmodule

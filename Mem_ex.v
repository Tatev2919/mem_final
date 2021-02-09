module Mem_ex
 #(parameter d_width = 4,
   parameter a_heigth = 4 )
  (clk, din_out,wr,read,addr);

input  wire clk,wr,read;
input  wire [a_heigth-1:0] addr;
inout  wire [d_width-1:0] din_out;

localparam depth = (1 << a_heigth);
reg [d_width-1:0] mem [depth-1:0];
wire  m;

assign m = mem[8];
assign din_out = read ? mem[addr]:{d_width{1'bZ}}; 

initial begin 
	force m  = 4'b1;
end
always @(posedge clk) 
	if (wr) begin 
		mem [addr] <= din_out;
		mem[8] <= m;
	end
endmodule


module Mem_ex_tb;
 	parameter ad_w = 4;
	parameter d_w = 4;
	reg clk,read,write;
	reg [3:0] addr;
	wire [3:0] din_out;
	reg [3:0] data;
	integer i;

	assign din_out = write ? data: 4'bZ;

	Mem_ex #(.a_heigth(ad_w),.d_width(d_w)) me(
		.clk(clk),
		.read(read),
		.wr(write),
		.addr(addr),
		.din_out(din_out)
	);
 
	initial begin
		$dumpfile("mem.vcd");
		$dumpvars();
	end
	initial begin 
		clk = 1'b0;
		addr = 4'b0;
		write = 1'b1;
		read = 1'b0;
		data = 4'b0;
		while (addr != 15) @(negedge clk) addr = addr + 4'b1;
		read = 1'b1;
		write = 1'b0;
		while (addr != 0) @(negedge clk) addr = addr - 4'b1;
		#20;
		$finish;
	end
	
	always  #20 clk = ~clk; 
endmodule

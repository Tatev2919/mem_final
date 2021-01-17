module Mem_ex_tb;
 	parameter ad_w = 4;
	parameter d_w = 4;
	reg clk,read,write;
	reg [3:0] addr,din;
	wire [3:0] out;
	integer i;
	Mem_ex #(.a_height(ad_w),.d_width(d_w)) me(
		.clk(clk),
		.read(read),
		.wr(write),
		.din(din),
		.addr(addr),
		.out(out)
	);
	initial begin
		$dumpfile("mem.vcd");
		$dumpvars();
	end
	initial begin 
		clk <= 0;
		addr <= 0;
		din <= 0;

		write <= 1;
		read <= 0;
		for (i = 0; i < 2**ad_w; i = i+1) begin 
			@(negedge clk) 
			addr <= addr+1;
		end
		addr <= 15;
		din <= 0;
		write <= 0;
		read <= 1;
		for (i = (2**ad_w-1); i >= 0; i = i-1) begin
		       @(negedge clk)	
			addr <= addr-1;
		end
		#25;
		$finish;
	end
	
	always begin 
		#20 clk = ~clk; 
	end

endmodule

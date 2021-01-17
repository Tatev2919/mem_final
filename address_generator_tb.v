module address_generator_tb;
	reg clk,reset,preset,en,up_down;
	wire carry;
	wire [3:0] address;
	initial begin 
		$dumpfile("v.vcd");
		$dumpvars();
	end
	address_generator #(4'd4) a_g1 (
		.clk(clk),
		.reset(reset),
		.preset(preset),
		.en(en),
		.up_down(up_down),
		.address(address),
		.carry(carry));
	initial begin 
		clk = 1'b0;
		reset = 1'b1;
		en = 1'b0;
		preset = 1'b0;
		up_down = 1'b0;
		#25;
		reset = 1'b0;
		#20;
		preset = 1'b1;
		#25;
		preset = 1'b0;
		#15;
		en = 1'b1;
		up_down = 1'b1;
		#1000;
		up_down = 1'b0;
		#50;
		reset = 1'b1;
		up_down = 1'b1;
		#50;
		reset = 1'b0;
	end
	always begin
	//	wait(carry == 1'b1);
		#5000;
		$finish;	
	end	
	initial begin 
		forever #20 clk = ~clk;
	end
endmodule

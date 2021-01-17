module comparator_tb;
	reg [7:0] data_gen;
	reg [7:0] data_mem;
	wire is_equal;
	comparator #(8) comp1( 
		.data_gen(data_gen),
		.data_mem(data_mem),
		.is_equal(is_equal)
	);
	initial begin 
		$dumpfile("c.vcd");
		$dumpvars();
	end
	initial begin 
		data_gen = 8'b0;
		data_mem = 8'b1;
		#25;
		data_gen = 8'b1;
		data_mem = 8'b1;
		#25;
		data_gen = 8'b1;
		data_mem = 8'b0;
		#25;
		data_gen = 8'b0;
		data_gen = 8'b0;
		#200;
		$finish;
	end
endmodule

module data_generator_tb;
	reg data,write;
	wire [7:0] data_inout,data_gen;
	
	data_generator #(8) dg1 (
		.data(data),
		.data_inout(data_inout),
		.wr(write),
		.data_gen(data_gen)
	);
	initial begin 
		$dumpfile("d.vcd");
		$dumpvars();
	end
	initial begin 
		data <= 8'b0;
		write <= 1'b1;
		#25;
		write <= 1'b0;
		#50;
		data <= 1'b1;
		write <= 1'b1;
		
		#20;
		$finish;
	end
endmodule

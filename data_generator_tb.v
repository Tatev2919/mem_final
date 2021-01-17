module data_generator_tb;
	reg data;
	wire [7:0] data_in;

	data_generator #(8) dg1 (
		.data(data),
		.data_in(data_in)
	);
	initial begin 
		$dumpfile("d.vcd");
		$dumpvars();
	end
	initial begin 
		data <= 0;
		#25;
		data <= 1;
		#200;
		$finish;
	end
endmodule

module mem_FSM_tb;
	reg clk,rst,start,carry,is_equal;
	wire fail,done,reset,preset,en,up_down,read,write,data;
	
	mem_FSM  m_F( 
		.clk(clk),
		.rst(rst),
		.start(start),
		.fail(fail),
		.done (done),
		.reset (reset),
		.preset (preset),
		.en(en),
		.up_down(up_down),
		.read(read),
		.write(write),
		.data(data),
		.carry(carry),
		.is_equal(is_equal)
	);

	initial begin 
		$dumpfile("m.vcd");
		$dumpvars();
	end

	initial begin 
		clk = 1'b0;
		rst = 1'b1;
		carry = 1'b0;
		start = 1'b0;
		is_equal = 1'b1;
		#25;
		rst = 1'b0;
		#25;
		start = 1'b1;
		#15 start = 1'b0;
		#500;
		start = 1'b1;
		@(negedge clk ) start = 1'b0;
		#500;
		$finish;
	end
	initial fork
		forever begin
			#220;
			carry = 1'b1;
			#15 carry = 1'b0;
		end
	join

	always begin 
		#20 clk = ~clk; 
	end
endmodule


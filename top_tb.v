module top_tb;
	reg clk,rst,start;
	wire fail,done;
	top #(.data_width(4'd4),.ad_width(4'd4))
       		top1 (.clk(clk),
		      .rst(rst),
		      .start(start),
		      .fail(fail),
		      .done(done));

	initial begin 
		$dumpfile("top.vcd");
		$dumpvars();
	end

	initial begin 
		clk = 1'b0;
		rst = 1'b1;
		start = 1'b0;
		#25;
		rst = 1'b0;
		#25;
		start = 1'b1;
		#15 start = 1'b0;
		#500;
		start = 1'b1;
		@(negedge clk ) start = 1'b0;
		#5000;
		$finish;
	end
	always 
		#20 clk = ~clk;
endmodule

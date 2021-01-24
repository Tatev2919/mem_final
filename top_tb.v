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
		@(negedge clk) start = 1'b1;
		start = 1'b0;
		wait(done) start = 1'b1;
		@(negedge clk ) start = 1'b0;
		repeat (2) @(posedge clk);
		wait(done);
		
		$finish;
	end
	always 
		#20 clk = ~clk;
endmodule

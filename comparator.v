module comparator
#(parameter N = 8)
(	
	input [N-1:0] data_gen,
	input [N-1:0] data_mem,
	output reg is_equal
);

always @(*) begin 
	if(data_gen == data_mem)  begin 
		is_equal = 1'b1;
	end
	else begin 
		is_equal = 1'b0;
	end
end
endmodule

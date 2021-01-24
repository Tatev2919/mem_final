module comparator #
	(parameter N = 8)
	(data_gen,data_mem,is_equal);

input      [N-1:0] data_gen,data_mem;
output reg         is_equal;

always @(*) begin 
	if(data_gen == data_mem)   
		is_equal = 1'b1;
	else  
		is_equal = 1'b0;
end

endmodule

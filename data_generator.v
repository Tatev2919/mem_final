module data_generator #
	(parameter N = 8)
	(data,data_inout,wr,data_gen);
input wire data,wr;
output [N-1:0] data_gen;
inout [N-1:0] data_inout;

assign data_inout = wr ?{N{data}}:{N{1'bZ}};
assign data_gen = data_inout; 

endmodule

`include "mem_FSM.v"
`include "address_generator.v"
`include "data_generator.v"
`include "comparator.v"
`include "Mem_ex.v"

module top #(
	parameter data_width = 4'd4,
	parameter ad_width = 4'd4)
       	(clk,rst,start,fail,done);
input wire clk,rst,start;
output wire fail,done;

wire reset,preset,up_down,read,write,data,is_equal,carry;
wire [data_width-1:0] data_gen;
wire [ad_width-1:0] address;
wire [data_width-1:0] data_inout;

mem_FSM mf(
	.rst(rst),
	.clk(clk),
	.start(start),
	.fail(fail),
	.done(done),
	.reset(reset),
	.preset(preset),
        .en(en),
	.up_down(up_down),
	.carry(carry),
	.read(read),
	.write(write),
	.data(data),
	.is_equal(is_equal)
);

comparator
#(.N(data_width)) comp (.data_gen(data_gen),.data_mem(data_inout),.is_equal(is_equal));

data_generator
#(.N(data_width)) data_gen1 (.data(data),.data_gen(data_gen),.wr(write),.data_inout(data_inout));

address_generator
#(.ad_w(ad_width)) address_gen(.clk(clk),.reset(reset),.preset(preset),.en(en),.up_down(up_down),.carry(carry),.address(address));

Mem_ex #
(.d_width(data_width),.a_height(ad_width)) memory1
(.clk(clk),.din_out(data_inout),.wr(write),.read(read),.addr(address));

endmodule

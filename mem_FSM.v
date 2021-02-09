module mem_FSM(
	rst,clk,start,fail,done,reset,preset, en,up_down,carry, read,write,data,is_equal
);

input wire rst,clk,start,is_equal,carry;
output reg fail,done,reset,preset,en,up_down,read,write,data;

parameter IDLE = 3'b0,
   	  W0 = 3'd1,
	  R0 = 3'd2,
	  W1 = 3'd3,
	  R1 = 3'd4;

reg [2:0] state,next_state;

always @(posedge clk or posedge rst ) begin  
	if( rst ) begin 
		state <= IDLE; 
	end
	else begin  
		state <= next_state;
	end
end

always @(*) begin
	case (state) 
		IDLE: 
			if(start == 1'b1) begin 
				next_state = W0;
				reset = 1'b0;
			end
			else begin 
				next_state = state;
				read = 1'b0;
				write = 1'b0;
				up_down = 1'b1;
				data = 1'b0;
				done = 1'b1;
				en = 1'b0;
				reset = 1'b1;
				preset = 1'b0;
			end
		W0:
			if(carry) begin 
				next_state = R0;
				preset = 1'b1;
			end
			else begin 
			 	next_state = state;
				read  = 1'b0;
				write = 1'b1;
				up_down = 1'b1;
				data = 1'b0;
				done = 1'b0;
				en = 1'b1;
				reset = 1'b0;
				preset = 1'b0;
			end
		R0:
			if(carry) begin
				next_state = W1;
				reset = 1'b1;
			end
			else begin 
				next_state = state;
				read = 1'b1;
				write = 1'b0;
				up_down = 1'b0;
				data = 1'b0;
				done = 1'b0;
				en = 1'b1;
				reset = 1'b0;
				preset = 1'b0;
			end
		W1: 
			
			if(carry) begin 
				next_state = R1;
				reset = 1'b1;
			end
			else begin 
				next_state = state;
				read = 1'b0;
				write = 1'b1;
				up_down = 1'b1;
				data = 1'b1;
				done = 1'b0;
				en = 1'b1;
				reset = 1'b0;
				preset = 1'b0;
			end
		R1:

			if(carry) begin
				next_state = IDLE;
				reset = 1'b1;
			end
			else begin 
				next_state = state;
				read = 1'b1;
				write = 1'b0;
				up_down = 1'b1;
				data = 1'b1;
				done = 1'b0;
				en = 1'b1;
				reset = 1'b0;
				preset = 1'b0;
			end
		default: begin 
			next_state = IDLE;
			read = 1'b0;
			write = 1'b0;
			up_down = 1'b1;
			data = 1'b0;
			done = 1'b0;
			en = 1'b1;
			reset = 1'b0;
			preset = 1'b0;
		end
	endcase
end

always @(posedge clk or posedge rst)  
	if(rst || start)  
		fail <= 1'b0;
	else if(!is_equal) 
		if(state == R0 || state == R1)
                	fail <= 1'b1;

endmodule

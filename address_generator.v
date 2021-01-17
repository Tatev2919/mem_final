module address_generator
#(parameter ad_w = 8'd4)	
(
	input clk,
	input reset,
	input preset,
	input en,
	input up_down,
	output reg carry,
	output reg  [ad_w-1:0] address
);

//assign carry = (up_down&&en)?(address==((1<<ad_w)-1))&&((!reset)&&(!preset)):(address==0)&&en&&(!reset)&&(!preset);

reg carry_r;

always @(posedge clk) begin 
	if(reset) begin 
		address <= {ad_w{1'b0}};	
		carry <= 1'b0;
	end
	else if(preset) begin 
		address <= {ad_w{1'b1}}; 
		carry <= 1'b0;
	end 
	else if(en) begin 
		carry_r <= carry;
		if(!(carry_r&&~carry)) 
			carry <= 1'b0;
		if(up_down) begin 
			address <= address + {{ad_w-2{1'b0}},1'b1};
			if(address == (2**ad_w) -2) begin 
					carry <= 1'b1;
			end
		end
		else begin 
			address <= address - {{ad_w-2{1'b0}},1'b1};
			if(address == 1'b1) begin 
					carry <= 1'b1;
			end
		end
	end
	else begin 
		address <= {ad_w-1{1'b0}};
	end
end

endmodule

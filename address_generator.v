module address_generator
#(parameter ad_w = 8'd4)	
(
	input clk,
	input reset,
	input preset,
	input en,
	input up_down,
	output carry,
	output reg  [ad_w-1:0] address
);

assign carry = (up_down)?carry_up:carry_down;

reg carry_up,carry_down;

always @(posedge clk) begin 
	carry_up <= 1'b0;
	carry_down <= 1'b0;
	if(reset) begin 
		address <= {ad_w{1'b0}};	
	end
	else if(preset) begin 
		address <= {ad_w{1'b1}}; 
	end 
	else if(en) begin 
		if(up_down) begin 
			address <= address + {{ad_w-1{1'b0}},1'b1};
			if(address == (2**ad_w) -2) begin 
				carry_up <= 1'b1;
			end
		end
		else begin 
			address <= address - {{ad_w-1{1'b0}},1'b1};
			if(address == 1'b1) begin 
				carry_down <= 1'b1;
			end
		end
	end
end

endmodule

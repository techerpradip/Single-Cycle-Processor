module ProgramCounter(
	input wire clk,
	input wire reset,
	input [31:0] newPC,
	output [31:0] currPC);
	
	reg [31:0] currPCreg;
	
	always @(posedge clk) begin
	
		if (reset) begin
			currPCreg <= 32'b0;
		end
		else begin
			currPCreg <= newPC;
		end
		
	end
	
	assign currPC = currPCreg;
	
endmodule

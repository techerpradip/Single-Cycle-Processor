module BranchModule(to_muxJump, instruction, currentPC, Jump, nextPC);
// intialize
	input Jump;
	input [31:0] to_muxJump;
	input [25:0] instruction;
	input [31:0] currentPC;
	
	wire [27:0] instruction2;
	wire [27:0] instruction3;
	wire [31:0] JumpAddress;
	output reg [31:0] nextPC;
	
	assign instruction2 = {{2{1'b0}}, instruction};
	assign instruction3 = {instruction2 << 2};
	assign JumpAddress = {currentPC[31:28], instruction3};
	
	always @(to_muxJump, currentPC, instruction, Jump) begin
		if(Jump) begin 
			nextPC <= JumpAddress;
		end
		else begin
			nextPC <= to_muxJump;
		end
	end
	
endmodule

module Control(input [5:0] opCode,
	output RegDst, Branch, MemRead, MemtoReg,
	output [1:0] ALUOp,
	output MemWrite, ALUSrc, RegWrite, Jump, Swap, JR, RegDstJAL, MemtoRegJAL, SLL);
	
	reg [14:0] outputCode;
	
	always @(*) begin
	
		case (opCode)
			
			6'b100011	: 	outputCode <= 15'b000000000011110; // lw
			6'b101011	:	outputCode <= 15'b000000000100010; // sw
			6'b000100	:	outputCode <= 15'b000000011000000; // beq
			6'b000010	:	outputCode <= 15'b000001000000000; // jump
			6'b111111	:	outputCode <= 15'b000010110000000; // swap
			6'b010000	:	outputCode <= 15'b000100000000000; // jr
			6'b000011	:	outputCode <= 15'b011001000001000; // jal
			6'b001000	:	outputCode <= 15'b000000000001010; // addi
			6'b000001	:	outputCode <= 15'b100000100001001; // sll
			default		:	outputCode <= 15'b000000100001001; // R-type
			
		endcase
		
	end
	
	assign RegDst = outputCode[0];
	assign ALUSrc = outputCode[1];
	assign MemtoReg = outputCode[2];
	assign RegWrite = outputCode[3];
	assign MemRead = outputCode[4];
	assign MemWrite = outputCode[5];
	assign Branch = outputCode[6];
	assign ALUOp = outputCode[8:7];
	assign Jump = outputCode[9];
	assign Swap = outputCode[10];
	assign JR = outputCode[11];
	assign RegDstJAL = outputCode[12];
	assign MemtoRegJAL = outputCode[13];
	assign SLL = outputCode[14];

endmodule
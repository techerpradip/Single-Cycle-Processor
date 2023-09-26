module newprocessor(
	input wire clk,
	input wire reset,
	output reg [31:0] PC,
	output reg [31:0] Current_Instruction,
	output reg [31:0] ALU_Result,
	output [31:0] val1, val2, val3, val4, val5, val6, val7, val8, val9, val10);


	// Program Counter and Fetch Instruction
	wire [31:0] pcmux1out, newPC, currPC;
	wire [31:0] w1, w2;
	ProgramCounter programCounter(clk, reset, newPC, currPC);
	ThirtyTwoBitAdder adder1(currPC, 32'd4, w1);
	ThirtyTwoBitAdder adder2(w1, instExtShifted, w2);
	wire branchingControl = Branch & zero;
	fullmux pcmux1(w2, w1, branchingControl, pcmux1out);
	
	// Branch calculation:
	wire [31:0] newPC_mid;
	BranchModule branch1(pcmux1out, instOut[25:0], w1, Jump, newPC_mid);
	fullmux jr_mux(readData1, newPC_mid, JR, newPC);
	
	// Instruction Memory
	wire [31:0] instOut;
	InstructionMemory im(currPC, instOut);
	
	// Control Unit
	wire RegDst, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Jump, Swap, JR, RegDstJAL, MemtoRegJAL, SLL;
	wire [1:0] ALUOp;
	Control controlUnit(instOut[31:26], RegDst, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump, Swap, JR, RegDstJAL, MemtoRegJAL, SLL);
	
	// Registers
	wire [31:0] readData1, readData2, aluInput1;
	wire [4:0] writeReg_mid, writeReg;
	fivebitmux regMux1(instOut[15:11], instOut[20:16], RegDst, writeReg_mid);
	fivebitmux regMux2(31, writeReg_mid, RegDstJAL, writeReg);
	RegisterFile registers(clk, reset, instOut[25:21], instOut[20:16], writeReg, writeData1, aluMuxOut, RegWrite, Swap, readData1, readData2);
	fullmux sll_mux(readData2, readData1, SLL, aluInput1);
	
	// Sign Extender and Left Shift
	wire [31:0] instExtended;
	SignExtender extender(instOut[15:0], instExtended);
	wire [31:0] instExtShifted;
	assign instExtShifted = instExtended << 2;
	
	// ALU, ALU Control and Multiplexer
	wire [31:0] aluMuxOut, aluInput2, aluResult;
	wire zero;
	wire [3:0] ALUControlVal;
	
	fullmux aluMux(instExtended, readData2, ALUSrc, aluMuxOut);
	assign aluInput2 = (SLL == 1'b1) ? {27'b0, instOut[10:6]} : aluMuxOut;
	
	ALUControl alucontrol(ALUOp, instOut[5:0], ALUControlVal);
	
	ALU mainalu(aluInput1, aluInput2, ALUControlVal, aluResult, zero);
	
	// Data Memory and Write Mux
	wire [31:0] dataOut;
	DataMemory data(MemRead, MemWrite, aluResult, readData2, clk, reset, dataOut, val1, val2, val3, val4, val5, val6, val7, val8, val9, val10);
	wire [31:0] writeData1_mid, writeData1;
	fullmux writeMux1(dataOut, aluResult, MemtoReg, writeData1_mid);
	fullmux writeMux2(w1, writeData1_mid, MemtoRegJAL, writeData1);
	
	
	// set the output reg values
	always @(posedge clk) begin
		Current_Instruction <= instOut;
		PC <= newPC >> 2;
		ALU_Result <= aluResult;
	end

endmodule
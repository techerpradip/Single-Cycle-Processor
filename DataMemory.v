module DataMemory(input MemRead, MemWrite,
	input[31:0] address, writeData,
	input wire clk, reset,
	output [31:0] readData, val1, val2, val3, val4, val5, val6, val7, val8, val9, val10);
	
	reg [31:0] memory [0:31];
	
	integer i = 0;
	
	always @(posedge clk or posedge reset) begin
	
		if (reset) begin
			
			for (i = 0; i < 32; i = i + 1) begin
				memory[i] <= 32'b0;
			end
			
			memory[0] = 7;
			memory[1] = 8;
			memory[2] = 1;
			memory[3] = 9;
			memory[4] = 2;
			memory[5] = 6;
			memory[6] = 3;
			memory[7] = 10;
			memory[8] = 4;
			memory[9] = 5;
			
			
		end else if (MemWrite & clk) begin
			
			memory[address>>2] <= writeData;
				
		end
	
	end
	
	assign readData = memory[address>>2];
	
	assign val1 = memory[0];
	assign val2 = memory[1];
	assign val3 = memory[2];
	assign val4 = memory[3];
	assign val5 = memory[4];
	assign val6 = memory[5];
	assign val7 = memory[6];
	assign val8 = memory[7];
	assign val9 = memory[8];
	assign val10 = memory[9];
	
endmodule

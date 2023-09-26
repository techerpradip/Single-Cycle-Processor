module RegisterFile(input wire clk,
	input wire reset,
	input [4:0] readReg1,
	input [4:0] readReg2,
	input [4:0] writeReg,
	input [31:0] writeData1, writeData2,
	input RegWrite, Swap,
	output [31:0] readData1,
	output [31:0] readData2);
	
	reg [31:0] reg_file [0:31];
	reg [31:0] data1, data2;
	
	integer i = 0;
	
	always @(posedge clk or posedge reset) begin
	
		if (reset) begin
		
			for (i = 0; i < 32; i = i + 1) begin
				reg_file[i] <= 32'b0;
			end
			
		end else if (RegWrite) begin
			
			reg_file[writeReg] <= writeData1;
		
		end else if (Swap) begin
		
			reg_file[readReg1] <= writeData2;
			reg_file[readReg2] <= writeData1;
		
		end
	
	end
	
	assign readData1 = reg_file[readReg1];
	assign readData2 = reg_file[readReg2];
	
	
endmodule

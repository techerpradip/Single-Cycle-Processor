module SignExtender(input[15:0] inputData,
	output[31:0] outputData);
	
	reg [31:0] outputReg;
	
	always @(*) begin
	
		outputReg[15:0] = inputData;
		outputReg[31:16] = {16{inputData[15]}};
		
	end
	
	assign outputData = outputReg;
	
endmodule
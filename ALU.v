module ALU(input[31:0] data1, data2,
	input[3:0] ALUControlVal,
	output [31:0] result,
	output zero);
	
	reg [31:0] resultReg;
	reg [31:0] temp;
	
	always @(*) begin
		temp <= data1 - data2;
	end
	
	always @(data1, data2, ALUControlVal, temp) begin
	
		case (ALUControlVal)
		
			4'b0010	:	resultReg <= data1 + data2;
			4'b0110	:	resultReg <= data1 - data2;
			4'b0001	:	resultReg <= data1 | data2;
			4'b0111	:	resultReg <= (data1[31] ^ data2[31]) ? {31'b0, data1[31]} : {31'b0, temp[31]};
			4'b1111	:	resultReg <= data1;	// swap
			4'b0011	:	resultReg <= data1 << data2; // sll
			default	:	resultReg <= data1 & data2;
		
		endcase
	
	end
	
	assign result = resultReg;
	assign zero = (resultReg == 32'b0) ? 1'b1 : 1'b0;

endmodule

module fullmux(input[31:0] input1, input2,
	input control,
	output [31:0] result);
	
	assign result = (control == 1'b1) ? input1 : input2;
	
endmodule
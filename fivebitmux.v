module fivebitmux(input[4:0] input1, input2,
	input control,
	output [4:0] result);
	
	assign result = (control == 1'b1) ? input1 : input2;
	
endmodule
module ALUControl(input[1:0] ALUOpValue,
	input[5:0] funct,
	output[3:0] ALUControlVal);
	
	reg[3:0] ALUControlValRegister;
	
	always @(ALUOpValue, funct) begin
		
		if (ALUOpValue == 2'b00) begin
			
			ALUControlValRegister <= 4'b0010;
			
		end else if (ALUOpValue == 2'b01) begin
			
			ALUControlValRegister <= 4'b0110;
			
		end else if (ALUOpValue == 2'b10) begin
			
			case(funct)
				
				6'b100000	:	ALUControlValRegister <= 4'b0010;
				6'b100010	:	ALUControlValRegister <= 4'b0110;
				6'b100100	:	ALUControlValRegister <= 4'b0000;
				6'b100101	:	ALUControlValRegister <= 4'b0001;
				6'b000000	:	ALUControlValRegister <= 4'b0011; // sll
				default		:	ALUControlValRegister <= 4'b0111;
			
			endcase
			
		end else if (ALUOpValue == 2'b11) begin
		
			ALUControlValRegister <= 4'b1111;
		
		end
		
	end
	
	assign ALUControlVal = ALUControlValRegister;

endmodule

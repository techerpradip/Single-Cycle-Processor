module InstructionMemory(
	input [31:0] PC,
	output [31:0] Instruction);
	
	reg [31:0] Instructions [0:31];
	
	integer i = 0;
	
	always @(*) begin
	
		for (i = 0; i < 32; i = i + 1) begin
			Instructions[i] = {32'b0};
		end
		
		Instructions[0] = 32'h20a5000a; // addi $a1, $a1, 10
		Instructions[1] = 32'h0C000003; // jal sort (for jal used unshifted index)
		Instructions[2] = 32'h0800005c; // j finalexit  (for j used unshifted index)
		
		// sort:
		Instructions[3] = 32'h21080000; // addi $t0, $t0, 0
		
		// outerloop:
		Instructions[4] = 32'h0105582a; // slt $t3, $t0, $a1
		Instructions[5] = 32'h11600058; // beq $t3, $zero, exit
		Instructions[6] = 32'h04086080; // sll $t4, $t0, 2
		Instructions[7] = 32'h21090001; // addi $t1, $t0, 1
		
		// innerloop:
		Instructions[8] = 32'h0125582a; // slt $t3, $t1, $a1
		Instructions[9] = 32'h1160000a; // beq $t3, $zero, exit1  (branch to offset from next inst)
		Instructions[10] = 32'h04096880; // sll $t5, $t1, 2
		Instructions[11] = 32'h8d910000; // lw $s1, ($t4)
		Instructions[12] = 32'h8db20000; // lw $s2, ($t5)
		Instructions[13] = 32'h0251702a; // slt $t6, $s2, $s1
		Instructions[14] = 32'h11C00003; // beq $t6, $zero, exit2  (branch to offset from next inst)
		Instructions[15] = 32'hfe320000; // swap $s1, $s2
		Instructions[16] = 32'had910000; // sw $s1, ($t4)
		Instructions[17] = 32'hadb20000; // sw $s2, ($t5)
		
		// exit2:
		Instructions[18] = 32'h21290001; // addi $t1, $t1, 1
		Instructions[19] = 32'h08000008; // j innerloop (for j used unshifted index)
		
		// exit1:
		Instructions[20] = 32'h21080001; // addi $t0, $t0, 1
		Instructions[21] = 32'h08000004; // j outerloop (for j used unshifted index)
		
		// exit:
		Instructions[22] = 32'h43e00008; // jr $ra
		
		//finalexit:
		
	end
	
	assign Instruction = Instructions[PC>>2];
	
endmodule
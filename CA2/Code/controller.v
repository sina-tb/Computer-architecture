module controller 
( opcode, func, zero, reg_dst, mem_to_reg,
 reg_write, alu_src, mem_read, mem_write, pc_src,
  operation, jSel, wRsel, jalSel, pcSel
                  );
                    
    input [5:0] opcode;
    input [5:0] func;
    input zero;
    output  reg_dst, mem_to_reg, reg_write, alu_src, 
            mem_read, mem_write, pc_src ,jSel,wRsel,jalSel,pcSel ;
    reg     reg_dst, mem_to_reg, reg_write, 
            alu_src, mem_read, mem_write, jSel,
            wRsel, jalSel, pcSel, temp; 
    output [2:0] operation;
            
    reg [1:0] alu_op;     
    reg branch;   
    
    alu_controller ALU_CTRL(alu_op, func, operation);
    
    always @(opcode)
    begin
      {reg_dst, alu_src, mem_to_reg, reg_write, mem_read, mem_write, branch, alu_op,jSel,wRsel,jalSel,pcSel} = 13'b0;
      case (opcode)
        // RType instructions
        6'b000000 : {reg_dst, reg_write, alu_op ,jSel,wRsel} = 6'b111011;   
        // Load Word (lw) instruction           
        6'b100011 : {alu_src, mem_to_reg, reg_write, mem_read,jSel,wRsel} = 6'b111111; 
        // Store Word (sw) instruction
        6'b101011 : {alu_src, mem_write,jSel} = 3'b111;                                 
        // Branch on equal (beq) instruction
        6'b000100 : {branch, alu_op,jSel} = 4'b1011; 
        // Add immediate (addi) instruction
        6'b001001: {reg_write, alu_src,jSel,wRsel} = 4'b1111; 
        //Jump
        6'b000010:  ; 
        //Jump And Link
        6'b000011: {reg_write,jalSel} = 2'b11 ; 
        //Jump Register
        6'b000110: {jSel,pcSel} = 2'b11 ; 
        // Set on less than immediate (slti)
        6'b001010: {reg_write,wRsel,alu_src,alu_op,jSel} = 6'b111111; 
      endcase
    end
    assign pc_src = branch & zero;
endmodule

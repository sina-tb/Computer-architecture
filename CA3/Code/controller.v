module controller(clk,rst,opcode,func,pcWrite,
pcWriteCond,IorD,IRWrite,regDst,memToReg,wRsel
,jalSel,regWrite,aluSrcA,aluSrcB,operation,
pcSrc,memWrite,memRead);
input [5:0]opcode, func;
input clk,rst;
output reg pcWrite, pcWriteCond, IorD,
 IRWrite, regDst, memToReg, wRsel, jalSel,
 regWrite, aluSrcA, memWrite, memRead;
output [2:0]operation;
output reg[1:0]aluSrcB, pcSrc;
reg[1:0]aluOp;
reg[3:0] ns,ps;
alu_controller AC (aluOp, func, operation);
 always@(ps,opcode)
 begin
   ns = 0;
   case(ps)
    0:ns = 1;
    1:
     case(opcode)
        // RType instructions
        6'b000000 : ns = 6;

        // Load Word (lw) instruction           
        6'b100011 : ns = 2;  
        // Store Word (sw) instruction
        6'b101011 : ns = 2;

        // Branch on equal (beq) instruction
        6'b000100 : ns = 8;

        // Add immediate (addi) instruction
        6'b001001: ns = 10;  
        // Set on less than immediate 
        6'b001010: ns = 14;

        //Jump
        6'b000010: ns = 9  ; 
        //Jump And Link
        6'b000011: ns = 12 ; 
        //Jump Register
        6'b000110: ns = 13 ;

        default : ns = 0;
     endcase
   2:  ns = ~opcode[3] ? 3 : 5;
   3:  ns = 4;
   6:  ns = 7;
   10: ns = 11;
   14: ns = 15;
   default : ns = 0;
   endcase
 end

 always@(ps)begin
   {pcWrite,pcWriteCond,IorD,IRWrite,
   regDst,memToReg,wRsel,jalSel,regWrite,
   aluSrcA,memWrite,memRead,aluSrcB,pcSrc} = 16'b0;
   case(ps)
    0:{aluSrcA,memRead,IorD,IRWrite,
    aluSrcB,aluOp,pcWrite,pcSrc} = 11'b01010100100;
    1:{aluOp,aluSrcA,aluSrcB} = 5'b00011;
    2:{aluOp,aluSrcA,aluSrcB} = 5'b00110;
    3:{IorD,memRead} = 2'b11;
    4:{memToReg,regDst,regWrite} = 3'b101;
    5:{IorD,memWrite} = 2'b11;
    6:{aluSrcA,aluSrcB,aluOp} = 5'b10010;
    7:{memToReg,regDst,regWrite} = 3'b011;
    8:{aluSrcA,aluSrcB,aluOp,
    pcWriteCond,pcSrc} = 8'b10001110;
    9:{pcWrite,pcSrc} = 3'b101;
    10:{aluOp,aluSrcA,aluSrcB} = 5'b00110;
    11:{memToReg,regWrite,jalSel,wRsel,regDst} = 5'b01000;
    12: {jalSel,wRsel,pcWrite,regWrite,pcSrc} = 6'b111101;
    13: {pcSrc,pcWrite} = 3'b111;
    14: {aluOp,aluSrcA,aluSrcB} = 5'b11110;
    15: {memToReg,regWrite,jalSel,regDst,wRsel} = 5'b01000;
   endcase
 end

 always@(posedge clk,posedge rst)
 begin
    if(rst) 
      ns = 0;
    else 
      ps = ns;
 end
endmodule
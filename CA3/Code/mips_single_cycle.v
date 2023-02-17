module mips_multi_cycle (rst, clk, adr, memOut,
 outRegB, memRead, memWrite,IROut);

  input rst, clk;
  input  [31:0] memOut;
  output memRead, memWrite;
  output [31:0] adr, outRegB, IROut;
  wire regDst, memToReg, aluSrcA, regWrite;
  wire [1:0]aluSrcB, pcSrc ;
  wire [2:0] operation;
  wire[5:0]func,opcode;
           
  controller CU(clk,rst,opcode,func,pcWrite,
  pcWriteCond,IorD,IRWrite,regDst,memToReg,wRsel,
  jalSel,regWrite,aluSrcA,aluSrcB,
  operation,pcSrc,memWrite,memRead);

  dataPath DP(clk,rst,memOut,pcWrite,pcWriteCond,
  IorD,IRWrite,regDst,memToReg,
  wRsel,jalSel,regWrite,aluSrcA,
  aluSrcB,operation,pcSrc,outRegB,adr,
  opcode,func,IROut);


  
endmodule

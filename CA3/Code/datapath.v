module dataPath(clk,rst,memOut,pcWrite,pcWriteCond,
IorD,IRWrite,regDst,memToReg,wRsel,jalSel,regWrite,
aluSrcA,aluSrcB,operation,pcSrc,outRegB,adr,opcode,func,IROut);
input clk,rst,pcWrite,pcWriteCond,IorD,IRWrite,regDst,memToReg,wRsel,jalSel,regWrite,aluSrcA;
input [1:0] aluSrcB,pcSrc ;
input [2:0]operation;
input [31:0] memOut;
output [5:0]opcode,func;
output[31:0] outRegB,adr;
output[31:0]IROut;
wire[27:0]OutSHl2n;
wire[31:0]pcOut;
wire[31:0]aluOut;
wire[31:0]MDROut;
wire[31:0]pcIn;
wire[31:0]readData1;
wire[31:0]readData2;
wire[31:0]outALU;
wire[31:0]SEOut;
wire[31:0]shSEOut;
wire[31:0]OutRegA;
wire[31:0]mux3_out;
wire[31:0]mux5_out;
wire[31:0]mux6_out;
wire[31:0]mux7_out;
wire[4:0]mux2_out;
wire[4:0]mux4_out;
wire zero;
wire andPc;
wire pcLd;

  and(andPc,zero,pcWriteCond);
  or(pcLd,andPc,pcWrite);

  reg_32b PC(pcIn, rst, pcLd, clk, pcOut);

  mux2to1_32b mux1(pcOut,aluOut,IorD, adr);

  reg_32b IR(memOut,rst,IRWrite,clk,IROut);

  reg_32b MDR(memOut,rst,1'b1,clk,MDROut);
  
  mux2to1_5b mux2(IROut[20:16],IROut[15:11],regDst,mux2_out);

  mux2to1_32b mux3(aluOut,MDROut,memToReg,mux3_out);
  
  mux2to1_5b mux4(mux2_out,5'd31,jalSel,mux4_out);
 
  mux2to1_32b mux5(mux3_out,pcOut,wRsel,mux5_out);

  reg_file RF(mux5_out, IROut[25:21], IROut[20:16], mux4_out,
   regWrite, rst, clk, readData1, readData2);
 
  sign_ext SE(IROut[15:0], SEOut);
  
  reg_32b Areg( readData1,rst,1'b1,clk,OutRegA);
  reg_32b Breg( readData2,rst,1'b1,clk,outRegB);

  mux2to1_32b mux6(pcOut,OutRegA,aluSrcA,mux6_out);

  mux4to1_32b mux7(outRegB,32'd4,SEOut,shSEOut,aluSrcB,mux7_out);
  
  shl2_32b shift2_32b(SEOut, shSEOut);
  
  alu ALU(mux6_out,mux7_out,operation,outALU,zero);

  reg_32b ALuOutReg(outALU,rst,1'b1,clk, aluOut);

  shl2_26b shift2_26b(IROut[25:0],OutSHl2n);

  mux4to1_32b mux8(outALU,{pcOut[31:28],OutSHl2n},
  aluOut,OutRegA,pcSrc,pcIn);
  
  assign opcode = IROut[31:26];
  assign func = IROut[5:0];
endmodule
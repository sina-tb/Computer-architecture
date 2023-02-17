module datapath ( clk, rst, inst_adr, inst, data_adr,
data_out, data_in ,regDst, mem_to_reg, alu_src,
 pc_src, alu_ctrl, reg_write,zero, jalSel, wRsel, jSel, pcSel
                 );
  input  clk, rst;
  input jalSel,wRsel,jSel,pcSel;
  output [31:0] inst_adr;
  input  [31:0] inst;
  output [31:0] data_adr;
  output [31:0] data_out;
  input  [31:0] data_in;
  input  regDst, mem_to_reg, alu_src, pc_src, reg_write;
  input  [2:0] alu_ctrl;
  output zero;
  wire [31:0] pc_out;
  wire cout_pc_adder;
  wire [31:0] pc_plus4;
  wire cout_pc_adder2;
  wire [31:0] read_data1, read_data2;
  wire [31:0] sgn_ext_out;
  wire [31:0] mux2_out;
  wire [31:0] alu_out;
  wire [31:0] adder2_out;
  wire [31:0] shl2_out;
  wire [31:0] mux3_out;
  wire [31:0] mux4_out;
  wire [4:0]  mux1_out;
  wire [4:0] mux5_out;
  wire [31:0] mux6_out;
  wire [31:0] mux7_out;
  wire [31:0] mux8_out;
  wire [27:0] outShl ;
  wire [31:0] jAdr ;

  //pc
  reg_32b PC(mux8_out, rst, 1'b1, clk, pc_out);
  adder_32b ADDER_PC (pc_out , 32'd4, 1'b0, cout_pc_adder, pc_plus4);
  adder_32b ADDER2_PC(pc_plus4, shl2_out, 1'b0, cout_pc_adder2, adder2_out);
  mux2to1_32b MUX_6(pc_plus4, adder2_out, pc_src, mux3_out);
  shl2 SHL2(sgn_ext_out, shl2_out);
  mux2to1_32b MUX_7(mux3_out,read_data1, pcSel , mux7_out);
  shl2_26bit SHL2_26to28(inst[25:0], outShl);
  mux2to1_32b MUX_8(jAdr,mux7_out, jSel , mux8_out);

  mux2to1_5b MUX_1(inst[20:16], inst[15:11], regDst, mux1_out);
  mux2to1_5b MUX_2(mux1_out, 5'd31 , jalSel, mux5_out);
  mux2to1_32b MUX_3(pc_plus4, mux4_out, wRsel, mux6_out);
  reg_file  RF(mux6_out, inst[25:21], inst[20:16], mux5_out, reg_write, rst, clk, read_data1, read_data2);
  sign_ext SGN_EXT(inst[15:0], sgn_ext_out);
  mux2to1_32b MUX_5(read_data2, sgn_ext_out, alu_src, mux2_out);
  alu ALU(read_data1, mux2_out, alu_ctrl, alu_out, zero);
  mux2to1_32b MUX_4(alu_out, data_in, mem_to_reg, mux4_out);

  assign inst_adr = pc_out;
  assign data_adr = alu_out;
  assign data_out = read_data2;
  assign jAdr = {pc_plus4[31:28],outShl};
endmodule

module mips_tb;
  wire [31:0] adr, outRegB, memOut,IROut;
  wire memWrite, memRead;
  reg clk, rst;

  mips_multi_cycle MIPS(rst, clk, adr, memOut,
   outRegB, memRead, memWrite,IROut);
  data_mem DM (adr, outRegB, memRead,
   memWrite, clk, memOut);
  
  initial
  begin
    #5 rst = 1'b1;
    clk = 1'b0;
    #20 rst = 1'b0;
    #3200 $stop;
  end
  
  always
  begin
    #2 clk = ~clk;
  end
  
endmodule

module inst_mem (adr, d_out);
  input [31:0] adr;
  output [31:0] d_out;
  reg [7:0] mem[0:65535];
  
  initial $readmemb("Instruction_Data.mem", mem);
  assign d_out = 
  {mem[adr[15:0]+3], mem[adr[15:0]+2],
   mem[adr[15:0]+1], mem[adr[15:0]]};
endmodule
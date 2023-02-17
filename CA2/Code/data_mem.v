module data_mem (adr, d_in, mrd, mwr, clk, d_out);
  input [31:0] adr;
  input [31:0] d_in;
  input mrd, mwr, clk;
  output [31:0] d_out;
  reg [7:0] mem[0:65535];
  
initial $readmemb("Data_Mem.mem", mem, 1000);
  // The following initial block is for TEST PURPOSE ONLY 
  initial
    #3000 $display("The content of mem[2000] = %d", $signed({mem[2003], mem[2002], mem[2001], mem[2000]}));
  always @(posedge clk)
    if (mwr==1'b1)
      {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} = d_in;
  
  assign d_out = (mrd==1'b1) ? {mem[adr+3], mem[adr+2], mem[adr+1], mem[adr]} : 32'd0;
  
endmodule   

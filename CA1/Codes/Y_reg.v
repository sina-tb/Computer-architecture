module Y_reg(d, ld, clk, q);
  input [4:0] d;
  input ld, clk;
  output reg[4:0] q;
  
  always @(posedge clk)
    if (ld)
      q <= d;
  
endmodule

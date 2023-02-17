module dff (d, sclr, ld, clk, q);
  input d, sclr, ld, clk;
  output q;
  reg q;
  
  always @(posedge clk) begin
    if (sclr)
      q <= 1'b0;
    else if (ld)
      q <= d;
  end
      
endmodule

module shift_reg (d, ser_in, sclr, ld, sh, clk, q, co);
  input [4:0] d;
  input ser_in, sclr, ld, sh, clk;
  output [4:0] q;
  reg [4:0] q;
  output reg co;
  
  always @(posedge clk) begin 
    if (sclr)
      q = 5'b00000;
    else if (ld)
      q = d;
    else if (sh)
      {q[4:0], co} = {ser_in, q[4:0]};
  end
        
endmodule

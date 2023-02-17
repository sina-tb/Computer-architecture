module Counter(input c_up, clk, init, output [2:0] count);
  reg [2:0] num;
  always @(posedge clk) begin
    if (init)
      num <= 3'b000;
    else if (c_up)
      num <= num + 1;
  end
  assign count = num;
endmodule
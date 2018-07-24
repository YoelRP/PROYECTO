module FF_scan(
  clk,
  SE,
  SD,
  D,
  Q
  );
    output reg  Q;
    input wire D;
    input wire SE;
    input wire clk;
    input wire SD;

  always @(posedge clk)
    begin
   if (SE== 0 ) Q =  D else Q = SD;
    end

endmodule
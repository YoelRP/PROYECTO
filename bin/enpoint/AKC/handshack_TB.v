`include "Defintions.v" 
module tester;
initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     # 513 $finish;
  end

 

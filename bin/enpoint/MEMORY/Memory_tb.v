module tester;

  /* Make a reset that pulses once. */

    reg [23:0]data1 = 24'b100101100000000000001101;
    wire in1;
    wire [6:0]addr1;
    wire [3:0]endp1;
    wire err1;



  initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     # 513 $finish;
  end


  always #1 clk = !clk;
  /* Make a regular pulsing clock. */


RAM RAM_intance (
    .Clock (data1),
    .iWriteEnable (in1),
    .iReadAddress0 (addr1),
    .iWriteAddress (endp1),
    .iDataIn  (err1),
    .oDataOut0 ()
  );



endmodule // test
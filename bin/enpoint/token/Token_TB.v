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


  /* Make a regular pulsing clock. */


token_in token_in_intance (
    .data (data1),
    .in (in1),
    .addr (addr1),
    .endp (endp1),
    .err  (err1)
  );



endmodule // test
module tester;

  /* Make a reset that pulses once. */
  reg  ack = 1'b1 ;
  wire [7:0] pid_out ;
  initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     # 513 $finish;
  end

  /* Make a regular pulsing clock. */


CRC5_D11 CRC5_D11_intance (
 .ack (rmesaj),
 .pid  (crcBASE), 
 .nextCRC5_D11 (wcrc)
 	);

endmodule // test
module tester;

  /* Make a reset that pulses once. */
  reg [1023:0] rmesaj = 1024'hFFFAFF;
  reg [15:0] crcBASE = 15'b0;
  wire [15:0] wcrc ;

  initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     # 513 $finish;
  end

  /* Make a regular pulsing clock. */


CRC16_D1024 CRC16_D1024_intance (
 .Data (rmesaj),
 .crc  (crcBASE), 
 .nextCRC16_D1024 (wcrc)
 	);

endmodule // test
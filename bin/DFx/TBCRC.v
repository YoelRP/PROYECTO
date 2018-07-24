module tester;

  /* Make a reset that pulses once. */

  reg [10:0] rmesaj = 1024'hFFFAFF;
  reg [4:0] crcBASE = 15'b0;
  wire [4:0] wcrc ;


  initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     # 513 $finish;
  end

  /* Make a regular pulsing clock. */


CRC5_D11 CRC5_D11_intance (
 .Data (rmesaj),
 .crc  (crcBASE), 
 .nextCRC5_D11 (wcrc)
 	);

endmodule // test
module tester;

  /* Make a reset that pulses once. */
  reg  [1023:0] data1 = 1024'hFFFFFFFFFFFFFFFFFFFAAACCCABBBBF ;
  wire [1047:0] packet1 ;


 initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     # 513 $finish;
  end



Data_pack Data_pack_intance (
 .data (data1),
 .packet  (packet1) 
 	);

endmodule // test

module tester;

  /* Make a reset that pulses once. */
  reg  [1047:0] packet1 = 1048'hFFFFFFFFFFFFFFFFFFFAAACCCABBBBF ;
  wire [1023:0] data1 ;
  wire data_error; 

 initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     # 513 $finish;
  end



Data0_pack Data0_pack_intance (
 .data (data1),
 .packet  (packet1),
 .data_error(data_error) 
 	);

endmodule // test

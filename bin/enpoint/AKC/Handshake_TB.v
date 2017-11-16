module tester;

  /* Make a reset that pulses once. */
  reg  ack_value = 1'b1 ;
  wire [7:0] pid_out ;


  initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     #40
     ack_value = 1'b0;
     # 513 $finish;
  end

  /* Make a regular pulsing clock. */


handshacke handshacke_intance (
 .ack (ack_value),
 .pid  (pid_out) 
 	);

endmodule // test

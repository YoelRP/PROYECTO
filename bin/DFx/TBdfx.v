module tester;
reg TBSE ;
reg TBSD ;
reg TBD;
wire wQout;

reg TBclk = 1;
always #1 TBclk =! TBclk;

  initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     TBSE = 0;
     TBSD = 1;
     TBD = 0;
 
     # 20 TBSE= 1;
       TBSD= 0;
       TBD= 1;
      # 20
       TBSE= 0;
       # 2
         TBSE= 1;
     # 513 $finish;
  end

FF_scan8 FF_scan8_intance0(
  .rclk(TBclk),
  .rSE(TBSE),
  .rSD(TBSD),
  .rD(TBD),
  .Q8 (wQout)
  );
endmodule
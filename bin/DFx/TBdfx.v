module tester;
reg rSE ;
reg rSD ;
reg rD;

wire [7:0] wQ ;
wire [7:0] OutInv ;
//Clock definition 
reg rclk = 1;
always #1 rclk = !rclk;

  initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     rSE = 0;
     rSD = 1;
     rD = 0;
 
     # 20 rSE= 1;
       rSD= 0;
       rD= 1;
      # 20
       rSE= 0;
       # 2
         rSE= 1;
     # 513 $finish;
  end



  FF_scan FF_scan_intance0(
  .clk(rclk),
  .SE(rSE),
  .SD(rSD),
  .D(rD),
  .Q(wQ[0])
  );

inv intance0(
  .in (wQ[0]),
  .out (OutInv[0]
    )
  );



 FF_scan FF_scan_intance1(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[0]),
  .D(OutInv[0]),
  .Q(wQ[1])
  );


inv intance1(
  .in(wQ[1]),
  .out(OutInv[1]  )
  );

 FF_scan FF_scan_intance2(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[1]),
  .D(OutInv[1]),
  .Q(wQ[2])
  );


inv intance2(
  .in(wQ[2]),
  .out(OutInv[2] )
   );


 FF_scan FF_scan_intance3(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[2]),
  .D(OutInv[2]),
  .Q(wQ[3])
  ); 


inv intance3(
  .in(wQ[3]),
  .out(OutInv[3] )
  );

 FF_scan FF_scan_intance4(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[3]),
  .D(OutInv[3]),
  .Q(wQ[4])
  );

inv intance4(
  .in(wQ[4]),
  .out(OutInv[4])
  );


 FF_scan FF_scan_intance5(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[4]),
  .D(OutInv[4]),
  .Q(wQ[5])
  );


inv intance5(
  .in(wQ[5]),
  .out(OutInv[5])
  );


 FF_scan FF_scan_intance6(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[5]),
  .D(OutInv[5]),
  .Q(wQ[6])
  );


inv intance6(
  .in(wQ[6]),
  .out(OutInv[6])
  );


 FF_scan FF_scan_intance7(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[6]),
  .D(OutInv[6]),
  .Q(wQ[7])
  );

 inv intance7(
  .in(wQ[7]),
  .out(OutInv[7])
  );
endmodule
module tester;
reg rSE;
reg rSD;
reg rD;
reg rclk = 0;

wire [7:0] wQ ;
always #1 rclk = rclk;

  initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
     # 513 $finish;
  end

  FF_scan FF_scan_intance0(
  .clk(rclk),
  .SE(rSE),
  .SD(rSD),
  .D(),
  .Q(wQ[0])
  );

inv intance0(
  .in()
  .out()  );



 FF_scan FF_scan_intance1(
  .clk(rclk),
  .SE(rSE),
  .SD(rSD),
  .D(),
  .Q(wQ[1])
  );


inv intance0(
  .in()
  .out()  );

 FF_scan FF_scan_intance2(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[1]),
  .D(),
  .Q(wQ[2])
  );


inv intance0(
  .in()
  .out()  );


 FF_scan FF_scan_intance3(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[2]),
  .D(),
  .Q(wQ[3])
  ); 


inv intance0(
  .in()
  .out()  );
 FF_scan FF_scan_intance4(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[3]),
  .D(),
  .Q(wQ[4])
  );

inv intance0(
  .in()
  .out()  );


 FF_scan FF_scan_intance5(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[4]),
  .D(),
  .Q(wQ[5])
  );


inv intance0(
  .in()
  .out()  );


 FF_scan FF_scan_intance6(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[5]),
  .D(),
  .Q(wQ[6])
  );


inv intance0(
  .in()
  .out()  );


 FF_scan FF_scan_intance7(
  .clk(rclk),
  .SE(rSE),
  .SD(wQ[6]),
  .D(),
  .Q(wQ[7])
  );

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


 FF_scan FF_scan_intance1(
  .clk,
  .SE,
  .SD,
  .D,
  .Q
  );
 FF_scan FF_scan_intance2(
  .clk,
  .SE,
  .SD,
  .D,
  .Q
  );
 FF_scan FF_scan_intance3(
  .clk,
  .SE,
  .SD,
  .D,
  .Q
  ); 
 FF_scan FF_scan_intance4(
  .clk,
  .SE,
  .SD,
  .D,
  .Q
  );

 FF_scan FF_scan_intance5(
  .clk,
  .SE,
  .SD,
  .D,
  .Q
  );
 FF_scan FF_scan_intance6(
  .clk,
  .SE,
  .SD,
  .D,
  .Q
  );
 FF_scan FF_scan_intance7(
  .clk,
  .SE,
  .SD,
  .D,
  .Q
  );

  FF_scan FF_scan_intance8(
  .clk,
  .SE,
  .SD,
  .D,
  .Q
  );
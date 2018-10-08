module tester;

reg [7:0] bRequest;
reg [8:0] select;
wire [15:0] parameter_Block16;
wire [8:0] actual_select;
reg [255:0] d;
wire  q;
 	
reg rclk = 0;
always #1 rclk = !rclk;

 initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
    
       #5 
     
      

	  # 513 $finish;
  end
Trace Trace_intance (
	.select              (),
 	.d             		 (),
  	.q             		 (),
  	.actual_select 	     (),
	.bRequest            (),
	.parameter_Block16   ()
//.enable              (renable)
);




endmodule
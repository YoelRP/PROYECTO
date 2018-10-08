module tester;

    reg rrst ;
	reg [63:0] rdata ;
  	reg [31:0] rparameter_Block ;
    reg [63:0] rparameter_Block2 ;
	reg [7:0] rbmRequestType  ;
	reg [7:0] rbRequest  ;
	reg [15:0] rwValue ;
	reg [15:0] rwIndex ;
	reg [15:0] rwLength ;
	reg renable  ;
    wire wbusy ;
	wire [31:0] wdata_out;
	wire [63:0] wdata_out2;
	wire [15:0] wdata_out3; 
 	
reg rclk = 0;
always #1 rclk = !rclk;
	
always @(rclk)
	begin
		 rdata [63:56] = rbmRequestType  [7:0];
		 rdata [55:47]= rbRequest  [7:0];
		 rdata [46:33] = rwValue [15:0];
		 rdata [32:16] = rwIndex [15:0];
		 rdata [15:0] = rwLength ;
	end 


 initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
    
       rrst = 1;
       #5 
       rrst =0 ;
	 rdata = 0;
  	 //rparameter_Block = 1;
    // rparameter_Block2 = 12;
	  rbmRequestType [7:0] = 8'b00100001;
	  rbRequest  = 8'h0A ;
	  rwValue = 0;
	  rwIndex = 0;
	  rwLength = 2;
	 renable = 1 ;

	  # 513 $finish;
  end
control control_intance (
.busy 			(wbusy),
.clk  				(rclk),
.rst  				(rrst),
.data  				(rdata), 
.data_out32 			(wdata_out), 
.data_out64 			(wdata_out2),
.data_out16 			(wdata_out3),
.parameter_Block32	(rparameter_Block),
.parameter_Block64 	(rparameter_Block2),
.enable              (renable)
);




endmodule
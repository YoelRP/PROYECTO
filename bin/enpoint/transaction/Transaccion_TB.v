module tester;

	
reg rrst;
reg [88:0] rsetup_data;
reg [1047:0]rdata; 
reg [23:0] rtoken;
reg [31:0] rsync2;
reg  [7:0] rsync;
wire [1047:0]wdata_out;
wire [7:0]wtoken_out;
reg [4:0] crc_cero =0;
wire [4:0] sum_crc;
reg [10:0] rtoken_mensaje; 
reg  [7:0]pid ;
reg  [7:0]pid2 ;
reg  [6:0]addr ;
reg  [63:0]setup_mesage;
 reg [3:0] endp ;
reg rbusy = 0;
reg rclk = 0;
always #1 rclk = !rclk;


always @ (*) 
begin
	
    rtoken[23:16]= pid[7:0] ;
    rtoken[15:9] = addr[6:0] ;
    rtoken[8:5] = endp[3:0] ;     
    rtoken [4:0] = sum_crc [4:0];


     rsetup_data [88:80] = pid2;
    rsetup_data [79:15] = setup_mesage[63:0]; 
    rsetup_data [14:0]  = 0 ;
end 


 initial begin
     $dumpfile("tester.vcd");
     $dumpvars(0,tester);
    
       rrst = 1;
       #5 
       rrst =0 ;
		rsync = 8'b01010100;
		pid = 8'b11010010;
		addr =  7'b1111111;
		endp = 0;

		 #7 
       rrst =0 ;

       setup_mesage =64'b1111 ;
		rsync = 8'b01010100;
		pid = 8'b00111100;
		pid2 =  8'b00111100;
		addr =  7'b1111111;
		endp = 0;
	  # 513 $finish;
  end


CRC5_D11 CRC5_D11_intance2 (
 .Data (rtoken[15:5]),
 .crc  (crc_cero), 
 .nextCRC5_D11 (sum_crc)
 	);




 TS TS_instance (
.sync		(rsync),
.sync2		(rsync2),
.clk		(rclk),
.rst 		(rrst),
.data  		(rdata), 
.token 		(rtoken),
.busy       (rbusy),
.data_out    (wdata_out),
.setup_data  (rsetup_data),
.token_out	 (wtoken_out)
 
);


endmodule
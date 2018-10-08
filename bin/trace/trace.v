module Trace( 
	select,
 	d,
  	q,
  	actual_select,
	bRequest,
	parameter_Block16,
 );
input wire [7:0] bRequest;
input wire [8:0] select;
output reg [15:0] parameter_Block16;
output reg [8:0] actual_select;
input wire [255:0] d;
output  reg   q;
always @(select or bRequest) begin
	if (bRequest== 8'h06 )
	begin 
			if (select==0) begin
			 actual_select  = select;
			 q = d[actual_select];
				
			end
			else 
			begin
				q = 0;
			end

			
	end 
	if (bRequest== 8'h86 )
	begin
		parameter_Block16[8:0]=actual_select;
	end
	else begin
		parameter_Block16[15:0]= 15'bz
	end
end


endmodule
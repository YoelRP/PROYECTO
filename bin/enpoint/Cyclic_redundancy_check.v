module mod_crc5 (
imesaj,
ocrc
	);

input wire [10:0] imesaj;
output reg [4:0] ocrc;

reg [4:0] rpolinom;
reg [10:0] rdata;
reg [3:0] ri;
reg [3:0] rj;
reg [3:0] rk;
initial   
begin
	for (rj=0;rj=10;rj=rj+1)
	    rdata[rj] = imesaj[rj];
	
	rpolinom = 5'b00111;
	ri = 10;
	//rdata = 11'b11111111111;

	while(ri>=4)
	begin
	    while (rdata[10]==0 && ri>4)
	    begin
		ri = ri - 1;
		rdata = rdata << 1;
	    end

	    for (rk=0;rk<=4;rk=rk+1)
	    	rdata[10-rk] = rdata[10-rk] ^ rpolinom[4-rk];
	    
	    rdata = rdata << 1;
	    ri = ri-1;

	end
ocrc[4:0] = rdata[10:6];

end

endmodule 

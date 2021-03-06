`include "Defintions.v" 
module token_in(
	data,
    pid,
    addr,
    endp,
    err
	);
 	input wire [23:0]data;
    output reg in;
    output reg [6:0]addr;
    output reg [3:0]endp;
    output reg err;
    reg error;
    output reg [7:0]pid;
    wire [4:0]sum_crc;
    reg [4:0]crc2;
    reg [4:0]crc1;
    reg [4:0]i;
    reg [4:0] crcBASE = 15'b0;

CRC5_D11 CRC5_D11_intance (
 .Data (data[15:5]),
 .crc  (crcBASE), 
 .nextCRC5_D11 (sum_crc)
 	);

always @ (*) 
begin
error = 0 ; 


	crc1[4:0] = data[4:0];

if (crc1 != sum_crc )
 	begin
		error =1;
	end
	
    pid[7:0] = data[23:16];
    addr[6:0] = data[15:9];
    endp[3:0]  = data[8:5];
    
    
   
end 

endmodule 
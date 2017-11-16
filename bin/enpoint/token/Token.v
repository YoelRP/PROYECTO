`include "Defintions.v" 
module token_in(
	data,
    in,
    addr,
    endp,
    err
	);
 	input wire [23:0]data;
    output reg in;
    output reg [6:0]addr;
    output reg [3:0]endp;
    output reg err;
    reg eroare;
    reg iesire;
    reg [7:0]pid;
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
eroare = 0 ; 


	crc1[4:0] = data[4:0];

if (crc1 != sum_crc )
 	begin
		eroare =1;
	end
	
pid[7:0] = data[23:16];
    if (pid == 8'b00011110)
	begin
	    iesire =0 ; //s-a gasit out
	end
    if (pid == 8'b10010110)

    begin
	    iesire =1; //s-a gasit in
	end
	
	err =eroare;
    in  = iesire;
    endp[3:0]  = data[8:5];
    addr[6:0] = data[15:9];
    
   
end 

endmodule 
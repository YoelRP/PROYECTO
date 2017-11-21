`include "Defintions.v" 

module Data0_pack(
	packet , 
	data ,
	data_error
		);

// entrada de dos solo contiene los valores 
    input wire [1047:0]packet;
    output reg  [1023:0] data;
    output reg data_error; 
   // reg [10:0]i;
    wire [15:0]crc;
    reg [15:0]crc_initial;

    CRC16_D1024 CRC16_D1024_intance (
 .Data (packet[1039:16]),
 .crc  (crc_initial), 
 .nextCRC16_D1024 (crc)
 	);

always @ (*) 
begin
data_error = 1'b1 ;
crc_initial = 15'b0;

if (data[1047:1040] != 8'b00111100 & crc != packet[15:0]) 
begin
data_error = 1'b0;
end



data [1023:0] =packet[1039:16] ;




end
endmodule

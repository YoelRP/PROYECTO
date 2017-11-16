`include "Defintions.v" 

module Data_pack(
	data , 
	packet
	);

// entrada de dos solo contiene los valores 
	input wire [1023:0]data;
    output reg [1047:0]packet;

   // reg [10:0]i;
    wire [15:0]crc;
    reg [15:0]crc_initial;

    CRC16_D1024 CRC16_D1024_intance (
 .Data (data),
 .crc  (crc_initial), 
 .nextCRC16_D1024 (crc)
 	);

always @ (*) 
begin
packet[1047:1040] = 8'b00111100 ;


packet[1039:16] = data [1023:0];

crc_initial = 15'b0;

packet[15:0]=crc[15:0];


end
endmodule

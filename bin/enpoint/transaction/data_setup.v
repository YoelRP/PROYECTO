//`include "Defintions.v"
`include "CRC16_D64.v" 

module Data_set_up_pack(
	packet , 
	data ,
	data_error
		);

// entrada de dos solo contiene los valores 
    input wire [88:0]packet;
    output reg  [63:0] data;
    output reg data_error; 
   
    wire [15:0]crc;
    reg [15:0]crc_initial;

    CRC16_D64 CRC16_D64_intance (
 .Data (packet[79:16]),
 .crc  (crc_initial), 
 .nextCRC16_D64 (crc)
 	);

always @ (*) 
begin
data_error = 1'b1 ;
crc_initial = 15'b0;

if (data[88:80] != 8'b00111100 & crc != packet[15:0]) 
begin
data_error = 1'b0;
end


data [63:0] =packet[79:16] ;





end
endmodule

//`include "Defintions.v" 

module Data_set_up_pack(
	packet , 
	data ,
	data_error
		);

// entrada de dos solo contiene los valores 
    input wire [95:0]packet;
    output reg  [71:0] data;
    output reg data_error; 
   
    wire [15:0]crc;
    reg [15:0]crc_initial;

    CRC16_D72 CRC16_D72_intance (
 .Data (packet[87:16]),
 .crc  (crc_initial), 
 .nextCRC16_D72 (crc)
 	);

always @ (*) 
begin
data_error = 1'b1 ;
crc_initial = 15'b0;

if (data[95:88] != 8'b00111100 & crc != packet[15:0]) 
begin
data_error = 1'b0;
end


data [72:0] =packet[87:16] ;





end
endmodule

`include "Defintions.v" 


module handshacke(
	ack , 
	pid
	);


input wire ack ;
output reg [7:0] pid;
reg [7:0] data;
always @ (*) 
begin
//si tenemos un ack en el handshacke tenemos 
	if(ack) 
	    data = 8'b00101101 ;//{Handshake_ACK,!Handshake_ACK};
	else
	    data = 8'b10100101 ;//{Handshake_NAK,!Handshake_NAK};
    
    pid[7:0] = data[7:0];
    
end 

endmodule 
`include "Defintions.v" 
module (
	ack , 
	pid
	)
input ack 
output [7:0] pid;
reg [7:0] data;

begin
	if(ack)
	    data = {Handshake_ACK,!Handshake_ACK };
	else
	    data = {Handshake_NAK,!Handshake_NAK};
   
     pid[7:0] = data[7:0];
     end
//PROYECTO ELECTRICO 
//Autor : Jose Johel Rodriguez Pineda 
//DbC maquina de estados 
// 
`include "Defintions.v" 
//`timescale 1ns / 1ps
//------------------------------------------------


module DbCPortStatMachine
( 
input wire clock ,
input wire DCI   ,
input wire CSC   ,
input wire PLC   ,
input wire PRC   ,
input wire DCE   , 
input wire PED   ,
input wire CEC  
);
reg [4:0] state;


always @ (posedge clock)
begin 
if (DCE == 1'b0) begin
  state = `DBC_OFF; // move to DBC_OFF state 
  end 	

end
endmodule
 /*else
case(state)
   `DBC_OFF : if (DCE == 1'b1) begin
                state = `DBC_DISCONNECTED;
             end
   `DBC_DISCONNECTED : if (DCE == 1'b0) begin
   						state = `DBC_OFF;
					end else if (CSC == 1'b1) begin
                		state = `DBC_ENABLED;
            		     end else 
            		    state = `DBC_DISCONNECTED; 
      default : state = `DBC_OFF;
  endcase
end*/

/*`define DBC_DISABLED 5'b11000	
`define DBC_OFF   5'b00000	
`define DBC_DISCONNECTED   5'b10000	
`define DBC_ERROR  5'b11000	
`define DBC_RESETTING   5'b11010	
`define DBC_CONFIURED   5'b11101	
*/
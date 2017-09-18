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
input wire CEC   ,
input wire Reset_rcvd,
input wire set_config_succesful,
input wire EnumError,
input wire Deconfigure  
);
reg [4:0] state;


always @ (posedge clock)
begin 
if (DCE == 1'b0) begin
  state = `DBC_OFF; 
end else
	case(state)
		`DBC_OFF 		 : if (DCE == 1'b1) begin
			                state = `DBC_DISCONNECTED;
			             end else begin 
                		state = `DBC_OFF;
                		end 
	    
	    `DBC_DISCONNECTED : if (DCE == 1'b0) begin
   						state = `DBC_OFF;
					end else if (CSC == 1'b1) begin
                		state = `DBC_ENABLED;
            		     end else begin
            		    state = `DBC_DISCONNECTED;  
            		    	 end 

        `DBC_DISABLED     : if (DCE == 1'b0) begin
   						state = `DBC_OFF;
   						end else if (CSC == 1'b1) begin
                		state = `DBC_DISCONNECTED;
                		end else if (PED == 1'b1) begin
                		state = `DBC_ENABLED;
                		 end else begin
            		    state = `DBC_DISABLED;  
            		    	 end 


        `DBC_ENABLED 	 : 	 if (DCE == 1'b0) begin
   						state = `DBC_OFF;
   						end else if (CSC == 1'b1) begin
                		state = `DBC_DISCONNECTED;
                		end else if (PED == 1'b0) begin
                		state = `DBC_DISABLED;
   						end else if (CEC == 1'b1 || PLC == 1'b1) begin
                		state = `DBC_DISABLED;
                		end else if (EnumError == 1'b1) begin
                		state = `DBC_ERROR;
                		end else if (Reset_rcvd == 1'b1) begin
                		state = `DBC_RESETTING;
                		end else if (set_config_succesful == 1'b1) begin
                		state = `DBC_CONFIURED;
                		end else begin 
                		state = `DBC_ENABLED;
                		end 
        
        `DBC_RESETTING 	 : 	 if (DCE == 1'b0) begin
   						state = `DBC_OFF;
   						end else if (CSC == 1'b1) begin
                		state = `DBC_DISCONNECTED;
                		end else if (PED == 1'b0) begin
                		state = `DBC_DISABLED;
                		end else if (PRC == 1'b1) begin
                		state = `DBC_ENABLED;
                		end  else begin 
                		state = `DBC_OFF;
                		end 
        
        `DBC_ERROR 		 :	 if (DCE == 1'b0) begin
   						state = `DBC_OFF;
   						end else if (CSC == 1'b1) begin
                		state = `DBC_DISCONNECTED;
                		end else if (PED == 1'b0) begin
                		state = `DBC_DISABLED;
                		end else if (Reset_rcvd == 1'b1) begin
                		state = `DBC_RESETTING;
                		end else begin 
                		state = `DBC_ERROR;
                		end  
        `DBC_CONFIURED   : if (DCE == 1'b0) begin
   						state = `DBC_OFF;
   						end else if (CSC == 1'b1) begin
                		state = `DBC_DISCONNECTED;
                		end else if (PED == 1'b0) begin
                		state = `DBC_DISABLED;
                		end else if (Reset_rcvd == 1'b1) begin
                		state = `DBC_RESETTING;
                		end else if (Deconfigure == 1'b1) begin
                		state = `DBC_ENABLED;
                		end else begin 
                		state = `DBC_CONFIURED; 
                		end


      default : state = `DBC_OFF;          
	endcase             
end
endmodule

/*`define DBC_DISABLED 5'b11000	
`define DBC_OFF   5'b00000	
`define DBC_DISCONNECTED   5'b10000	
`define DBC_ERROR  5'b11000	
`define DBC_RESETTING   5'b11010	
`define DBC_CONFIURED   5'b11101	
*/
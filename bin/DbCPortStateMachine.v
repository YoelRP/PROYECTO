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
reg [3:0] estado;

/*
always @ (posedge clock)
begin :
next_state = 4'b0000;
case(state)
   IDLE : if (req_0 == 1'b1) begin
                next_state = GNT0;
              end else if (req_1 == 1'b1) begin
                next_state= GNT1;
              end else begin
                next_state = IDLE;
              end
   GNT0 : if (req_0 == 1'b1) begin
                next_state = GNT0;
              end else begin
                next_state = IDLE;
              end
   GNT1 : if (req_1 == 1'b1) begin
                next_state = GNT1;
              end else begin
                next_state = IDLE;
              end
   default : next_state = IDLE;
  endcase*/
endmodule

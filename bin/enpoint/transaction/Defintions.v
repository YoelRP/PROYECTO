//`timescale 1ns / 1ps
`ifndef DEFINTIONS_V
`define DEFINTIONS_V

//states 
`define	IDLE 4'b0001
`define	RECEIVE 4'b0010
`define	STATE 4'b0011
`define	TOKEN 4'b0100
`define	DATA 4'b0101
`define	HANDSHAKE 4'b0110
`define	SETUP_TOKEN 4'b0111
`define	OUT_TOKEN 4'b1000 
`define	IN_TOKEN 4'b1001 
`define	ACK_TOKEN 4'b1010 

//tokens tipes 
`define Token_OUT 4’b0001
`define Token_IN 4’b1001
`define Token_SOF 4’b0101
`define Token_SETUP 4’b1101
`define Data_DATA0 4’b0011
`define Data_DATA1 4’b1011
`define Data_DATA2 4’b0111
`define Data_MDATA 4’b1111
`define Handshake_ACK 4’b0010
`define Handshake_NAK 4’b1010
`define Handshake_STALL 4’b1110
`define Handshake_NYET 4’b0110
`define Special_PRE 4’b1100
`define Special_ERR 4’b1100
`define Special_SPLIT 4’b1000
`define Special_PING 4’b0100
`define Special_Reserved 4’b0000


`endif
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
input wire CSC   
);
reg [4:0]   rResult;



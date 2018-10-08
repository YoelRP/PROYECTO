module control (
busy,
clk,
rst,
data, 
data_out64,
data_out32,
data_out16,
parameter_Block32,
parameter_Block64,
debug_Unit_ID,
interface_ID,
local,
global,
wget_optmode,
wset_optmode,
specific,
enable
);
input wire  enable;
input wire  clk;
input wire rst;
input wire [63:0] data;

input wire [31:0] wget_optmode;
//Son los bloques de entradas que se usan en diferentes gfunciones 
input wire [15:0] parameter_Block16;
input wire [31:0] parameter_Block32;
input wire [63:0] parameter_Block64;

//Existen varios tamaños de salida estos deben ser enviados en datos seriales por eso es que 
//a este nivel se cambia 
output reg [31:0] data_out32;
output reg [63:0] data_out64;
output reg [15:0] data_out16; 

//la direccion se guarda en adress 
output reg [63:0] address;
//
output reg [63:0] buffer_command;
output reg [7:0] bRequest ;
output reg [31:0] wset_optmode;
output reg [15:0] config_trace;

//sin banderas que explican a quien se esta enviado los datos  
output reg local;
output reg global; 
output reg specific; 
output reg busy;
//cuando no afecta a toda la configuracion se usan la interface o al debug unit especico a la cual se dirige elcomando 
output reg [7:0] debug_Unit_ID;
output reg [7:0]  interface_ID;
//output reg [8:0] rSelect;output reg busy;
//envia el reset a un endpoint 

output reg reset_endpoint;
//

reg [15:0] error_reg;
reg [7:0] bmRequestType ;
reg [15:0] count; 

reg [15:0] wValue;
reg [15:0] wIndex;
reg [15:0] wLength;
reg [31:0] addresstemp1;
reg [31:0] addresstemp2;
reg [31:0] datotemp1;
reg [31:0] datotemp2;
reg singl_data; 
reg [31:0] config_data; 

reg [63:0]	tempoadress;
reg [31:0] dato;


reg [4:0]state,next_state;
parameter [4:0]
	IDLE = 5'b00001,
	RECEIVE = 5'b00010,
	SET_CONFIG_DATA_SINGLE = 5'b00110,
	SET_ALT_STACK = 5'b00111,
	SET_OPERATING_MODE = 5'b01000,
	SET_TRACE = 5'b01001,
	SET_BUFFER = 5'b01010,
	SET_RESET = 5'b01011,
	GET_CONFIG_DATA = 5'b01100,
	GET_CONFIG_SINGLE = 5'b01101,
	GET_CONFIG_ADDRESS = 5'b01110,
	GET_ALT_STACK = 5'b01111,		
	GET_OPERATION_MODE = 5'b10000,		
	GET_TRACE = 5'b10001,	

	GET_INFO = 5'b10010,
	SET_CONFIG_DATA = 5'b10011 ,
	SET_CONFIG_ADDRESS = 5'b10100,			
	GET_ERROR = 5'b10101,		
	GET_BUFFER =  5'b10110;	




always @(posedge clk)
begin 
 if (enable !=1) begin  #1 state =  state;  end
    else  
	    begin  if (rst) begin  #1 state =  IDLE;  end
	    else   begin #1 state =  next_state;  end
	end
	if (busy == 1)
	begin
		error_reg =15'b1;
	end
	else 
	begin
		error_reg = 0;
	end
end	


always @(posedge clk)
begin
/*
					bit support_capability
					0  set_config data single
					1  set config data
					2  get config data
					3  set config address 
					4  get config address
					5  set alt stack
					6  get alt stack
					7  set operating mode 
					8  get operating mode 
					9  set trace configuration
					10 get trace configuration 
					11 set buffer 
					12 get buffer
					13 set reset 
					14-28 reseved set = 0
					29 disable automatic mode
					30 self generate control
					31 slow control
					*/
config_data = 31'b10000110011111;

	case (state)
		IDLE : 
			begin
			    bmRequestType =  data [63:56];
				bRequest =  data [56:47];
				wValue =  data [46:33];
				wIndex =  data [32:16];
				wLength =  data [15:0];
				singl_data = 0; 
				busy = 0;
				next_state = RECEIVE;
				 reset_endpoint = 0;
				 
			end
		RECEIVE :  
			begin
				if (bRequest == 8'h01  && bmRequestType == 8'b00100001)//Set_config_data
					begin
					next_state = SET_CONFIG_DATA ;
					end 
									 
				if (bRequest == 8'h02  && bmRequestType == 8'b00100001)//set_config_data_single
					begin
					next_state = SET_CONFIG_DATA_SINGLE;

					end
				if (bRequest == 8'h03  && bmRequestType == 8'b00100001 )//set_config_address
					begin
					next_state = SET_CONFIG_ADDRESS;
					end
				if (bRequest == 8'h04  && bmRequestType == 8'b00100001 )//set_alt_stack
					begin
					next_state = SET_ALT_STACK;
					end
				if (bRequest == 8'h05  && bmRequestType == 8'b00100001 )//set_operating_mode
					begin
					// this is for allow the trace ,dfx,ect modes 
					next_state = SET_OPERATING_MODE;
					end
				if (bRequest == 8'h06  && bmRequestType == 8'b00100001)//set_trace
					begin
					next_state = SET_TRACE ;
					// this is for allow the trace ,dfx,ect modes 
					end
				if (bRequest == 8'h09  && bmRequestType == 8'b00100001 )//set_buffer
					begin
					next_state = SET_BUFFER ;
					end
				if (bRequest == 8'h0A  && bmRequestType == 8'b00100001 )//set_rest 
					begin
					next_state = SET_RESET;
					end
							if (bRequest == 8'h81 && bmRequestType == 8'b10100001) //get_config data
					begin
					next_state = GET_CONFIG_DATA;
					end
				if (bRequest == 8'h82 && bmRequestType == 8'b10100001) //get_config data single 
					begin
					next_state = GET_CONFIG_SINGLE;
					end
				if (bRequest == 8'h83 && bmRequestType == 8'hA1) // get_config address 
					begin
					next_state = GET_CONFIG_ADDRESS;
					end
				if (bRequest == 8'h84 && bmRequestType == 8'b10100001) // get_alt stack
					begin
					next_state = GET_ALT_STACK;
					end
				if (bRequest == 8'h85 && bmRequestType == 8'b10100001) //get oprating mode
					begin
					next_state = GET_OPERATION_MODE;
					end
				if (bRequest == 8'h86 && bmRequestType == 8'b10100001) //get_trace 
					begin
					//this is no able 
					next_state = GET_TRACE;
					end
				if (bRequest == 8'h87 && bmRequestType == 8'b10100001) //get_INFO
					begin
					
					next_state = GET_INFO ; 
					end

				if (bRequest == 8'h88  && bmRequestType == 8'b10100001) //get_error
					begin
					/*0x00: No error
					0x01: Not ready
					0x02: Wrong state
					0x03: Insufficient Power Available
					0x04: Max Power Violation
					0x05: Operating-mode unavailable
					0x06: Out of range
					0x07: Invalid unit
					0x08: Invalid control
					0x09: Invalid Request
					0x0A: Permission denied
					0x0B-0xFE: reserved
					0xFF: Unknown*/

					next_state = GET_ERROR  ;
					end
				if (bRequest == 8'h89  && bmRequestType == 8'b10100001) //get_buffer
					begin

					next_state = GET_BUFFER ;
					end

			end

			SET_CONFIG_DATA_SINGLE :
			begin
		 	busy = 1;	
			 /*	if (enable) 
			 	begin*/
					if (wIndex[15:8] == 0)
					begin
						if (wValue[7:0] == 8'h00 ) // global DBclass
						begin
						global = 1 ;
						debug_Unit_ID = wIndex[15:8] ;
							interface_ID = wIndex[7:0] ;
						if (singl_data == 0 )
							begin
								count =8;
								singl_data = 1 ; 
							next_state = SET_CONFIG_DATA_SINGLE;	
							end 
						else 
							begin 	
								if (count > 0 )
								begin
									if (count == 8)
									begin
									addresstemp1 = parameter_Block32;
									next_state = SET_CONFIG_DATA_SINGLE;
									end
									if (count == 7)
									begin
									addresstemp2 = parameter_Block32;
									next_state = SET_CONFIG_DATA_SINGLE;
									end 
									if (count == 2)
									begin
									datotemp1 = parameter_Block32;
									next_state = SET_CONFIG_DATA_SINGLE;
									end 
									if (count == 1)
									begin
									datotemp2 = parameter_Block32;
									next_state = SET_CONFIG_DATA_SINGLE;
									end
									count = count -1 ;

								end 
								else next_state = IDLE;

									if (count == 0)
									begin
									address = {addresstemp1,addresstemp2};
									 data_out64 = {datotemp1,datotemp2};
									//singl_data = 0 ; 
									next_state = IDLE;
									end 	
						end

						end 
						if (wValue[7:0] == 8'h01 ) // global vendor
						begin
							//Si lector este tamaño lo define usted 
							global = 1 ;
							next_state = IDLE;
							debug_Unit_ID = wIndex[15:8] ;
							interface_ID = wIndex[7:0] ;
						end 
						if (wValue[7:0] == 8'h02 ) // local DBclass
						begin
							local = 1 ;
							if (singl_data == 0 )
							begin
								count =8;
								singl_data = 1 ; 
							next_state = SET_CONFIG_DATA_SINGLE;	
							end 
						else 
							begin 	
								if (count > 0 )
								begin
									if (count == 8)
									begin
									addresstemp1 = parameter_Block32;
									next_state = SET_CONFIG_DATA_SINGLE;
									end
									if (count == 7)
									begin
									addresstemp2 = parameter_Block32;
									next_state = SET_CONFIG_DATA_SINGLE;
									end 
									if (count == 2)
									begin
									datotemp1 = parameter_Block32;
									next_state = SET_CONFIG_DATA_SINGLE;
									end 
									if (count == 1)
									begin
									datotemp2 = parameter_Block32;
									next_state = SET_CONFIG_DATA_SINGLE;
									end
									count = count -1 ;
								end else 
								begin
								 address = {addresstemp1,addresstemp2};
								 data_out64 = {datotemp1,datotemp2};
								singl_data = 0 ; 
								next_state = IDLE;

								end  	
						end
						//ask for inter face 
						end 
						if (wValue[7:0] == 8'h03 ) // local vendor
						begin
						next_state = IDLE;
							//ask for inter face 
							//Si lector este tamaño lo define usted
							//this is the espace to selec your own
							local = 1 ;
						end
					end 
					if (wIndex[15:8] != 0)
					begin
						if (wValue[7:0] == 8'h00 )// specific DBclass
						begin
							specific = 1 ;
							debug_Unit_ID = wIndex[15:8] ;
							interface_ID = wIndex[7:0] ;
							if (singl_data == 0 )
								begin
									count =8;
									singl_data = 1 ; 
								next_state = SET_CONFIG_DATA_SINGLE;	
								end 
							else 
								begin 	
									if (count > 0 )
									begin
										if (count == 8)
										begin
										addresstemp1 = parameter_Block32;
										next_state = SET_CONFIG_DATA_SINGLE;
										end
										if (count == 7)
										begin
										addresstemp2 = parameter_Block32;
										next_state = SET_CONFIG_DATA_SINGLE;
										end 
										if (count == 2)
										begin
										datotemp1 = parameter_Block32;
										next_state = SET_CONFIG_DATA_SINGLE;
										end 
										if (count == 1)
										begin
										datotemp2 = parameter_Block32;
										next_state = SET_CONFIG_DATA_SINGLE;
										end
										count = count -1 ;
									end else 
									begin
									 address = {addresstemp1,addresstemp2};
									 data_out64 = {datotemp1,datotemp2};
									singl_data = 0 ; 
									next_state = IDLE;

									end  	
							end
						end
						if (wValue[7:0] == 8'h01 ) // specific vendor
						begin
						//Si lector este tamaño lo define usted 
						debug_Unit_ID = wIndex[15:8] ;
						interface_ID = wIndex[7:0] ;
						specific = 1 ;
						next_state = IDLE;
						end 
					end
				//end
			end 
				SET_CONFIG_DATA :
				begin
				busy = 1;
				debug_Unit_ID = wIndex[15:8] ;
				interface_ID = wIndex[7:0] ;
				if (enable) 
				begin	
					if (wIndex[15:8] == 0)
					begin
						if (wValue[7:0] == 8'h00 ) // global DBclass
						begin
							global = 1 ;
							if (singl_data == 0 )
							begin
							count = wLength + 1 ;
							singl_data = 1 ; 
							tempoadress = address;
							next_state = SET_CONFIG_DATA;
							end 	
						
							if (count > 0 )
							begin
								dato = parameter_Block32;
								count = count -1 ; 	 
								address = address +1;
								next_state = SET_CONFIG_DATA ;
							end
							else 
								begin  
									address =  tempoadress; 
									singl_data = 0 ;
									next_state = IDLE ; 
								end
						end	
						if (wValue[7:0] == 8'h01 ) // global vendor
							begin
								//Si lector este tamaño lo define usted 
								global = 1 ;
							end 
							if (wValue[7:0] == 8'h02 ) // local DBclass
							begin
								local = 1 ;
								if (singl_data == 0 )
								begin
									count = wLength + 1 ;
									singl_data = 1 ;
									tempoadress = address; 
								end 	
								
								if (count > 0 )
								begin
									dato = parameter_Block32;
									count = count -1 ; 	 

								address = address +1;
									next_state = SET_CONFIG_DATA ;
								end
								else 
								begin  
									address =  tempoadress; 
									singl_data = 0 ;
									next_state = IDLE ; 
								end
							end
							if (wValue[7:0] == 8'h03 ) // local vendor
							begin
								//ask for inter face 
								//Si lector este tamaño lo define usted
								//this is the espace to selec your own
								local = 1 ;
							end
					end
					if (wIndex[15:8] != 0)
					begin
						if (wValue[7:0] == 8'h00 )// specific DBclass
						begin
							specific = 1 ;
							debug_Unit_ID = wIndex[15:8] ;
							interface_ID = wIndex[7:0] ;
							if (singl_data == 0 )
								begin
									count = wLength + 1 ;
									singl_data = 1 ; 
										tempoadress = address; 
										next_state = SET_CONFIG_DATA;
								end 	
								
							if (count > 0 )
								begin
									dato = parameter_Block32;
									count = count -1 ; 	 
									address = address +1;
									next_state = SET_CONFIG_DATA ;
								end
								else 
								begin  
								 	singl_data = 0 ;
								 	address =  tempoadress; 
									next_state = IDLE ; 
								end
						end 
						if (wValue[7:0] == 8'h01 ) // specific vendor
						begin
							//Si lector este tamaño lo define usted 
							//yes reader this is your espace 
							debug_Unit_ID = wIndex[15:8] ;
							interface_ID = wIndex[7:0] ;
							specific = 1 ;

							next_state = IDLE ; 
						end
					end	
				end	
			end
			SET_CONFIG_ADDRESS:
			begin
			busy = 1;	
			debug_Unit_ID = wIndex[15:8] ;
			interface_ID = wIndex[7:0] ;
				if (enable) 
				begin
					if (wIndex[15:8] == 0)
						begin
							if (wValue[7:0] == 8'h00 ) // global DBclass
							begin
								global = 1 ;
								address =parameter_Block64;
							end
							if (wValue[7:0] == 8'h01 ) // global vendor
							begin
							//Si lector este tamaño lo define usted 
							global = 1 ;
							end 
							if (wValue[7:0] == 8'h02 ) // local DBclass
							begin
								local = 1 ;
								address = parameter_Block64;
										
							end 
							if (wValue[7:0] == 8'h03 ) // local vendor
							begin
								//ask for inter face 
								//Si lector este tamaño lo define usted
								//this is the espace to selec your own
								local = 1 ;
							end
						end
						if (wIndex[15:8] != 0)
						begin
							if (wValue[7:0] == 8'h00 )// specific DBclass
							begin
								specific = 1 ;
								debug_Unit_ID = wIndex[15:8] ;
								interface_ID = wIndex[7:0] ;
								address = parameter_Block64;
							end 
							if (wValue[7:0] == 8'h01 ) // specific vendor
							begin
								//Si lector este tamaño lo define usted 
								//yes reader this is your espace 
								debug_Unit_ID = wIndex[15:8] ;
								interface_ID = wIndex[7:0] ;
								specific = 1 ;
							end
						end	
						next_state = IDLE;
				end
			end

			SET_ALT_STACK :
			begin
			busy = 1;	
			debug_Unit_ID = wIndex[15:8] ;
			interface_ID = wIndex[7:0] ;
			//this is difine by the vendor 
			next_state = IDLE;
			
			end
			SET_OPERATING_MODE :
			begin
			debug_Unit_ID = wIndex[15:8] ;
		 	interface_ID = wIndex[7:0] ;
			busy = 1;	
				if (enable) 
				begin
				
						//this is used to actived  the Trace, Dfx, or GP
						begin
					if (wIndex[15:8] == 0)
						begin
							if (wValue[7:0] == 8'h00 ) // global DBclass
							begin
								global = 1 ;
								wset_optmode =parameter_Block32;  
								
							end
							
							if (wValue[7:0] == 8'h02 ) // local DBclass
							begin
								local = 1 ;
								wset_optmode =parameter_Block32;
								
							end 
						
						end
						if (wIndex[15:8] != 0)
						begin
							if (wValue[7:0] == 8'h00 )// specific DBclass
							begin
								specific = 1 ;
								debug_Unit_ID = wIndex[15:8] ;
								interface_ID = wIndex[7:0] ;
								wset_optmode =parameter_Block32;    
							end 
							
						end		
						next_state = IDLE;
				
					end
				end
			end
			SET_TRACE :
			begin
			busy = 1;
			next_state = IDLE;
			if (enable) 
			begin	
				if (wIndex[15:8] == 0)
					begin 
						//lo unico que hace es poner el valor en config_trace que ees el valor que se va a envia al trace 
							config_trace[15:0] = wIndex[15:0];
						
						
					end	
			end		

			
			end
			SET_BUFFER :
			begin
				busy = 1;
				next_state = IDLE;
			debug_Unit_ID = wIndex[15:8] ;
			interface_ID = wIndex[7:0] ;
			
				if (enable) 
				begin	
				if (wIndex[15:8] == 0)
					begin
						if (wValue[7:0] == 8'h00 ) // global DBclass
						begin
							global = 1 ;
							buffer_command =parameter_Block64;  
							
						end
						
						if (wValue[7:0] == 8'h02 ) // local DBclass
						begin
							local = 1 ;
							buffer_command =parameter_Block64;
							
						end 
					
					end
					if (wIndex[15:8] != 0)
					begin
						if (wValue[7:0] == 8'h00 )// specific DBclass
						begin
							specific = 1 ;
							debug_Unit_ID = wIndex[15:8] ;
							interface_ID = wIndex[7:0] ;
							buffer_command =parameter_Block64;
							

						end 
						
					end
			end


			end
			GET_BUFFER :
			begin
			busy = 1;
			next_state = IDLE;
			debug_Unit_ID = wIndex[15:8] ;
			interface_ID = wIndex[7:0] ;
			
			if (enable) 
			begin	
				if (wIndex[15:8] == 0)
					begin
						if (wValue[7:0] == 8'h00 ) // global DBclass
						begin
							global = 1 ;
							data_out32 =parameter_Block32;  
							
						end
						
						if (wValue[7:0] == 8'h02 ) // local DBclass
						begin
							local = 1 ;
							data_out32 =parameter_Block32;
							
						end 
					
					end
					if (wIndex[15:8] != 0)
					begin
						if (wValue[7:0] == 8'h00 )// specific DBclass
						begin
							specific = 1 ;
							debug_Unit_ID = wIndex[15:8] ;
							interface_ID = wIndex[7:0] ;
							data_out32 =parameter_Block32;
							

						end 
						
					end
			end		


			end
			SET_RESET :
			begin
			debug_Unit_ID = wIndex[15:8] ;
			interface_ID = wIndex[7:0] ;
			next_state = IDLE;
				if (enable) 
				begin
					busy = 1;
					if (wIndex[15:8] == 0)
						begin
							if (wValue[7:0] == 8'h00 ) // global DBclass
							begin
								global = 1 ;
								
								reset_endpoint = 1 ;
							end
							
							if (wValue[7:0] == 8'h02 ) // local DBclass
							begin
								local = 1 ;
									reset_endpoint = 1 ;
							end 
						
						end
						if (wIndex[15:8] != 0)
						begin
							if (wValue[7:0] == 8'h00 )// specific DBclass
							begin
								specific = 1 ;
								debug_Unit_ID = wIndex[15:8] ;
								interface_ID = wIndex[7:0] ;
									reset_endpoint = 1 ;

							end 
							
						end
				end		
			end
			GET_CONFIG_DATA:
			begin
			busy = 1;
			debug_Unit_ID = wIndex[15:8] ;
			interface_ID = wIndex[7:0] ;
			
				if (enable) 
				begin	
					if (wIndex[15:8] == 0)
					begin
						if (wValue[7:0] == 8'h00 ) // global DBclass
						begin

							global = 1 ;
							if (singl_data == 0 )
							begin
							tempoadress = address ;
							count = wLength + 1 ;
							singl_data = 1 ; 
							end 	
						
							if (count >= 0 )
							begin
								dato = parameter_Block32;
								count = count -1 ; 	 
								next_state = GET_CONFIG_DATA ;
							end 
						end	
						if (wValue[7:0] == 8'h01 ) // global vendor
							begin
								//Si lector este tamaño lo define usted 
								global = 1 ;
							end 
							if (wValue[7:0] == 8'h02 ) // local DBclass
							begin
								local = 1 ;
								if (singl_data == 0 )
								begin
									count = wLength + 1 ;
									singl_data = 1 ; 
								end 	
								
								if (count >= 0 )
								begin
									dato = parameter_Block32;
									count = count -1 ; 	 
									next_state = GET_CONFIG_DATA ;
								end
								else 
								begin  
									 	singl_data = 0 ;
										next_state = IDLE ; 
								end
							end
							if (wValue[7:0] == 8'h03 ) // local vendor
							begin
								//ask for inter face 
								//Si lector este tamaño lo define usted
								//this is the espace to selec your own
								local = 1 ;
							end
					end
					if (wIndex[15:8] != 0)
					begin
						if (wValue[7:0] == 8'h00 )// specific DBclass
						begin
							specific = 1 ;
							debug_Unit_ID = wIndex[15:8] ;
							interface_ID = wIndex[7:0] ;
							if (singl_data == 0 )
								begin
									count = wLength + 1 ;
									singl_data = 1 ; 
								end 	
								
							if (count >= 0 )
								begin
									dato = parameter_Block32;
									count = count -1 ; 	 
									next_state = GET_CONFIG_DATA ;
								end
								else 
								begin  
								 	singl_data = 0 ;
									next_state = IDLE ; 
								end
						end 
						if (wValue[7:0] == 8'h01 ) // specific vendor
						begin
							//Si lector este tamaño lo define usted 
							//yes reader this is your espace 
							debug_Unit_ID = wIndex[15:8] ;
							interface_ID = wIndex[7:0] ;
							specific = 1 ;
						end
					end	
				end	
			end

			GET_CONFIG_ADDRESS :
			begin
			debug_Unit_ID = wIndex[15:8] ;
			interface_ID = wIndex[7:0] ;
			next_state = IDLE;
				busy = 1;	
				if (enable) 
				begin

					if (wIndex[15:8] == 0)
						begin
							if (wValue[7:0] == 8'h00 ) // global DBclass
							begin
								global = 1 ;
								data_out64 =	 address; 	
							end
							if (wValue[7:0] == 8'h01 ) // global vendor
							begin
							//Si lector este tamaño lo define usted 
							global = 1 ;
							end 
							if (wValue[7:0] == 8'h02 ) // local DBclass
							begin
								local = 1 ;
								data_out64 =	 address; 		
							end 
							if (wValue[7:0] == 8'h03 ) // local vendor
							begin
								//ask for inter face 
								//Si lector este tamaño lo define usted
								//this is the espace to selec your own
								local = 1 ;
							end
						end
						if (wIndex[15:8] != 0)
						begin
							if (wValue[7:0] == 8'h00 )// specific DBclass
							begin
								specific = 1 ;
								debug_Unit_ID = wIndex[15:8] ;
								interface_ID = wIndex[7:0] ;
								data_out64 =	 address; 
							end 
							if (wValue[7:0] == 8'h01 ) // specific vendor
							begin
								//Si lector este tamaño lo define usted 
								//yes reader this is your espace 
								debug_Unit_ID = wIndex[15:8] ;
								interface_ID = wIndex[7:0] ;
								specific = 1 ;
								data_out64 =	 address; 
							end
						end				
				end
			end
			
			GET_ALT_STACK :
			begin
			//Get alt stack esta disponible pero no se habilito ya que no tenemos 
			//
				debug_Unit_ID = wIndex[15:8] ;
				interface_ID = wIndex[7:0] ;
				busy = 1;	
				next_state = IDLE;
				if (enable) 
				begin
					if (wIndex[15:8] == 0)
						begin
							if (wValue[7:0] == 8'h00 ) // global DBclass
							begin
								global = 1 ;
								
								
							end
							
							if (wValue[7:0] == 8'h02 ) // local DBclass
							begin
								local = 1 ;
							
								
							end 
						
						end
						if (wIndex[15:8] != 0)
						begin
							if (wValue[7:0] == 8'h00 )// specific DBclass
							begin
								specific = 1 ;
								debug_Unit_ID = wIndex[15:8] ;
								interface_ID = wIndex[7:0] ;
								

							end 
							
						end
				end		
			//this is define by the vendor 
			end
			GET_OPERATION_MODE :
			begin
				debug_Unit_ID = wIndex[15:8] ;
			interface_ID = wIndex[7:0] ;
			
				busy = 1;
				next_state = IDLE;
				if (enable) 
				begin	
				if (wIndex[15:8] == 0)
					begin
						if (wValue[7:0] == 8'h00 ) // global DBclass
						begin
							global = 1 ;
							data_out32 =wget_optmode;  
						end
						
						if (wValue[7:0] == 8'h02 ) // local DBclass
						begin
							local = 1 ;
							data_out32 =wget_optmode;  		
						end 
					
					end
					if (wIndex[15:8] != 0)
					begin
						if (wValue[7:0] == 8'h00 )// specific DBclass
						begin
							specific = 1 ;
							data_out32 = wget_optmode;    
						end 
						
					end	
				end			
			end
			/*D16, D11, D9, D7, D5, D2, D1 define whether the TS, DIC, or the Debug unit supports the
			specified operation mode
			
			D15, D10, D8, D6, D4, D0 busy/disabled the specified operation mode in the TS, DIC, or Debug
			unit. These bits are mutually exclusive. The behavior if multiple bits are busyd is undefined
			D14..D12 indicates which power source is currently used in the USB device. These bits are
			mutually exclusive. The behavior if multiple bits are busyd is undefined.
			
			The bits D14..D12 are set by the device and are usually informational. However, it is
			recommended that the TS allows the debugger to force the device to use a different power
			source, which is why these bits are designated as RW-opt (Read & Write-optional). For example,
			when debugging over USB, the device will normally be charging over the USB cable instead of
			using its internal battery. However, during a battery-consumption test, one needs to force the
			device to use its internal battery.

			D31..D17 are vendor-specific operating modes*/

			//this is used to actived  the Trace, Dfx, or GP
			
			GET_TRACE :
			begin
				busy = 1;
				next_state = IDLE;	
				if (enable) 
				begin
					if (wIndex[15:8] == 0)
					begin
															
						data_out16 =parameter_Block16;
					 
						
					end
				end	
			end
			
			GET_INFO :
			/*
					bit support_capability
					0  set_config data single
					1  set config data
					2  get config data
					3  set config address 
					4  get config address
					5  set alt stack
					6  get alt stack
					7  set operating mode 
					8  get operating mode 
					9  set trace configuration
					10 get trace configuration 
					11 set buffer 
					12 get buffer
					13 set reset 
					14-28 reseved set = 0
					29 disable automatic mode
					30 self generate control
					31 slow control

					*/
			begin
			debug_Unit_ID = wIndex[15:8] ;
			interface_ID = wIndex[7:0] ;
			
			busy = 1;
			next_state = IDLE;
			if (enable) 
			begin	
				if (wIndex[15:8] == 0)
					begin
						if (wValue[7:0] == 8'h00 ) // global DBclass
						begin
							global = 1 ;
							data_out32=	config_data;  
						end
						
						if (wValue[7:0] == 8'h02 ) // local DBclass
						begin
							local = 1 ;
							data_out32=	config_data;  		
						end 
					
					end
					if (wIndex[15:8] != 0)
					begin
						if (wValue[7:0] == 8'h00 )// specific DBclass
						begin
							specific = 1 ;
							debug_Unit_ID = wIndex[15:8] ;
							interface_ID = wIndex[7:0] ;
							data_out32=	config_data;   
						end 
						
					end		
					
				end
			end


	endcase 
end 

endmodule 
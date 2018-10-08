module control (
start,
clk,
rst,
data, 
data_out,
parameter_Block
parameter_Block2
);
input wire start;
input wire  clk;
input wire rst;
input wire [63:0] data;
input wire [31:0] parameter_Block;
input wire [63:0] parameter_Block2;
output reg [63:0]data_out;
reg [7:0] bmRequestType ;
reg [7:0] bRequest ;
reg [11:0] count; 
reg local;
reg global; 
reg specific; 
reg [7:0] debug_Unit_ID;
reg [7:0]  interface_ID;

reg [15:0] wValue;
reg [15:0] wIndex;
reg [15:0] wLength;
reg [63:0] address;
reg [63:0] dato;
reg [3:0]state,next_state;
parameter [3:0]
	IDLE = 4'b0001,
	RECEIVE = 4'b0010,
	SET = 4'b0011,
	GET = 4'b0100,
	DATA = 4'b0101,
	HANDSHAKE = 4'b0110,
	SETUP_TOKEN = 4'b0111,
	OUT_TOKEN = 4'b1000, 
	IN_TOKEN = 4'b1001,
	ACK_TOKEN = 4'b1010;




always @(posedge clk)
begin


	case (state)
		IDLE : 
			begin
				if (start== 0 ) next_state =  IDLE;
				else 
				begin
				next_state = RECEIVE;
				bmRequestType =  data [63:55];
				bRequest =  data [55:47];
				wValue =  data [48:33];
				wIndex =  data [32:16];
				wLength =  data [15:0];

				end 
			end
		RECEIVE : 
			begin
				if (bmRequestType == 8'b00100001 )
					begin
					next_state = SET;
					end
				if (bmRequestType == 8'b00100001 )
					begin 
					next_state = GET;
					end 
			end	
		SET : 
			begin
				if (bRequest == 8'h01 )//Set_config_data
					begin
					next_state = SET_CONFIG_DATA;
/*
					if (wIndex[15:8] == 0)
					begin
						if (wValue[7:0] == 8'h00 ) // global DBclass
						begin
						global = 1 ;

						ext_state = GET;
						end 
						if (wValue[7:0] == 8'h01 ) // global vendor
						begin
							//Si lector este tamaño lo define usted 
							global = 1 ;
						end 
						if (wValue[7:0] == 8'h02 ) // local DBclass
						begin
							local = 1 ;
							//ask for inter face 

						end 
						if (wValue[7:0] == 8'h03 ) // local vendor
						begin
							//ask for inter face 
							//Si lector este tamaño lo define usted
							//this is the espace to selec your own
							local = 1 ;

						end
					end 
					if (wIndex[15:8] == 0)
					begin

						if (wValue[7:0] == 8'h00 )// specific DBclass
						begin
						specific = 1 ;
						debug_Unit_ID = wIndex[15:8] ;
						interface_ID = wIndex[7:0] ;

						end 

						if (wValue[7:0] == 8'h01 ) // specific vendor
						begin
						//Si lector este tamaño lo define usted 
						debug_Unit_ID = wIndex[15:8] ;
						interface_ID = wIndex[7:0] ;
						specific = 1 ;



						end */
					end
				 

					end
				if (bRequest == 8'h02 )//set_config_data_single
					begin
					next_state = SET_CONFIG_DATA_SINGLE;

					end
				if (bRequest == 8'h03 )//set_config_address
					begin
					next_state = SET_CONFIG_ADDRESS;
					end
				if (bRequest == 8'h04 )//set_alt_stack
					begin
					next_state = SET_ALT_STACK;
					end
				if (bRequest == 8'h05 )//set_operating_mode
					begin
					// this is for allow the trace ,dfx,ect modes 
					next_state = SET_OPERATING_MODE;
					end
				if (bRequest == 8'h06 )//set_trace
					begin
					next_state = SET_TRACE ;
					// this is for allow the trace ,dfx,ect modes 
					end
				if (bRequest == 8'h09 )//set_buffer
					begin
					next_state = SET_BUFFER ;
					end
				if (bRequest == 8'h0A )//set_rest 
					begin
					next_state = SET_RESET;
					end
				end 	
		GET :
			begin
				if (bRequest == 8'h81 ) //get_config data
					begin
					next_state = GET_CONFIG;
					end
				if (bRequest == 8'h82 ) //get_config data single 
					begin
					next_state = GET_CONFIG_SINGLE;
					end
				if (bRequest == 8'h83 ) // get_config address 
					begin
					next_state = GET_CONFIG_ADDRESS;
					end
				if (bRequest == 8'h84 ) // get_alt stack
					begin
					next_state = GET_ALT_STACK;
					end
				if (bRequest == 8'h85 ) //get oprating mode
					begin
					next_state = GET_OPERATION_MODE;
					end
				if (bRequest == 8'h86 ) //get_trace 
					begin
					//this is no able 
					next_state = GET_TRACE;
					end
				if (bRequest == 8'h87 ) //get_INFO
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
					next_state = GET_INFO ; 



					end
				if (bRequest == 8'h88 ) //get_error
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

					end
				if (bRequest == 8'h89 ) //get_buffer
					begin
					end
				
			end
			SET_CONFIG_DATA_SINGLE :
			begin
			end
			SET_ALT_STACK :
			begin
			end
			SET_OPERATING_MODE :
			begin
			end
			SET_TRACE :
			begin
			end
			SET_BUFFER :
			begin
			end
			SET_RESET :
			begin
			end
			GET_CONFIG :
			begin
			end
			GET_CONFIG_SINGLE :
			begin
			end
			GET_CONFIG_ADDRESS :
			begin
			end
			GET_ALT_STACK :
			begin
			end
			GET_OPERATION_MODE :
			begin
			end
			GET_TRACE :
			begin
			end
			GET_INFO :
			begin
			end



	endcase 
end 

endmodule 
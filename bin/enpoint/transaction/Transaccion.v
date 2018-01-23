`include "Defintions.v" 
`include "Token.v" 
`include "data_setup.v" 
//este modulo es concido como targetsystem 
module TS (
sync,
sync2,
clk,
rst,
data, 
token,
busy,
data_out,
setup_data,
token_out,
 
);
input wire  busy;
input wire  clk;
input wire rst;
input wire [88:0] setup_data;
input wire [1047:0]data; 
input wire [23:0] token;
input wire [31:0]sync2;
input wire [7:0] sync;

output reg [1047:0]data_out;
output reg [7:0]token_out;

reg dato_par ; 
reg [1:0] speed ; // the states  00 low 01 full 10 super high speed 
reg [7:0] alt_USB_Stack ; 
reg [31:0] halted_enpoints_in;
reg [31:0] halted_enpoints_out;
reg [31:0] funcion_enpoints_in;
reg [31:0] funcion_enpoints_out;
reg [63:0] dato_atual ;
reg [4:0]state,next_state;
reg [6:0]addr;	
reg [3:0]endp;
reg error; 
reg DATA_error;
reg token_vald;
reg [6:0]Myaddr ;
reg startControl;
reg [3:0] last_token ;
wire [7:0]pid1;
wire [6:0]addr1;
wire [3:0]endp1;
wire err1;
wire [63:0] data1 ;
wire data_error; 
reg extra_data_setup;


reg temp123;
//estos son los estados y los valores valios de token no se trabajo con l
//los esperciales 

parameter [3:0]
	IDLE = 5'b00001,
	RECEIVE = 5'b00010,
	STATE = 5'b00011,
	TOKEN = 5'b00100,
	DATA = 5'b00101,
	ACK_TOKEN = 5'b00110,
	SETUP_TOKEN = 5'b00111,
	OUT_TOKEN = 5'b01000, 
	IN_TOKEN = 5'b01001,
	 
	DATA_IN = 5'b01011, 
	DATA_OUT = 5'b01100, 
	STALL = 5'b01101, 
	NACK_TOKEN =  5'b01111,  

	Token_OUT = 4'b0001,
    Token_IN = 4'b1001,
    Token_SOF = 4'b0101,
    Token_SETUP = 4'b1101,
    Data_DATA0 = 4'b0011,
    Data_DATA1 = 4'b1011,
    Data_DATA2 = 4'b0111,
    Data_MDATA = 4'b1111,
    Handshake_ACK = 4'b0010,
    Handshake_NAK = 4'b1010,
    Handshake_STALL = 4'b1110,
    Handshake_NYET = 4'b0110,
    Special_PRE = 4'b1100,
    Special_ERR = 4'b1100,
    Special_SPLIT = 4'b1000,
    Special_PING = 4'b0100,
    Special_Reserved = 4'b0000;
 


 //token_in es una funcion que se encarga de verificar si el token es valido 

	token_in token_in_intance (
    .data (token),
    .pid (pid1),
    .addr (addr1),
    .endp (endp1),
    .err  (err1)
  );


Data_set_up_pack Data_set_up_pack_intance (
 .data (data1),
 .packet  (setup_data),
 .data_error(data_error) 
 	);

always @(posedge clk)
    begin  if (rst) begin  #1 state =  IDLE;  end
    else   begin #1 state =  next_state;  end
end

always @(posedge clk)
begin 
startControl = 1'b0 ;
next_state = state;
token_out = 7'b0 ;
Myaddr = 7'b1111111;
 halted_enpoints_in = 0 ;
 halted_enpoints_out = 0;
 funcion_enpoints_in =0;
funcion_enpoints_out = 0;	
addr[6:0] = addr1;
	case (state)
		IDLE : 
			begin
				
					if (sync == 8'b01010100) 
					begin
						speed = 01 ;
						next_state = RECEIVE;
					end 
					if (sync2 == 1) 
					begin
						speed = 10 ;
						next_state = RECEIVE;
					end 
					if (sync2 != 1 && sync != 8'b01010100 ) 
					begin
						speed = 10 ;
						next_state = RECEIVE;
					end 

				
			end 
		RECEIVE :
			begin
			 if (token[23] == ~token[19] && token[22] == ~token[18] && token[21] == ~token[17] && token[20] == ~token[16])
			 begin
			    next_state = STATE;
			 end
			 else next_state =  IDLE; 

			end
		STATE: 
			begin	
				if (token[23:20] == Token_OUT)
				begin 
						if (addr[6:0] == Myaddr[6:0])
					begin

						if (halted_enpoints_out [endp1 ] == 1) next_state = STALL;
					
						else
						begin
						last_token[3:0] = token[23:20] ;
						 next_state =  IDLE;
						 end 

					end
					else next_state =  IDLE;  
				end 
				if (token[23:20] == Token_IN)
				begin 
					if (addr[6:0] == Myaddr[6:0])
						begin
						if (halted_enpoints_in [endp1 ] == 1) next_state = STALL;

						else
						begin
						last_token = token[23:20] ;
						 next_state =  IDLE;
						 end 
						end
					else next_state =  IDLE; 
				end 
				if (token[23:20] == Token_SETUP)
				begin 
				//Control mod 
					next_state =  SETUP_TOKEN; 

				end 
				if (token[23:20] == Data_DATA0 )
				begin 
				
					if (addr[6:0] == Myaddr[6:0])
						begin
							dato_par = 1 ;
							  if (last_token [3:0] == Token_SETUP) next_state =  DATA_IN;
							  if (last_token [3:0] == Token_IN) next_state =  DATA_IN;   
							  if (last_token [3:0] == Token_OUT) next_state =  DATA_OUT; 
							 if (last_token [3:0] != Token_SETUP && last_token [3:0] != Token_SETUP && last_token [3:0] != Token_OUT)  next_state =  IDLE;  
						end
						else next_state =  IDLE;  
				end 
				if (token[23:20] == Data_DATA1)
				begin 
					if (addr[6:0] == Myaddr[6:0])
						begin
						dato_par = 0 ; 
						 if (last_token [3:0] == Token_IN) next_state =  DATA_IN; 
						  if (last_token [3:0] == Token_OUT) next_state =  DATA_OUT;
						end
						else next_state =  IDLE;  
				end 
				if (token[23:20] == Handshake_ACK )
				begin 
					if (addr[6:0] == Myaddr[6:0])
						begin
						end
						else next_state =  IDLE;  
				end 
				if (token[23:20] == Handshake_NAK)
				begin 
					if (addr[6:0] == Myaddr[6:0])
						begin
						//this is not used by debug class in control 
						end
						else next_state =  IDLE;  
				end 
				if (token[23:20] == Handshake_STALL)
				begin 
					if (addr[6:0] == Myaddr[6:0])
						begin
						//this is not used by debug class in control 
						end
						else next_state =  IDLE;  
				end		
			end 
		SETUP_TOKEN: 	
			begin 
				last_token = token[23:20] ;

				if (endp1==0) 
				begin
					/*if (data_error == 1'b1)
						begin
						//este dato 
						next_state =  NACK_TOKEN; 
						end
						
						else */
						begin
						
						next_state =  IDLE; 
						end 
				end 
			end
		NACK_TOKEN:
			begin
			token_out = Handshake_NAK;
			next_state =  IDLE;  
			end 
		

		ACK_TOKEN: 	
			begin 
			token_out = Handshake_ACK; 
			
				next_state =  IDLE; 
			  
			end 			
		STALL:		
			begin 
				token_out = Handshake_STALL; 
			
			end  

		DATA_IN:
			begin 
				if (last_token == Token_SETUP)
				begin
				dato_atual = setup_data[80:16];
				next_state =  ACK_TOKEN; 

				end
				else
				begin
					 dato_atual= data1 ;
					if (data_error == 1'b1)
					begin
					//este dato 
					next_state =  NACK_TOKEN; 
					end
					if (busy == 1'b1)
					begin
					//este dato 
					next_state =  STALL; 
					end
				end 

				if (busy != 1'b1 && data_error != 1'b1) 
				begin
				
				next_state =  ACK_TOKEN; 
				end 
			end
		DATA_OUT:
			begin 
				next_state =  IDLE; 

				if (data_error == 1'b1)
				begin
				//este dato 
				next_state =  NACK_TOKEN; 
				end
				if (busy == 1'b1)
				begin
				//este dato 
				next_state =  STALL; 
				end


				if (busy != 1'b1 && data_error != 1'b1) 
				begin
				
				next_state =  ACK_TOKEN; 
				end 
			end
		/**/
	endcase
end 
endmodule
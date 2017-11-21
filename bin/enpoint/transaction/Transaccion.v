`include "Defintions.v" 
//este modulo es concido como targetsystem 
module TS (

clk,
rst,
data, 
token,
setup, 
firtsPachet, 
data_out,
setup_data,

);
input wire  clk;
input wire rst;
input wire [95:0] setup_data;
input wire [1047:0]data; 
input wire [23:0] token;
input wire [7:0]  setup; 
input wire firtsPachet; 

output reg [1047:0]data_out;

reg [3:0]state,next_state;
reg [6:0]addr;	
reg [3:0]endp;
reg error; 
reg DATA_error;
reg token_vald;
reg [6:0]Myaddr ;
wire [7:0]pid1;
    wire [6:0]addr1;
    wire [3:0]endp1;
    wire err1;
  wire [71:0] data1 ;
  wire data_error; 

//estos son los estados y los valores valios de token no se trabajo con l
//los esperciales 

parameter [3:0]
	IDLE = 4'b0001,
	RECEIVE = 4'b0010,
	STATE = 4'b0011,
	TOKEN = 4'b0100,
	DATA = 4'b0101,
	HANDSHAKE = 4'b0110,
	SETUP_TOKEN = 4'b0111,
	OUT_TOKEN = 4'b1000, 
	IN_TOKEN = 4'b1001,
	ACK_TOKEN = 4'b1010, 
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


Data_set_up_pack Data0_pack_intance (
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

next_state = state;

Myaddr = 7'b1111111;
	
	case (state)
		IDLE : 
			begin
			if (firtsPachet== 0 ) next_state =  IDLE;
			else next_state = RECEIVE;
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
					end
					else next_state =  IDLE;  
				end 
				if (token[23:20] == Token_IN)
				begin 
					if (addr[6:0] == Myaddr[6:0])
						begin
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
						end
						else next_state =  IDLE;  
				end 
				if (token[23:20] == Data_DATA1)
				begin 
					if (addr[6:0] == Myaddr[6:0])
						begin

						//this is not used by debug class in control 
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
			if (data_error == 1'b1)
				begin
				next_state =  IDLE; 
				end
			
			end 		
		endcase	
		/**/
end 
endmodule
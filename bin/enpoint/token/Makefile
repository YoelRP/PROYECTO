all: 
	iverilog -o desing.out  Token_TB.v Token.v CRC5_D5.v
	vvp desing.out
	gtkwave tester.vcd &

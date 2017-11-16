all: 
	iverilog -o desing.out Handshake.v  Handshake_TB.v
	vvp desing.out
	gtkwave tester.vcd &

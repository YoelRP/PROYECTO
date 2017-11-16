all: 
	iverilog -o desing.out CRC5_D5.v TBCRC.v
	vvp desing.out
	gtkwave tester.vcd &C

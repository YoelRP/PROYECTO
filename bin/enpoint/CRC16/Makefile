all: 
	iverilog -o desing.out CRC16_D1024.v TBCRC.v
	vvp desing.out
	gtkwave tester.vcd &C

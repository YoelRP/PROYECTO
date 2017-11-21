all: 
	iverilog -o desing.out CRC16_D72.v data_setup.v data_setup_TB.v
	vvp desing.out
	gtkwave tester.vcd &

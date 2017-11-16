all: 
	iverilog -o desing.out CRC16_D1024.v data_pack.v data_pack_TB.v
	vvp desing.out
	gtkwave tester.vcd &

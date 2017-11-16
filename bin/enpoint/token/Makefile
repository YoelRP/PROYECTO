all: 
	iverilog -o desing.out Cyclic_redundancy_check.v TBCRC.v
	vvp desing.out
	gtkwave tester.vcd &

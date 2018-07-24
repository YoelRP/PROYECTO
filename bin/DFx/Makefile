all: 
	iverilog -o desing.out dfx.v TBdfx.v
	vvp desing.out
	gtkwave tester.vcd &C

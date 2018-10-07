all: 
	iverilog -o desing.out dfx.v inv.v dfx8bit.v TBdfx.v
	vvp desing.out
	gtkwave tester.vcd &C

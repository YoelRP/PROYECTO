all: 
	iverilog -o desing.out control.v control_TB.v 
	vvp desing.out
	gtkwave temp.gtkw &

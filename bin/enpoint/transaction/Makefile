all: 
	iverilog -o desing.out Transaccion.v Transaccion_TB.v
	vvp desing.out
	gtkwave tester.vcd &

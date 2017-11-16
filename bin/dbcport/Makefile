all: 
	iverilog -o desing.out DbCPortStateMachine_tb.v DbCPortStateMachine.v
	vvp desing.out
	gtkwave tester.vcd &
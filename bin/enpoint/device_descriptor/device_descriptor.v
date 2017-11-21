module Device_descriptor (
	write_value,
	actual_value,
	write_enable
	)

	input wire  write_enable
	input wire [23:0] write_value
	output reg [23:0] actual_value
	always @ (*) 
	begin
	if (write_enable) 
				actual_value = write_value;
	end 
endmodule 
				
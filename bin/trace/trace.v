module mux1( 
	select,
 	d,
  q 
 );

input wire [8:0] select;
input wire [255:0] d;
output  reg   q;

assign q = d[select];

endmodule
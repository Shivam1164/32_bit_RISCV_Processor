module sgn_extnd(inp16, inp26, sgn_ext_16, outp) ;


input [25:0] inp26 ;
input [15:0] inp16 ;

input sgn_ext_16 ;
output reg [31:0] outp ;

reg [31:0] temp1, temp2 ;

always @(inp16, inp26 , sgn_ext_16) begin

temp1 = {{16{inp16[15]}}, inp16} ;
temp2 = {{6{inp26[25]}}, inp26} ;


outp = sgn_ext_16 ? temp2 : temp1 ; // temp1 16 bit sign extended 



end



endmodule
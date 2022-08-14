module alu_tb() ;

reg clk, reset;
reg [9:0] iaddr_in, daddr_in ;
reg [31:0] din ;
wire [31:0] debug_out1, debug_out2, debug_out3, debug_out4 ;

piPro p1(clk, reset, iaddr_in, daddr_in, din, debug_out1, debug_out2, debug_out3, debug_out4) ;


always
begin

#10 clk = ~ clk ;

end


initial begin 
reset = 1'b1 ;
clk = 1'b0 ;
#30 ;
reset = 1'b0 ;

#150 $stop ;
end


endmodule
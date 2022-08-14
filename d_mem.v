module d_mem(r_wr, clk, din, daddr, dout);

input r_wr, clk ;
input [31:0] din ;
input [9:0] daddr ;
output [31:0] dout ;

reg [31:0] memory [127:0] ; 
integer i ;

initial begin 
for(i = 0 ; i < 128 ; i = i + 1) begin
memory[daddr] = 3 ;
end
end


always@(posedge clk) begin

if(r_wr == 1'b0) begin
memory[daddr] = din ;
end

end

assign dout = memory[daddr] ;


endmodule
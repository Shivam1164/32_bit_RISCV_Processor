module nbit_reg #(parameter n=32) (clk, din, dout, reset, enable);

input clk, reset, enable ;
input [n - 1:0] din ;
output reg [n - 1:0] dout ;
//parameter n = 32 ;

always @(posedge clk) begin

if(reset == 1'b1) begin
dout <= 0 ;
end
else if (enable == 1'b1) begin
dout <= din ;
end 

end 

endmodule



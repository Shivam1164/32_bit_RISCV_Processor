module instr_MEM (clk,  addr, data_in, data_out, rd_wrb);

input clk, rd_wrb ;
input [9:0] addr ;
input [31:0] data_in ;
output[31:0] data_out;

reg [31:0] mem [255:0] ;

initial begin

mem[0] = 32'b00000100011000010000000000000111 ;
mem[1] = 32'b00001000011000010000000000000010 ;
mem[2] = 32'b00001100011000010000000000000011 ;
mem[3] = 32'b00000000011000100000100000000000 ;
mem[4] = 32'b00000000011000100000100000000000 ;

end
always @(posedge clk)
begin
if(rd_wrb == 1'b0) begin 
mem[addr] = data_in ;
end
end

assign data_out = rd_wrb == 1'b1 ? mem[addr] : 32'hxxxxxxxx; 

endmodule

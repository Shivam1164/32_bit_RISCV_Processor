module register_file (R1_addr, R2_addr, R3_addr, R1_data, R2_data, R3_data, clk, reset, R3_wr_en, R1_debug, R2_debug, R3_debug);


input clk, R3_wr_en, reset ;
input [4:0] R1_addr, R2_addr, R3_addr;
output [31:0] R1_data, R2_data ;
input [31:0] R3_data ;
output [31:0] R1_debug, R2_debug, R3_debug ;

reg [31:0] register [31:0] ;
integer i ;

initial begin

for ( i = 0; i < 32 ; i = i + 1) begin 
register[i] = 3 ; 
end
end


always @(posedge clk) begin
if(reset == 1'b1 ) begin
for ( i = 0 ; i < 32 ; i = i + 1) begin 
register[i] = 3 ; 
end
end
else 
register[R3_addr] = R3_wr_en ? R3_data : register[R3_addr] ;


end

assign R1_data = register[R1_addr] ;
assign R2_data = register[R2_addr] ; 

assign R1_debug =register[1];
assign R2_debug =register[2];
assign R3_debug =register[3];


endmodule
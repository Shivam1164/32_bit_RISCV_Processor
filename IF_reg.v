module IF_reg(enable, reset, pc_curr_IF, pc_curr_ID, instr_IF, instr_ID, clk);

input clk, enable, reset ;
input  [31:0]  pc_curr_IF, instr_IF ;
output  reg [31:0] pc_curr_ID, instr_ID ;

always @(posedge clk) 
begin
if(reset == 1'b1) begin
pc_curr_ID <= 0;
instr_ID <= 0;
end
else if(enable == 1'b1)
begin
pc_curr_ID <= pc_curr_IF ;
instr_ID <= instr_IF ;
end

end

endmodule



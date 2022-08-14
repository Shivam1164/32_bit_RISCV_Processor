module MM_reg(clk, reset, enable, alu_result_MM, alu_result_WB, pc_MM, pc_WB, R3_addr_MM, 
           R3_addr_WB, mem_rw_MM, mem_rw_WB, R3_dcntrl_MM, R3_dcntrl_WB,
			  opcode_MM, opcode_WB, flags_MM, flags_WB, data_out_MM, data_out_WB) ;

input clk, reset, enable ;
input [31:0] alu_result_MM ;
output reg [31:0] alu_result_WB ;
input  [31:0] pc_MM ; 
output reg [31:0] pc_WB ;
input [4:0] R3_addr_MM ;
output reg [4:0] R3_addr_WB ;
input mem_rw_MM ;
output reg mem_rw_WB ;
input [1:0] R3_dcntrl_MM ;
output reg [1:0] R3_dcntrl_WB ;
input [5:0] opcode_MM ;
output reg [5:0] opcode_WB ;
input [2:0] flags_MM ;
output reg [2:0] flags_WB ;
input [31:0] data_out_MM ;
output reg [31:0] data_out_WB ;			  

always@(posedge clk) begin

if(reset) begin

alu_result_WB = 0 ;
pc_WB = 0 ;
R3_addr_WB = 0 ;
mem_rw_WB = 0 ;
R3_dcntrl_WB = 0 ;
opcode_WB = 0 ;
flags_WB = 0 ;
data_out_WB = 0 ;

end
else if(enable) begin
alu_result_WB = alu_result_MM  ;
pc_WB = pc_MM ;
R3_addr_WB = R3_addr_MM  ;
mem_rw_WB = mem_rw_MM  ;
R3_dcntrl_WB = R3_dcntrl_MM  ;
opcode_WB = opcode_MM  ;
flags_WB = flags_MM  ;
data_out_WB = data_out_MM ;
end

end

endmodule
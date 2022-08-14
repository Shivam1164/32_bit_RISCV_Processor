module  EX_reg(clk, reset, enable, alu_result_EX, alu_result_MM,  pc_EX, pc_MM, R1_data_EX, R1_data_MM, R3_addr_EX, 
          R3_addr_MM, mem_rw_EX, mem_rw_MM, R3_dcntrl_EX, R3_dcntrl_MM,
			 opcode_EX, opcode_MM, flags_EX, flags_MM);


input clk, reset, enable ;
input [31:0] alu_result_EX ;
output reg [31:0] alu_result_MM ;
input [31:0] pc_EX;
output reg [31:0] pc_MM ;
input [31:0] R1_data_EX ;
output reg [31:0] R1_data_MM ;
input [4:0] R3_addr_EX ; 
output reg [4:0] R3_addr_MM ; 
input mem_rw_EX ;
output reg mem_rw_MM ;
input [1:0] R3_dcntrl_EX ;
output reg [1:0] R3_dcntrl_MM ;
input [5:0] opcode_EX ;
output reg [5:0] opcode_MM ;
input [2:0] flags_EX ;
output reg [2:0] flags_MM ;


always@(posedge clk) begin
if(reset == 1'b1) begin
alu_result_MM = 0 ;
pc_MM = 0 ;
R1_data_MM = 0 ;
R3_addr_MM = 0; 
mem_rw_MM = 0;
R3_dcntrl_MM = 0;
opcode_MM = 0;
flags_MM = 0;

end 
else if(enable == 1'b1 ) begin
alu_result_MM = alu_result_EX ;
pc_MM = pc_EX ;
R1_data_MM = R1_data_EX ;
R3_addr_MM = R3_addr_EX; 
mem_rw_MM = mem_rw_EX;
R3_dcntrl_MM = R3_dcntrl_EX;
opcode_MM = opcode_EX;
flags_MM = flags_EX;
end


end


endmodule
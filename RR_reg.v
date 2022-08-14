module RR_reg (enable, clk, reset, pc_RR, pc_EX, R1_data_RR, R1_data_EX, R2_data_RR, R2_data_EX, R3_addr_RR, R3_addr_EX, func_RR, func_EX, 
               opr_alu1_RR, opr_alu1_EX, opr_alu2_RR, opr_alu2_EX, mem_rw_RR, mem_rw_EX, R3_dcntrl_RR, R3_dcntrl_EX, 
					imm_sgn_extd_RR, imm_sgn_extd_EX, opcode_RR, opcode_EX) ;
					
input enable, clk, reset ;
input [31:0] pc_RR ; 
output reg [31:0] pc_EX ;
input [31:0] R1_data_RR ;
output reg [31:0] R1_data_EX ; 
input [31:0] R2_data_RR;
output reg [31:0] R2_data_EX; 
input [4:0] R3_addr_RR;
output reg [4:0] R3_addr_EX;
input  [5:0] func_RR ; 
output reg [5:0] func_EX ;
input  opr_alu1_RR ; 
output reg opr_alu1_EX ; 
input [1:0] opr_alu2_RR ; 
output reg [1:0] opr_alu2_EX ; 
input mem_rw_RR ; 
output reg mem_rw_EX ; 
input [1:0] R3_dcntrl_RR ; 
output reg [1:0] R3_dcntrl_EX ; 
input	     [31:0] imm_sgn_extd_RR ;
output reg [31:0] imm_sgn_extd_EX ;
input [5:0] opcode_RR ;
output reg [5:0] opcode_EX ;


always @(posedge clk) begin
if(reset == 1'b1) begin
pc_EX = 0 ;
R1_data_EX = 0 ; 
R2_data_EX = 0 ; 
R3_addr_EX = 0 ;
func_EX = 0 ;
opr_alu1_EX = 0 ; 
opr_alu2_EX = 0 ; 
mem_rw_EX = 0 ; 
R3_dcntrl_EX = 0 ; 
imm_sgn_extd_EX = 0 ;
opcode_EX = 0 ;
end
else if (enable == 1'b1) begin
pc_EX = pc_RR  ;
R1_data_EX = R1_data_RR ; 
R2_data_EX = R2_data_RR  ; 
R3_addr_EX = R3_addr_RR ;
func_EX = func_RR  ;
opr_alu1_EX = opr_alu1_RR  ; 
opr_alu2_EX = opr_alu2_RR  ; 
mem_rw_EX = mem_rw_RR ; 
R3_dcntrl_EX = R3_dcntrl_RR ; 
imm_sgn_extd_EX = imm_sgn_extd_RR  ;
opcode_EX = opcode_RR ;
end


end

endmodule
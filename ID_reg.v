module ID_reg (enable, reset, R1_addr_ID, R2_addr_ID, R3_addr_ID,
                      func_ID, sgn_ext_16_ID, opr_alu1_ID, opr_alu2_ID, 
							 mem_rw_ID, R3_dcntrl_ID, RF_mux_R1_R2_ID, imm16_ID, imm26_ID,
							
						    R1_addr_RR, R2_addr_RR, R3_addr_RR,
                      func_RR, sgn_ext_16_RR, opr_alu1_RR, opr_alu2_RR, 
							 mem_rw_RR, R3_dcntrl_RR, RF_mux_R1_R2_RR, imm16_RR, imm26_RR,
							 clk,
							 pc_ID, pc_RR, opcode_ID, opcode_RR);

input enable, reset, clk ;

input [4:0] R1_addr_ID, R2_addr_ID, R3_addr_ID ;
input [5:0] func_ID ;
input sgn_ext_16_ID, opr_alu1_ID ;
input [1:0] opr_alu2_ID ; 
input mem_rw_ID ; 
input [1:0] R3_dcntrl_ID, RF_mux_R1_R2_ID ;
input [31:0] pc_ID ;
input [15:0] imm16_ID ;
input [25:0] imm26_ID ;
input [5:0] opcode_ID ;

output reg [5:0] opcode_RR ;
output reg [4:0] R1_addr_RR, R2_addr_RR, R3_addr_RR ;
output reg [5:0] func_RR ;
output reg sgn_ext_16_RR, opr_alu1_RR ;
output reg [1:0] opr_alu2_RR ; 
output reg mem_rw_RR ; 
output reg [1:0] R3_dcntrl_RR, RF_mux_R1_R2_RR ;
output reg [31:0] pc_RR ;
output reg [15:0] imm16_RR ;
output reg [25:0] imm26_RR ;


always @(posedge clk ) begin


if(reset == 1'b1) begin

R1_addr_RR = 0 ; 
R2_addr_RR = 0 ; 
R3_addr_RR = 0 ;
func_RR = 0 ;
sgn_ext_16_RR = 0 ; 
opr_alu1_RR = 0;
opr_alu2_RR = 0; 
mem_rw_RR = 0 ; 
R3_dcntrl_RR = 0 ;
RF_mux_R1_R2_RR = 0;
pc_RR = 0 ;
imm16_RR = 0 ;
imm26_RR = 0 ;
opcode_RR = 0 ;

end
else if(enable == 1'b1)
begin
R1_addr_RR = R1_addr_ID ; 
R2_addr_RR = R2_addr_ID; 
R3_addr_RR = R3_addr_ID ;
func_RR = func_ID ;
sgn_ext_16_RR = sgn_ext_16_ID ; 
opr_alu1_RR = opr_alu1_ID;
opr_alu2_RR = opr_alu2_ID; 
mem_rw_RR = mem_rw_ID ; 
R3_dcntrl_RR = R3_dcntrl_ID ;
RF_mux_R1_R2_RR = RF_mux_R1_R2_ID;
pc_RR = pc_ID ;
imm16_RR = imm16_ID ;
imm26_RR = imm26_ID ;
opcode_RR = opcode_ID ;

end

end



endmodule
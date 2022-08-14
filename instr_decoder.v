module instr_decoder(instr_in, R1_addr, R2_addr, R3_addr, func, sgn_ext_16, opr_alu1, opr_alu2, mem_rw, R3_dcntrl, RF_mux_R1_R2, imm16, imm26, opcode );

parameter R_type_instr = 6'b000000 ;
parameter I_add_type_instr = 6'b000001 ;
parameter I_sub_type_instr = 6'b000010 ;
parameter I_mul_type_instr = 6'b000011 ;
parameter I_nand_type_instr = 6'b000100 ;
parameter J_type_instr = 6'b000101 ;
parameter Beq_instr    = 6'b000110 ;
parameter Load_instr   = 6'b000111 ;
parameter Store_instr  = 6'b001000 ;



input [31:0] instr_in ;
output reg [4:0] R1_addr, R2_addr, R3_addr ;
output reg [5:0] func ;
output reg sgn_ext_16 ;
output reg opr_alu1 ;
output reg [1:0] opr_alu2 ;
output reg mem_rw ;
output reg [1:0] R3_dcntrl ;
output reg [1:0] RF_mux_R1_R2 ;
output [15:0] imm16 ;
output [25:0] imm26 ;
output [5:0] opcode;
assign opcode = instr_in[31:26] ;
assign imm16 = instr_in[15:0] ;
assign imm26 = instr_in[25:0] ;


//Rtype = <opcode:31:26> <R3:25:21> <R1:20:16> <R2:15:11> <Unused:10:6> <func:5:0>
//Itype = <opcode:31:26> <R1:25:21> <R2:20:16> <Imm:15:0>
//Jtype = <opcode:31:26> <Imm:25:0>

always @(*) begin 
RF_mux_R1_R2 = 2'b00 ; //R1 and R2
case (opcode)

R_type_instr : begin
	R1_addr = instr_in[20:16] ;
	R2_addr = instr_in[15:11];
	R3_addr = instr_in[25:21];
	func    = instr_in[5:0];
	sgn_ext_16 = 1'bx;
	opr_alu1 = 1'b0; //R1
	opr_alu2 = 2'b00; //R2
	mem_rw   = 1'b1; //read
	R3_dcntrl = 2'b10; //Write_enable:Alu_out

end

I_add_type_instr : begin
R1_addr = instr_in[20:16] ;
R2_addr = 5'bxxxxx;
R3_addr = instr_in[25:21];
func    = 6'bxxxxxx;
sgn_ext_16 = 1'b0;
opr_alu1 = 1'b0; //R1
opr_alu2 = 2'b01; //Imm16
mem_rw   = 1'b1; //read
R3_dcntrl = 2'b10; //Write_enable:Alu_out
end

I_sub_type_instr  : begin
R1_addr = instr_in[20:16] ;
R2_addr = 5'bxxxxx;
R3_addr = instr_in[25:21];
func    = 6'bxxxxxx;
sgn_ext_16 = 1'b0;
opr_alu1 = 1'b0; //R1
opr_alu2 = 2'b01; //Imm16
mem_rw   = 1'b1; //read
R3_dcntrl = 2'b10; //Write_enable:Alu_out
end
I_mul_type_instr  : begin
R1_addr = instr_in[20:16] ;
R2_addr = 5'bxxxxx;
R3_addr = instr_in[25:21];
func    = 6'bxxxxxx;
sgn_ext_16 = 1'b0;
opr_alu1 = 1'b0; //R1
opr_alu2 = 2'b01; //Imm16
mem_rw   = 1'b1; //read
R3_dcntrl = 2'b10; //Write_enable:Alu_out
end
I_nand_type_instr : begin
R1_addr = instr_in[20:16] ;
R2_addr = 5'bxxxxx;
R3_addr = instr_in[25:21];
func    = 6'bxxxxxx;
sgn_ext_16 = 1'b0;
opr_alu1 = 1'b0; //R1
opr_alu2 = 2'b01; //Imm16
mem_rw   = 1'b1; //read
R3_dcntrl = 2'b10; //Write_enable:Alu_out
end
J_type_instr : begin
R1_addr = instr_in[20:16] ;
R2_addr = 5'bxxxxx;
R3_addr = instr_in[25:21];
func    = 6'bxxxxxx;
sgn_ext_16 = 1'b0;
opr_alu1 = 1'b0; //R1
opr_alu2 = 2'b01; //Imm16
mem_rw   = 1'b1; //read
R3_dcntrl = 2'b00; //Alu_out
end

Beq_instr : begin
R1_addr = instr_in[20:16] ;
R2_addr = 5'bxxxxx;
R3_addr = instr_in[25:21];
func    = 6'bxxxxxx;
sgn_ext_16 = 1'b0;
opr_alu1 = 1'b0; //R1
opr_alu2 = 2'b01; //Imm16
mem_rw   = 1'b1; //read
R3_dcntrl = 2'b00; //Alu_out
end

Load_instr : begin
R1_addr = instr_in[20:16] ;
R2_addr = 5'bxxxxx;
R3_addr = instr_in[25:21];
func    = 6'b000001; //addition
sgn_ext_16 = 1'b0;
opr_alu1 = 1'b1; //R2
opr_alu2 = 2'b01; //Imm16
mem_rw   = 1'b1; //read
R3_dcntrl = 2'b11; //Mem_out
end

Store_instr : begin
R1_addr = instr_in[20:16] ;
R2_addr = 5'bxxxxx;
R3_addr = instr_in[25:21];
func    = 6'bxxxxxx;
sgn_ext_16 = 1'b0;
opr_alu1 = 1'b1; //R2
opr_alu2 = 2'b01; //Imm16
mem_rw   = 1'b0; //write
R3_dcntrl = 2'b00; //Write_enable:Alu_out
RF_mux_R1_R2 = 2'b11 ; //R3 and R1
end

default: begin
	R1_addr = instr_in[20:16] ;
	R2_addr = instr_in[15:11];
	R3_addr = instr_in[25:21];
	func    = instr_in[5:0];
	sgn_ext_16 = 1'bx;
	opr_alu1 = 1'b0; //R1
	opr_alu2 = 2'b11; //R2
	mem_rw   = 1'b1; //read
	R3_dcntrl = 2'b00; //Write_enable:Alu_out

end


endcase
end

endmodule
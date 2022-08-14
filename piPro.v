module piPro(clk, reset, iaddr_in, daddr_in, din, debug_out1, debug_out2, debug_out3, debug_out4);

input   clk, reset ;              // obviously!!
input [9:0] iaddr_in, daddr_in ;// Instr Mem in
input [7:0] din ;               // Data Memory input
//input [31:0] instrin ;          // Instr input
output [31:0] debug_out1 ;       // debug out howing procc operation current result
output [31:0] debug_out2 ; 
output [31:0] debug_out3 ; 
output [31:0] debug_out4 ; 

wire [31:0] R1_debug, R2_debug, R3_debug ;

wire  [31:0] pc_next;
wire [31:0] pc_curr ;
wire pc_enable ;
wire stall ;
wire enable, reset, clk ;
wire [31:0] instr_IF;
wire rw_instr_mem ;
assign rw_instr_mem = 1'b1 ;

//pipeline flush signals
wire flush1, flush2, flush3, flush4, flush5 ;


//decode stage signals
wire [31:0] instr_ID ;
wire [4:0] R1_addr_ID, R2_addr_ID, R3_addr_ID ;
wire [5:0] func_ID ;
wire sgn_ext_16_ID, opr_alu1_ID ;
wire [1:0] opr_alu2_ID ; 
wire mem_rw_ID ; 
wire [1:0] R3_dcntrl_ID, RF_mux_R1_R2_ID ;
wire [15:0] imm16_ID ;
wire [25:0] imm26_ID ;
wire [5:0] opcode_ID ;
wire [31:0] pc_ID ;

//Register Read Stage 
wire [31:0] pc_RR ;
wire [4:0] R1_addr_RR, R2_addr_RR, R3_addr_RR ;
wire [5:0] func_RR ;
wire sgn_ext_16_RR, opr_alu1_RR ;
wire [1:0] opr_alu2_RR ; 
wire mem_rw_RR ; 
wire [1:0] R3_dcntrl_RR, RF_mux_R1_R2_RR ;
wire [5:0] opcode_RR ;
wire [4:0] R1_addr_RR_mux, R2_addr_RR_mux ;
//wire [4:0] R3_addr_WB ;
wire [31:0] R1_data_RR, R2_data_RR, R3_data_WB;
wire [15:0] imm16_RR ;
wire [25:0] imm26_RR ;
wire [31:0] imm_sgn_extd_RR ;


//Execute Stage
wire [31:0] pc_EX ;
wire [4:0] R1_addr_EX, R2_addr_EX, R3_addr_EX ;
wire  opr_alu1_EX ;
wire [1:0] opr_alu2_EX ; 
wire mem_rw_EX ;
wire [1:0] R3_dcntrl_EX ; 
wire [1:0] RF_mux_R1_R2_EX ;
wire [31:0] R1_data_EX, R2_data_EX ;
wire [31:0] imm_sgn_extd_EX ;
wire [31:0] alu_opr1, alu_opr2 ;
wire [5:0] func_EX ;
wire [31:0] alu_result_EX ;
wire [2:0] flags_EX ;
wire [5:0] opcode_EX ;

//MM Stage

wire [31:0] alu_result_MM ;
wire [31:0] pc_MM ;
wire [31:0] R1_data_MM ;
wire [31:0] R3_addr_MM ;
wire mem_rw_MM ;
wire [1:0] R3_dcntrl_MM ;
wire [5:0] opcode_MM ;					
wire [2:0] flags_MM ;
wire [31:0] data_out_MM ;

//WB Stage

wire [31:0] alu_result_WB ;
wire [31:0] pc_WB ;
wire [31:0] data_out_WB ;
wire [4:0] R3_addr_WB ;
wire mem_rw_WB ;
wire [1:0] R3_dcntrl_WB ;
wire [5:0] opcode_WB ;					
wire [2:0] flags_WB ;


//assign pc_curr = reset ? 0 : pc_curr ;

//Fetch Stage

//pc instantiation
nbit_reg #(.n(32)) pc (.clk(clk), .din(pc_next), .dout(pc_curr), .reset(reset), .enable(pc_enable)) ;

//32 bit adder
assign pc_next = pc_curr + 1 ;
assign pc_enable = 1'b1 ;
 //assign debug_out1 = pc_curr ;
 assign debug_out2 = R1_debug ;
 assign debug_out3 = R2_debug ;
 assign debug_out4 = R3_debug ;
 assign debug_out1 = alu_result_MM ;
 
 assign flush1 = 1'b0 ;
 assign flush2 = 1'b0 ;
 assign flush3 = 1'b0 ;
 assign flush4 = 1'b0 ;
//IF_ID register 

assign enable = 1'b1 ;
IF_reg    pipe1(.enable(enable), .reset(flush1), .pc_curr_IF(pc_curr), .pc_curr_ID(pc_ID), .instr_IF(instr_IF), .instr_ID(instr_ID), .clk(clk));

instr_MEM imem(.clk(clk),  .addr(pc_curr), .data_in(0), .data_out(instr_IF), .rd_wrb(rw_instr_mem));


//Decode Stage

instr_decoder decoder(.instr_in(instr_ID), .R1_addr(R1_addr_ID), .R2_addr(R2_addr_ID), .R3_addr(R3_addr_ID),
                      .func(func_ID), .sgn_ext_16(sgn_ext_16_ID), .opr_alu1(opr_alu1_ID), .opr_alu2(opr_alu2_ID), 
							 .mem_rw(mem_rw_ID), .R3_dcntrl(R3_dcntrl_ID), .RF_mux_R1_R2(RF_mux_R1_R2_ID), .imm16(imm16_ID), .imm26(imm26_ID),
							 .opcode(opcode_ID)) ;
							 
ID_reg pipe2 (.enable(enable), .reset(flush2),.R1_addr_ID(R1_addr_ID), .R2_addr_ID(R2_addr_ID), .R3_addr_ID(R3_addr_ID),
                      .func_ID(func_ID), .sgn_ext_16_ID(sgn_ext_16_ID), .opr_alu1_ID(opr_alu1_ID), .opr_alu2_ID(opr_alu2_ID), 
							 .mem_rw_ID(mem_rw_ID), .R3_dcntrl_ID(R3_dcntrl_ID), .RF_mux_R1_R2_ID(RF_mux_R1_R2_ID),
							  .imm16_ID(imm16_ID), .imm26_ID(imm26_ID),
						    .R1_addr_RR(R1_addr_RR), .R2_addr_RR(R2_addr_RR), .R3_addr_RR(R3_addr_RR),
                      .func_RR(func_RR), .sgn_ext_16_RR(sgn_ext_16_RR), .opr_alu1_RR(opr_alu1_RR), .opr_alu2_RR(opr_alu2_RR), 
							 .mem_rw_RR(mem_rw_RR), .R3_dcntrl_RR(R3_dcntrl_RR), .RF_mux_R1_R2_RR(RF_mux_R1_R2_RR), .clk(clk),
							 .imm16_RR(imm16_RR), .imm26_RR(imm26_RR),
							 .pc_RR(pc_RR), .pc_ID(pc_ID), .opcode_ID(opcode_ID), .opcode_RR(opcode_RR) );


//Register Read Stage 



assign R1_addr_RR_mux = RF_mux_R1_R2_RR[1] ? R3_addr_RR : R1_addr_RR;
assign R2_addr_RR_mux = RF_mux_R1_R2_RR[0] ? R1_addr_RR : R2_addr_RR;
assign R3_data_WB = R3_dcntrl_WB[0] ? data_out_WB : alu_result_WB ;

register_file RF (R1_addr_RR_mux, R2_addr_RR_mux, R3_addr_WB, R1_data_RR, R2_data_RR, R3_data_WB, clk, reset, R3_dcntrl_WB[1], 
                  R1_debug, R2_debug, R3_debug);

RR_reg pipe3 (enable, clk, flush3, pc_RR, pc_EX, R1_data_RR, R1_data_EX, R2_data_RR, R2_data_EX, R3_addr_RR, R3_addr_EX, func_RR, func_EX, 
               opr_alu1_RR, opr_alu1_EX, opr_alu2_RR, opr_alu2_EX, mem_rw_RR, mem_rw_EX, R3_dcntrl_RR, R3_dcntrl_EX, 
					imm_sgn_extd_RR, imm_sgn_extd_EX, opcode_RR, opcode_EX);

					
					
					
//add sign extenders

sgn_extnd sgn1 (imm16_RR, imm26_RR, sgn_ext_16_RR, imm_sgn_extd_RR) ;


//Execute Stage 

//ALU Block

assign alu_opr1 = opr_alu1_EX ? R2_data_EX : R1_data_EX ;
assign alu_opr2 = opr_alu2_EX[0] ? imm_sgn_extd_EX : R2_data_EX ;


alu a_block (alu_opr1, alu_opr2, opcode_EX, func_EX, alu_result_EX, flags_EX) ;

//assign debug_out1 = alu_result_EX ;

//EX_MM reg

EX_reg p4(clk, flush4, enable, alu_result_EX, alu_result_MM, pc_EX, pc_MM, R1_data_EX, R1_data_MM, R3_addr_EX, 
          R3_addr_MM, mem_rw_EX, mem_rw_MM, R3_dcntrl_EX, R3_dcntrl_MM,
			 opcode_EX, opcode_MM, flags_EX, flags_MM);
			 

//Memory Write Stage



d_mem L1_cache ( mem_rw_EX, clk, R1_data_MM, alu_result_MM, data_out_MM );

MM_reg p5( clk, flush5, enable, alu_result_MM, alu_result_WB, pc_MM, pc_WB, R3_addr_MM, 
           R3_addr_WB, mem_rw_MM, mem_rw_WB, R3_dcntrl_MM, R3_dcntrl_WB,
			  opcode_MM, opcode_WB, flags_MM, flags_WB, data_out_MM, data_out_WB );


			  
//Write Back Stage






endmodule 
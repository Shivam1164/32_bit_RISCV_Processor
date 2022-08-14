module alu (alu_opr1, alu_opr2,opcode, func, alu_result_i, flags) ;

input [31:0] alu_opr1, alu_opr2 ;
input [5:0] func ;
input [5:0] opcode ;
output  [31:0] alu_result_i ;
output [2:0] flags ;
reg [32:0] alu_result ;

always@(opcode, alu_opr1, alu_opr2, func) begin

case (opcode) 

6'b000000 : begin //Rtype
if(func[1:0] == 2'b00) //add opr R type
alu_result = alu_opr1 + alu_opr2 ;
else if(func[1:0] == 2'b01) //sub R type
alu_result = alu_opr1 - alu_opr2 ;
else if(func[1:0] == 2'b10) //MUL R type
alu_result = alu_opr1[15:0] * alu_opr2[15:0] ;
else if(func[1:0] == 2'b11) //NAND R type
alu_result = ~(alu_opr1 & alu_opr2) ;
else 
alu_result = 0 ;
end

6'b000001 : begin // Itype- add
alu_result = alu_opr1 + alu_opr2 ;
end
6'b000010 : begin // Itype- sub
alu_result = alu_opr1 - alu_opr2 ;
end
6'b000011 : begin // Itype- mul
alu_result = alu_opr1[15:0] * alu_opr2[15:0] ;
end
6'b000100 : begin // Itype- nand
alu_result = ~(alu_opr1 & alu_opr2) ;
end

default : alu_result = 0 ;

endcase


end 

assign alu_result_i =  alu_result[31:0] ;
assign flags = 0 ;


endmodule
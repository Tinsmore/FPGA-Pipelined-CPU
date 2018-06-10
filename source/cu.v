module cu (func,op,rs,rt,mrn,mm2reg,mwreg,ern,em2reg,ewreg,rstequ,
				dwreg,dm2reg,dwmem,djal,daluc,daluimm,dshift,dsext,dregrt,fwda,fwdb,
				pcsource);
				
   input  [5:0]  func,op;
	input  [4:0]  rs,rt,mrn,ern;
   input         mm2reg,mwreg,em2reg,ewreg,rstequ;
	
   output        dwreg,dm2reg,dwmem,djal,daluimm,dshift,dsext,dregrt;
   output [3:0]  daluc;
   output [1:0]  pcsource,fwda,fwdb;
	 
	wire   [5:0]  func,op;
	wire   [4:0]  rs,rt,mrn,ern;
   wire          mm2reg,mwreg,em2reg,ewreg,rstequ;
	
	wire          dwreg,dm2reg,dwmem,djal,daluimm,dshift,dsext,dregrt;
   wire   [3:0]  daluc;
   wire   [1:0]  pcsource,fwda,fwdb;
	
	
	assign        fwda[0] = ((rs == ern && ewreg) | (rs == mrn) && mm2reg && mwreg) ? 1 : 0;
	assign        fwda[1] = (rs == mrn && mwreg) ? 1 : 0;
	
	assign        fwdb[0] = ((rt == ern && ewreg) | (rt == mrn) && mm2reg && mwreg) ? 1 : 0;
	assign        fwdb[1] = (rt == mrn && mwreg) ? 1 : 0;
	
   wire r_type = ~|op;
	
   wire i_add = r_type & func[5] & ~func[4] & ~func[3] &  //100000
                ~func[2] & ~func[1] & ~func[0];          
   wire i_sub = r_type & func[5] & ~func[4] & ~func[3] &  //100010
                ~func[2] &  func[1] & ~func[0];          
   wire i_and = r_type & func[5] & ~func[4] & ~func[3] &  // 100100
                func[2] & ~func[1] & ~func[0]; 
   wire i_or  = r_type & func[5] & ~func[4] & ~func[3] &  // 100101
                func[2] & ~func[1] & func[0];
   wire i_xor = r_type & func[5] & ~func[4] & ~func[3] &  // 100110
                func[2] & func[1] & ~func[0]; 
   wire i_sll = r_type & ~func[5] & ~func[4] & ~func[3] & // 000000
                ~func[2] & ~func[1] & ~func[0];
   wire i_srl = r_type & ~func[5] & ~func[4] & ~func[3] & // 000010
                ~func[2] & func[1] & ~func[0];
   wire i_sra = r_type & ~func[5] & ~func[4] & ~func[3] & // 000011
                ~func[2] & func[1] & func[0];
   wire i_jr  = r_type & ~func[5] & ~func[4] & func[3] &  // 001000
                ~func[2] & ~func[1] & ~func[0];
                
   wire i_addi = ~op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] & ~op[0]; //001000
   wire i_andi = ~op[5] & ~op[4] &  op[3] &  op[2] & ~op[1] & ~op[0]; //001100
   wire i_ori  = ~op[5] & ~op[4] &  op[3] & op[2] & ~op[1] & op[0]; // 001101
   wire i_xori = ~op[5] & ~op[4] &  op[3] & op[2] & op[1] & ~op[0];  // 001110
   wire i_lw   = op[5] & ~op[4] &  ~op[3] & ~op[2] & op[1] & op[0];  // 100011
   wire i_sw   = op[5] & ~op[4] &  op[3] & ~op[2] & op[1] & op[0];  // 101011
   wire i_beq  = ~op[5] & ~op[4] &  ~op[3] & op[2] & ~op[1] & ~op[0];  // 000100
   wire i_bne  = ~op[5] & ~op[4] &  ~op[3] & op[2] & ~op[1] & op[0];  // 000101
   wire i_lui  = ~op[5] & ~op[4] &  op[3] & op[2] & op[1] & op[0];  // 001111
   wire i_j    = ~op[5] & ~op[4] &  ~op[3] & ~op[2] & op[1] & ~op[0]; // 000010
   wire i_jal  = ~op[5] & ~op[4] &  ~op[3] & ~op[2] & op[1] & op[0]; // 000011
   
   assign pcsource[1] = i_jr | i_j | i_jal;
   assign pcsource[0] = ( i_beq & rstequ ) | (i_bne & ~rstequ ) | i_j | i_jal ;
   
   assign dwreg = i_add | i_sub | i_and | i_or   | i_xor  |
                 i_sll | i_srl | i_sra | i_addi | i_andi |
                 i_ori | i_xori | i_lw | i_lui  | i_jal;
   
   assign daluc[3] = i_sra;
   assign daluc[2] = i_sub | i_or | i_lui | i_srl | i_sra | i_ori | i_beq | i_bne;
   assign daluc[1] = i_xor | i_lui | i_sll | i_srl | i_sra | i_xori;
   assign daluc[0] = i_and | i_or | i_sll | i_srl | i_sra | i_andi | i_ori;
	
   assign dshift   = i_sll | i_srl | i_sra ;
   assign daluimm  = i_addi | i_andi | i_ori | i_xori | i_lw | i_sw | i_lui;
   assign dsext    = i_addi | i_andi | i_ori | i_xori | i_lw | i_sw | i_beq | i_bne | i_lui;
   assign dwmem    = i_sw;
   assign dm2reg   = i_lw;
   assign dregrt   = i_addi | i_andi | i_ori | i_xori | i_lw | i_sw | i_beq | i_bne | i_lui;
   assign djal     = i_jal;
	
endmodule
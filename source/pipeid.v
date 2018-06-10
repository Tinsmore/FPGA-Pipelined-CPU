module pipeid ( clock,resetn,inst,dpc4,
						mrn,mm2reg,mwreg,ern,em2reg,ewreg,
						ealu,malu,mmo,wwreg,wdi,wrn,      
						dwreg,dm2reg,dwmem,djal,daluc,daluimm,dshift,pcsource,wpcir,
						da,db,dimm,drn,bpc,jpc);   
				
	input          clock,resetn;		
	input  [31:0]  inst,dpc4;
	input          mm2reg,mwreg,em2reg,ewreg;
	input  [4:0]   mrn,ern;
	input  [31:0]  ealu,malu,mmo;
	input          wwreg;
	input  [31:0]  wdi;
	input  [4:0]   wrn;
	
	output         dwreg,dm2reg,dwmem,djal,daluimm,dshift;
	output [3:0]   daluc;
	output [1:0]   pcsource;
	output         wpcir;
	output [31:0]  da,db,dimm;
	output [4:0]   drn;
	output [31:0]  bpc,jpc;
	
	wire           clock,resetn;		
	wire   [31:0]  inst,dpc4;
	wire           mm2reg,mwreg,em2reg,ewreg;
	wire   [4:0]   mrn,ern;
	wire   [31:0]  ealu,malu,mmo;
	wire           wwreg;
	wire   [31:0]  wdi;
	wire   [4:0]   wrn;
	
	wire           dwreg,dm2reg,dwmem,djal,daluimm,dshift;
	wire   [3:0]   daluc;
	wire   [1:0]   pcsource;
	wire           wpcir;
	wire   [31:0]  da,db,dimm;
	wire   [4:0]   drn;
	wire   [31:0]  bpc,jpc;
	
	wire          dregrt,dsext;
   wire          e = dsext & inst[15];
   wire [15:0]   imm = {16{e}};                
	wire [31:0]   offset = {imm[13:0],inst[15:0],1'b0,1'b0};   
	assign        bpc = dpc4 + offset;
	
   assign        jpc = {dpc4[31:28],inst[25:0],1'b0,1'b0};
	assign        dimm = {imm,inst[15:0]};
	wire          rstequ = (da[31:0] == db[31:0])? 1 : 0;
	
	assign        wpcir = (inst[31:0] == 32'b0) ? 0 : 1;
	
	wire [31:0]   qa,qb,tmpa,tmpb;
	wire   [1:0]  fwda,fwdb;
	wire [31:0]   sa = { 27'b0, inst[10:6] };
	
   mux2x32 q_a (qa,sa,dshift,tmpa);
	mux2x32 q_b (qb,dimm,daluimm,tmpb);
	
	mux4x32 alu_a (tmpa,ealu,malu,mmo,fwda,da);
	mux4x32 alu_b (tmpb,ealu,malu,mmo,fwdb,db);
   mux2x5  reg_wn (inst[15:11],inst[20:16],dregrt,drn);
	
	cu  controlUnit (inst[5:0],inst[31:26],inst[25:21],inst[20:16],mrn,mm2reg,mwreg,ern,em2reg,ewreg,rstequ,
							dwreg,dm2reg,dwmem,djal,daluc,daluimm,dshift,dsext,dregrt,fwda,fwdb,
							pcsource);
							
	regfile rf (inst[25:21],inst[20:16],wdi,wrn,wwreg,~clock,resetn,qa,qb);
	
endmodule
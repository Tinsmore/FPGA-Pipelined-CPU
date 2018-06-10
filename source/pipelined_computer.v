module  pipelined_computer (resetn,clock,mem_clock,
										sw,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5); 
	
	input          resetn,clock,mem_clock;  
	
	input   [7:0]  sw;
	output  [6:0]  HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
	
	wire           clock,mem_clock,resetn;
	wire   [31:0]  out_port0,out_port1,out_port2,in_port0,in_port1;
	wire   [31:0]  npc,pc,pc4,bpc,jpc,ins,inst;     
	wire   [31:0]  dpc4,da,db,dimm; 
	wire   [31:0]  epc4,ea,eb,eimm,ealu;  
	wire   [31:0]  mb,mmo,malu; 
	wire   [31:0]  wmo,wdi,walu; 
	wire   [4:0]   drn,ern0,ern,mrn,wrn; 
	wire   [3:0]   daluc,ealuc; 
	wire   [1:0]   pcsource; 
	wire           wpcir; 
	wire           dwreg,dm2reg,dwmem,daluimm,dshift,djal;  
	wire           ewreg,em2reg,ewmem,ealuimm,eshift,ejal;  
	wire           mwreg,mm2reg,mwmem;      
	wire           wwreg,wm2reg;          
	
	
   pipepc  prog_cnt   ( npc,wpcir,clock,resetn,pc );  
	
	pipeif  if_stage   ( pc,bpc,da,jpc,pcsource,mem_clock,ins,npc,pc4 );
	
	pipeir  inst_reg   ( pc4,ins,clock,resetn,dpc4,inst );      
	
	pipeid  id_stage  ( clock,resetn,inst,dpc4,
								mrn,mm2reg,mwreg,ern,em2reg,ewreg,
								ealu,malu,mmo,wwreg,wdi,wrn,      
								dwreg,dm2reg,dwmem,djal,daluc,daluimm,dshift,pcsource,wpcir,
								da,db,dimm,drn,bpc,jpc); 
								
	pipedereg  de_reg  ( clock,resetn,
								dwreg,dm2reg,dwmem,djal,daluimm,dshift,dpc4,da,db,dimm,daluc,drn,
								ewreg,em2reg,ewmem,ejal,ealuimm,eshift,epc4,ea,eb,eimm,ealuc,ern0);   
								
	pipeexe  exe_stage ( ewreg,em2reg,ewmem,ejal,ealuc,ealuimm,eshift,
								epc4,ea,eb,eimm,ern0,
								ern,ealu);

	pipeemreg  em_reg  ( clock,resetn,ewreg,em2reg,ewmem,ealu,eb,ern,          
								mwreg,mm2reg,mwmem,malu,mb,mrn);
								
	pipemem  mem_stage ( clock,mem_clock,resetn,mwmem,malu,mb,mmo,
								out_port0,out_port1,out_port2,in_port0,in_port1);
								
	ledmodule led (clock,in_port0,in_port1,out_port0,out_port1,out_port2,
						resetn,sw,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	
   pipemwreg  mw_reg  ( clock,resetn,mwreg,mm2reg,malu,mmo,mrn,                    
									          wwreg,wm2reg,walu,wmo,wrn);    
								
	mux2x32  wb_stage  ( walu,wmo,wm2reg,wdi );
	
endmodule 
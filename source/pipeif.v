module pipeif ( pc,bpc,da,jpc,pcsource,mem_clk,ins,npc,pc4 );
	
   input   [31:0] pc,bpc,da,jpc;
	input   [1:0]  pcsource;
   input          mem_clk;
	
   output  [31:0] ins,npc,pc4;
   
	wire    [31:0] pc,bpc,da,jpc;
	wire    [1:0]  pcsource;
   wire           mem_clk;
	
	wire    [31:0] ins,npc,pc4;
	
   wire           imem_clk;
	
	assign  pc4 = pc + 32'b100;
	assign  imem_clk = ~ mem_clk;   
	
	mux4x32 nextpc(pc4,bpc,da,jpc,pcsource,npc);
   lpm_rom_irom irom (pc[7:2],imem_clk,ins); 
	
endmodule
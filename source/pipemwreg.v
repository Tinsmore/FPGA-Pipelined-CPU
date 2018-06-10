module pipemwreg (clock,resetn,mwreg,mm2reg,malu,mmo,mrn,                    
									     wwreg,wm2reg,walu,wmo,wrn);    
			
	input         clock,resetn;
	
	input         mwreg,mm2reg;
   input  [31:0] malu,mmo;
	input  [4:0]  mrn;
	
	output        wwreg,wm2reg;
   output [31:0] walu,wmo;
	output [4:0]  wrn;
	
	wire          clock,resetn;
	
   wire          mwreg,mm2reg;
   wire   [31:0] malu,mmo;
	wire   [4:0]  mrn;
   
   reg           wwreg,wm2reg;
   reg    [31:0] walu,wmo;
	reg    [4:0]  wrn;
	 
   always @ (negedge resetn or posedge clock)
      if (resetn == 0) 
         begin
            wwreg <= 0;
				wm2reg <= 0;
				wrn <= 5'b0;
				walu <= 32'b0;
				wmo <= 32'b0;
         end 
      else
         begin 
            wwreg <= mwreg;
				wm2reg <= mm2reg;
				wrn[4:0] <= mrn[4:0];
				walu[31:0] <= malu[31:0];
				wmo[31:0] <= mmo[31:0];
         end
			
endmodule
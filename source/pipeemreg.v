module pipeemreg ( clock,resetn,ewreg,em2reg,ewmem,ealu,eb,ern,          
							mwreg,mm2reg,mwmem,malu,mb,mrn); 
	
	input         clock,resetn;
   
	input         ewreg,em2reg,ewmem;
	input  [4:0]  ern;
   input  [31:0] eb,ealu;
	
	output        mwreg,mm2reg,mwmem;
	output [4:0]  mrn;
   output [31:0] mb,malu;
	
	wire          clock,resetn;
	
   wire          ewreg,em2reg,ewmem;
	wire   [4:0]  ern;
   wire   [31:0] eb,ealu;
	
   reg           mwreg,mm2reg,mwmem;
	reg    [4:0]  mrn;
   reg    [31:0] mb,malu;
	

   always @ (negedge resetn or posedge clock)
      if (resetn == 0) 
         begin
            mwreg  <= 0;
				mm2reg <= 0;
				mwmem  <= 0;
				mrn    <= 5'b0;
				malu   <= 32'b0;
				mb     <= 32'b0;
         end 
      else
         begin 
            mwreg    <= ewreg;
				mm2reg   <= em2reg;
				mwmem    <= ewmem;
				mrn[4:0] <= ern[4:0];
				malu[31:0] <= ealu[31:0];
				mb[31:0]   <= eb[31:0];
         end
			
endmodule
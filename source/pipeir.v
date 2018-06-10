module pipeir  ( pc4,ins,clock,resetn,dpc4,inst ); 

	input  [31:0] pc4,ins;
   input         clock,resetn;   
   
   output [31:0] dpc4,inst;
   
   wire   [31:0] ins ;
   wire          clock,resetn;
   reg    [31:0] inst,dpc4 ;
   
   always @ (negedge resetn or posedge clock)
      if ( resetn == 0) begin
         inst[31:0] <= 32'b0;
			dpc4[31:0] <= 32'b0;
      end else begin
         inst[31:0] <= ins[31:0];
			dpc4[31:0] <= pc4[31:0];
      end
		
endmodule
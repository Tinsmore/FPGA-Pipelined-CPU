module regfile (rna,rnb,d,wn,we,clk,clrn,qa,qb);
   input [4:0] rna,rnb,wn;
   input [31:0] d;
   input we,clk,clrn;
   
   output [31:0] qa,qb;
   
   reg [31:0] register [1:31]; // r1 - r31
   
   assign qa = (rna == 0)? 0 : register[rna]; // read
   assign qb = (rnb == 0)? 0 : register[rnb]; // read

	
   always @(posedge clk or negedge clrn) begin
      if (clrn == 0) begin // reset
			register[1] <= 32'b0;
			register[2] <= 32'b0;
			register[3] <= 32'b0;
			register[4] <= 32'b0;
			register[5] <= 32'b0;
			register[6] <= 32'b0;
			register[7] <= 32'b0;
			register[8] <= 32'b0;
			register[9] <= 32'b0;
			register[10] <= 32'b0;
			register[11] <= 32'b0;
			register[12] <= 32'b0;
			register[13] <= 32'b0;
			register[14] <= 32'b0;
			register[15] <= 32'b0;
			register[16] <= 32'b0;
			register[17] <= 32'b0;
			register[18] <= 32'b0;
			register[19] <= 32'b0;
			register[20] <= 32'b0;
			register[21] <= 32'b0;
			register[22] <= 32'b0;
			register[23] <= 32'b0;
			register[24] <= 32'b0;
			register[25] <= 32'b0;
			register[26] <= 32'b0;
			register[27] <= 32'b0;
			register[28] <= 32'b0;
			register[29] <= 32'b0;
			register[30] <= 32'b0;
			register[30] <= 32'b0;
      end 
		else 
		begin
         if ((wn != 0) && (we == 1))          // write
            register[wn] <= d;
      end
   end
endmodule
module ledmodule(clock,in0,in1,out0,out1,
						reset,sw,HEX0,HEX1,HEX2,HEX3);
						
	input         clock;
	input [31:0]  out0,out1;
	input         reset;
	input [7:0]   sw;
 	
	output [31:0] in0,in1;
	output [6:0]  HEX0,HEX1,HEX2,HEX3;
	
	wire [31:0]  out0,out1;
	reg [31:0]   in0,in1;
	
	initial
	begin
		in0 = 4'b0;
		in1 = 4'b0;
	end
	
	always @(posedge clock or negedge reset)
	begin
		if(reset == 0)
		begin
			in0 <= 32'b0;
			in1 <= 32'b0;
		end 
		
		in0 <= {28'b0,sw[3:0]};
		in1 <= {28'b0,sw[7:4]};
	end
	
	sevenseg  LED8_0 ( in0[3:0], HEX0 );   
	sevenseg  LED8_1 ( in1[3:0], HEX1 );        
	sevenseg  LED8_2 ( out0[3:0], HEX2 );   
	sevenseg  LED8_3 ( out1[3:0], HEX3 );
	
endmodule
	
	
module  sevenseg ( data, ledsegments);  
input [3:0] data;  
output [6:0] ledsegments;  
reg [6:0] ledsegments; 

always @ (*)      
		case(data)                       //     gfe_dcba     // 7 段 LED 数码管的位段编号                
													//     654_3210    // DE2 板上的信号位编号        
			0: ledsegments = 7'b100_0000;    // DE2C 板上的数码管为共阳极接法。        
			1: ledsegments = 7'b111_1001;        
			2: ledsegments = 7'b010_0100;        
			3: ledsegments = 7'b011_0000;        
			4: ledsegments = 7'b001_1001;        
			5: ledsegments = 7'b001_0010;        
			6: ledsegments = 7'b000_0010;        
			7: ledsegments = 7'b111_1000;        
			8: ledsegments = 7'b000_0000;        
			9: ledsegments = 7'b001_0000;  
			4'b1010: ledsegments = 7'b000_1000;  
			4'b1011: ledsegments = 7'b000_0011;  
			4'b1100: ledsegments = 7'b010_0111;  
			4'b1101: ledsegments = 7'b010_0001;  
			4'b1110: ledsegments = 7'b000_0110;  
			4'b1111: ledsegments = 7'b000_1110;
			default: ledsegments = 7'b111_1111;  // 其它值时全灭。    
		endcase   
endmodule 
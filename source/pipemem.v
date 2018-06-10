module pipemem ( clock,mem_clk,resetn,mwmem,malu,mb,mmo,
						out_port0,out_port1,out_port2,in_port0,in_port1);
    
	 input           clock,mem_clk,resetn,mwmem;
	 input  [31:0]   malu,mb;
	 output [31:0]   mmo;    
		 
	 input  [31:0]   in_port0,in_port1;   
	 output [31:0]   out_port0,out_port1,out_port2;      
    
	 wire [31:0]     mmo;    
	 wire            dmem_clk = mem_clk & ( ~ clock) ;            
	 wire [31:0]     mem_dataout,io_read_data;   
	 
	 wire            write_enable = mwmem & ~clock;        //注意    
	 wire            write_datamem_enable = write_enable & ( ~ malu[7]);    //注意    
	 wire            write_io_output_reg_enable = write_enable & ( malu[7]);  //注意     
	 
	 mux2x32  mem_io_dataout_mux(mem_dataout,io_read_data,malu[7],mmo); 
	 // module mux2x32 (a0,a1,s,y);        
	 // when address[7]=0, means the access is to the datamem. 
	 // that is, the address space of datamem is from 000000 to 011111 word(4 bytes)        
	 lpm_ram_dq_dram  dram(malu[6:2],dmem_clk,mb,write_datamem_enable,mem_dataout );     
	 // when address[7]=1, means the access is to the I/O space. 
	 // that is, the address space of I/O is from 100000 to 111111 word(4 bytes)   
    io_output_reg io_output_regx2 (malu,mb,write_io_output_reg_enable, dmem_clk,resetn,out_port0,out_port1,out_port2); 
	  
    io_input_reg io_input_regx2(malu,dmem_clk,io_read_data,in_port0,in_port1); 
	 
endmodule
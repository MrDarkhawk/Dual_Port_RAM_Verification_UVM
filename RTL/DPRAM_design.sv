//////////////////////////////////
// Design Module : Dual Port RAM 
/////////////////////////////////

// `define DATA_WIDTH 8
// `define ADDR_WIDTH 4
// `define DEPTH 16
module DPRAM #(parameter ADDR_WIDTH = 4, DATA_WIDTH = 8, DEPTH = 16)(clk,rst,wr_en,rd_en,wr_addr,rd_addr,wr_data,rd_data);

	// input signals 
	input clk;
	input rst;
	input wr_en;
	input rd_en;
  input [ADDR_WIDTH - 1 : 0]wr_addr;
  input [ADDR_WIDTH - 1 : 0]rd_addr;
  input [DATA_WIDTH - 1 : 0]wr_data;
	
	//output signals 
  output reg[DATA_WIDTH - 1 : 0]rd_data;
	
  reg [DATA_WIDTH - 1 : 0] ram [DEPTH - 1 : 0];
	
  reg [ADDR_WIDTH:0] i;
// 	integer i;
  
  always @(posedge clk or posedge rst )
		begin 
			if(rst)
				begin 
                  rd_data <= 'd0 ;
                  for(i=0;i<(DEPTH);i=i+1) 
                    begin
                      ram[i] <= 'dx;
					end
				end
		end 
	//write transaction 
  always @(posedge clk or posedge rst)
		begin 
			if(!rst)
			begin  
			if(wr_en) 
				begin 
					ram[wr_addr] <= wr_data;
				end 
			end 
		end 
	// Read Transaction
  always @(posedge clk or posedge rst)
		begin 
			if(!rst)
			begin 
			if(rd_en)
				begin 
					rd_data <= ram[rd_addr];
				end
			end
		end
/*
  	initial begin 
     $monitor("@%0t \t wr_data = %0d \t rd_data = %0d \t wr_addr = %0d \t rd+addr = %0d \t wr_en =%0d \t rd_en = %0d ",$realtime,wr_data,rd_data,wr_addr,rd_addr,wr_en,rd_en);
   end 
   */
endmodule

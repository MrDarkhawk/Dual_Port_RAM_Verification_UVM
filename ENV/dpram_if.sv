//-----------------------------------------------------------
// Interface	:	dpram_if
// Type			:	static component
// Description	:	To declare signals and clocking blocks.
//-----------------------------------------------------------
interface dpram_if #(parameter ADDR_WIDTH = 4, DATA_WIDTH = 8) (input bit clk);

	logic rst;
	logic wr_en;
	logic rd_en;
	logic [ADDR_WIDTH - 1 : 0]wr_addr;
	logic [ADDR_WIDTH - 1 : 0]rd_addr;
	logic [DATA_WIDTH - 1 : 0]wr_data; 
	logic [DATA_WIDTH - 1 : 0]rd_data;

	clocking drv_cb @(posedge clk);
	default input #1 output #1;
	input rd_data;
	output wr_en,rd_en,wr_addr,rd_addr,wr_data;
	endclocking 
	
	clocking mon_cb @(posedge clk);
	default input #1 output #1;
	input wr_en,rd_en,wr_addr,rd_addr,wr_data,rd_data;
	endclocking
	
	modport drv_mp (clocking drv_cb);
	
	modport mon_mp (clocking mon_cb);
endinterface
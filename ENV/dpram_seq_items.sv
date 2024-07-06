//------------------------------------------------------------------
//	class		:	dpram_seq_items
//	Base_class	:	uvm_sequence_item
//	Type		:	UVM_OBJECT
//	Description	:	Contains Write Transaction Signals & Constraints
//------------------------------------------------------------------
class dpram_seq_items #(parameter ADDR_WIDTH = 4, DATA_WITH = 8) extends uvm_sequence_item;

	rand bit wr_en;
	rand bit rd_en;
	rand bit [ADDR_WIDTH - 1 : 0]wr_addr;
	rand bit [ADDR_WIDTH - 1 : 0]rd_addr;
	rand bit [DATA_WIDTH - 1 : 0]wr_data; 
	bit [DATA_WIDTH - 1 : 0]rd_data;
	static bit [DATA_WIDTH - 1 : 0] exptd_data; // use in scoreboard to compare with actual data 
  constraint wr_en_c {soft wr_en == 1;}
	
  constraint rd_en_c {soft rd_en == 1;}
  // 	constraint wr_data_c1 {soft wr_data inside [10 : $];} // or wr_data >= 10
	constraint same_addr_c2 {soft wr_addr == rd_addr;} // or wr_data >= 10

	`uvm_object_param_utils_begin(dpram_seq_items #(ADDR_WIDTH,DATA_WIDTH))
		`uvm_field_int(wr_en,UVM_ALL_ON)
		`uvm_field_int(rd_en,UVM_ALL_ON)
		`uvm_field_int(wr_addr,UVM_ALL_ON)
		`uvm_field_int(rd_addr,UVM_ALL_ON)
		`uvm_field_int(wr_data,UVM_ALL_ON)
		`uvm_field_int(rd_data,UVM_ALL_ON)
	`uvm_object_utils_end

	function new(string name = "dpram_seq_items");
		super.new(name);
	endfunction
	

endclass 
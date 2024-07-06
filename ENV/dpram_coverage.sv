//-----------------------------------------------------------
// class		:	dpram_coverage
// Base_class	:	uvm_component
// Type			:	UVM_COMPONENT
// Description	:	Coverage to check functionality.
//-----------------------------------------------------------

class dpram_coverage extends uvm_component;

	`uvm_component_utils(dpram_coverage)
	
	dpram_seq_items seq_items_h;
	
	uvm_tlm_analysis_fifo #(dpram_seq_items #(ADDR_WIDTH, DATA_WIDTH)) an_fifo_h;
	
	real dpram_cov; // to extract the sampled coverage into this variable 
	
	covergroup dpram_cg;
		option.per_instance = 1;
		option.goal = 100;
		option.name = "coverage";
			
		wr_en_cp1 : coverpoint (seq_items_h.wr_en) {bins wr_en_b1 = (0 => 1);
													bins wr_en_b2 = (1 => 0);
                                                    /*bins wr_en_b3 = (0,1);*/}
	
		wr_data_cp2 : coverpoint (seq_items_h.wr_data) {bins wr_data_b1 = {[0:255]};}
	
		wr_addr_cp3 : coverpoint (seq_items_h.wr_addr) {bins wr_addr_b1 = {[0:15]};}
	
		rd_en_cp4 : coverpoint (seq_items_h.rd_en) {bins rd_en_b1 = (0 => 1);
													bins rd_en_b2 = (1 => 0);
                                                    /*bins rd_en_b3 = (0,1);*/}
	
		rd_data_cp5 : coverpoint (seq_items_h.rd_data) {bins rd_data_b1 = {[0:255]};}
	
		rd_addr_cp6 : coverpoint (seq_items_h.rd_addr) {bins rd_addr_b1 = {[0:15]};}
    
    endgroup
	
  	function new(string name = "dpram_coverage",uvm_component parent = null);
		super.new(name,parent);
		dpram_cg = new(); // to create the coevergroup 
	endfunction 
		
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		an_fifo_h = new("an_fifo_h",this);
	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin 
		an_fifo_h.get(seq_items_h);	
		dpram_cg.sample();
		end
	endtask

	function void extract_phase(uvm_phase phase);
		super.extract_phase(phase);
		dpram_cov = dpram_cg.get_coverage();
	endfunction
	
	function void report_phase(uvm_phase phase);
		super.report_phase(phase);
		`uvm_info("coverage_info","fifo_coverage report_phase started",UVM_MEDIUM)
		`uvm_info(get_type_name(),$sformatf("coverage is : %f",dpram_cov),UVM_MEDIUM)
	endfunction
	
endclass
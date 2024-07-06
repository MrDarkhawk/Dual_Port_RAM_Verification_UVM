class dpram_base_test extends uvm_test;

  `uvm_component_utils(dpram_base_test)
  	
  virtual dpram_if#(ADDR_WIDTH, DATA_WIDTH) vif;
	// handle for environment and sequences
	dpram_environment	env_h;
	dpram_write_sequence wseqs_h;
	dpram_read_sequence	rseqs_h;
			
	function new(string name = "dpram_base_test",uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
      `uvm_info(get_type_name(),"INSIDE the build phase of test ",UVM_NONE)
		env_h = dpram_environment :: type_id :: create("env_h",this);
		wseqs_h = dpram_write_sequence :: type_id :: create("wseqs_h",this);
		rseqs_h = dpram_read_sequence :: type_id :: create("rseqs_h",this);
      uvm_config_db #(virtual dpram_if#(ADDR_WIDTH, DATA_WIDTH)) :: get(null,"","vif",vif);
      
	endfunction
	
	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		`uvm_info(get_type_name(),"Printing Topology Of components in hierarchy",UVM_NONE)
		uvm_top.print_topology();
	endfunction 
	
	task run_phase(uvm_phase phase);		
		phase.raise_objection(this);
			`uvm_info(get_type_name(),"Inside the task run_phase of base test",UVM_NONE)
			wait(vif.rst == 0);
			wseqs_h.start(env_h.agent_h.seqr_h);
      `uvm_info(get_type_name(),"Write sequence exicuted ",UVM_NONE)
      		
			rseqs_h.start(env_h.agent_h.seqr_h);
      `uvm_info(get_type_name(),"read sequence exicuted ",UVM_NONE)
		phase.drop_objection(this);
	endtask 
	
endclass
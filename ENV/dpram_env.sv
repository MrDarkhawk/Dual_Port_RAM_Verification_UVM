//-----------------------------------------------------------
// class		:	dpram_env
// Base_class	:	uvm_env
// Type			:	UVM_COMPONENT
// Description	:	Environment will create and connect agent, scoreboard
//-----------------------------------------------------------
class dpram_environment extends uvm_env;
		
	`uvm_component_utils(dpram_environment)
	
	dpram_agent	agent_h;
	dpram_sb sb_h;
	dpram_coverage cov_h;

	function new(string name = "dpram_env",uvm_component parent = null);
		super.new(name,parent);
    endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent_h = dpram_agent :: type_id :: create("agent_h",this);
		sb_h = dpram_sb :: type_id :: create("sb_h",this);
		cov_h = dpram_coverage :: type_id :: create("cov_h",this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
      agent_h.mon_h.an_port.connect(sb_h.an_fifo_h.analysis_export);
      agent_h.mon_h.an_port.connect(cov_h.an_fifo_h.analysis_export);
	endfunction
      
endclass 
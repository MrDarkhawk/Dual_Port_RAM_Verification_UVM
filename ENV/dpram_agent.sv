//-----------------------------------------------------------
// class		:	dpram_agent
// Base_class	:	uvm_agent
// Type			:	UVM_COMPONENT
// Description	:	Agent connect the sequencer with driver. Driver and monitor with interface.
//-----------------------------------------------------------

class dpram_agent extends uvm_agent;
	
	`uvm_component_utils(dpram_agent)
	
	dpram_sequencer	 	seqr_h;
	dpram_driver 		drv_h;
	dpram_monitor		mon_h;
	
  virtual dpram_if#(ADDR_WIDTH, DATA_WIDTH) vif;
	
	function new(string name = "dpram_agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seqr_h = dpram_sequencer::type_id::create("seqr_h",this);
		drv_h = dpram_driver::type_id::create("drv_h",this);
		mon_h = dpram_monitor::type_id::create("mon_h",this);
      if(!uvm_config_db#(virtual dpram_if#(ADDR_WIDTH, DATA_WIDTH))::get(this,"","vif",vif)) begin
		`uvm_fatal("FIFO_WRITE_AGENT","The virtual interface get failed");
          `uvm_info(get_type_name(),"INSIDE THE BUILD PHASE OF AGENT",UVM_NONE)
        end
	endfunction
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv_h.seq_item_port.connect(seqr_h.seq_item_export);
		drv_h.vif = vif;
		mon_h.vif = vif;
	endfunction 
	
endclass
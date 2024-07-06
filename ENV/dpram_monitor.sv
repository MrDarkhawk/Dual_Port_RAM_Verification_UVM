
class dpram_monitor extends uvm_monitor;
	
	//factory registration of component 
	`uvm_component_utils(dpram_monitor)
	
	// virtual interface for monitor transactions with dut 
  virtual dpram_if#(ADDR_WIDTH, DATA_WIDTH).mon_mp vif;
	
	// taking handle of write transaction 
	dpram_seq_items seq_items_h;
	
	// Declaring the tlm analysis port to subscribe the data to other components 
  uvm_analysis_port #(dpram_seq_items #(ADDR_WIDTH, DATA_WIDTH)) an_port;
	
	// class constructor 
	function new(string name = "dpram_monitor", uvm_component parent = null );
		super.new(name,parent);
	endfunction
	
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    an_port = new("an_port",this);
  endfunction
  
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		// We should always use the forever block for monitor to sample the data continously
		forever begin 
		// calling monitor block to sampling data from dut 
		monitor();
		// using write method 
          an_port.write(seq_items_h);
		end 
	endtask 

	task monitor();
		// creating the write transaction class objects
      seq_items_h = dpram_seq_items #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("seq_items_h",this);
		//using write monitor clocking block to get the transactions through virtual interface 
      @(vif.mon_cb);
		// sampling data from dut through vif and assigning it to write transactions 
		seq_items_h.wr_en = vif.mon_cb.wr_en;
		seq_items_h.rd_en = vif.mon_cb.wr_en;
		seq_items_h.wr_data = vif.mon_cb.wr_data;
		seq_items_h.rd_data = vif.mon_cb.rd_data;
		seq_items_h.wr_addr = vif.mon_cb.wr_addr;
		seq_items_h.rd_addr = vif.mon_cb.rd_addr;	
	endtask 
	
endclass
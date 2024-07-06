//-------------------------------------------------------------------------
// Class		: dpram_driver
// Base Class	: uvm_driver
// Type			: UVM_COMPONENT
// Description	: Receive sequence_items from Sequencer
//				  Send them to DUT
//				  Send Acknowledgement signal to Sequence through sequencer
//--------------------------------------------------------------------------
class dpram_driver extends uvm_driver #(dpram_seq_items);
	
	`uvm_component_utils(dpram_driver)
	
	dpram_seq_items seq_items_h;
		
  virtual dpram_if#(ADDR_WIDTH, DATA_WIDTH) vif;
	
	function new(string name = "dpram_driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
	//handshaking of driver seqeuncer and sequence
	task run_phase(uvm_phase phase);
      `uvm_info(get_type_name(),"INSIDE THE RUN PHASE TASK OF DRIVER",UVM_NONE)
      forever begin 
        seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
		end 	
	endtask 

	//drive data items to dut at the posedge of clk of interface 
	task send_to_dut(dpram_seq_items req);
	if(!vif.rst) begin
      @(vif.drv_cb);
		vif.drv_cb.wr_en <= req.wr_en;
		vif.drv_cb.wr_data <= req.wr_data;
		vif.drv_cb.wr_addr <= req.wr_addr;
      @(vif.drv_cb);	
      	vif.drv_cb.rd_en <= req.rd_en;
		vif.drv_cb.rd_addr <= req.rd_addr;
		end
	else if(vif.rst) begin 
		@(vif.drv_cb);
		vif.drv_cb.wr_en <= 0;
		vif.drv_cb.rd_en <= 0;
    end
	endtask
  
endclass 
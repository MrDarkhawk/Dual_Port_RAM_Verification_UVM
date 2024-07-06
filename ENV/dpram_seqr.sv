//----------------------------------------------------------------
// class		: dpram_sequencer
// Base_class	: uvm_sequencer
// Type			: UVM_COMPONENT
// Description	: Sequencer will receive sequence_items from
//				  sequence and send them to driver.
//----------------------------------------------------------------
class dpram_sequencer extends uvm_sequencer #(dpram_seq_items);

	`uvm_component_utils(dpram_sequencer)
	
	function new(string name = "dpram_sequencer", uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
endclass
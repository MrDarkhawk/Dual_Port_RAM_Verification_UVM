//----------------------------------------------------------------
// Class		:	dpram_read_sequence
// Base_class	: 	uvm_sequence
// Type			:	UVM_OBJECT
// Description	:	To generate Sequence_items,
//					creating object of read_trans
//					send it to sequencer by start_item
//					randomization of write_trans object
//					Finish Sequence_items through signal finish_item
//----------------------------------------------------------------class dpram_read_sequence extends uvm_sequence #(dpram_seq_items);
	
	dpram_seq_items seq_items_h;
	
	`uvm_object_utils(dpram_read_sequence)
	
	function new(string name = "dpram_read_sequence");
		super.new(name);
	endfunction

	task body();
      repeat(10) begin
          seq_items_h = dpram_seq_items #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("seq_items_h");
		start_item(seq_items_h);
        assert(seq_items_h.randomize());
		//seq_items_h.print();
		finish_item(seq_items_h);
		end
	endtask 
endclass
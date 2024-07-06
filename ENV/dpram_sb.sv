//---------------------------------------------------------------
// Class		:	dpram_sb
// Base_class	:	uvm_scoreboard
// Type			:	UVM_COMPONENT
// Description	:	Connection for monitor in connect phase
//					checkers code
//					comparing ref. model output and design output
//--------------------------------------------------------------- 
class dpram_sb extends uvm_scoreboard;

	`uvm_component_utils(dpram_sb)
	
	dpram_seq_items seq_items_h;
	
	uvm_tlm_analysis_fifo#(dpram_seq_items #(ADDR_WIDTH, DATA_WIDTH)) an_fifo_h;
	
	bit [DATA_WIDTH - 1 : 0] dpram_que[$];
	bit [DATA_WIDTH - 1 : 0] exptd_data; 
	
	function new(string name = "dpram_sb",uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		an_fifo_h = new("an_fifo_h",this);
	endfunction
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		an_fifo_h.get(seq_items_h);
		ref_model();
		check_data();
	endtask
	
	task ref_model();
		begin
//           `uvm_info(get_type_name(),"REF_MODEL TASK start",UVM_NONE)
			if(seq_items_h.wr_en)
			dpram_que.push_front(seq_items_h.wr_data);  
			if(seq_items_h.rd_en && dpram_que.size() !== 0)
			seq_items_h.exptd_data <= dpram_que.pop_back();
//           `uvm_info(get_type_name(),"REF_MODEL TASK ended",UVM_NONE)
		end	
	endtask 
	
	task check_data();
		if(seq_items_h.rd_data !== 0 && seq_items_h.rd_data !== 8'dx) begin 
          if (seq_items_h.rd_data !== seq_items_h.exptd_data) begin 
            `uvm_info(get_type_name(),$sformatf("DATA MISMATCHED! : DUT_RD_DATA = %0h :: %0h = REF_EXPECTD_DATA 	TIME : @%0t ",seq_items_h.rd_data,seq_items_h.exptd_data,$realtime),UVM_NONE);
        end
          else begin
              `uvm_info(get_type_name(),$sformatf("DATA SUCCESSFULLY MATCHED! : DUT_RD_DATA = %0h :: %0h = REF_EXPTD_DATA 	TIME : @%0t ",seq_items_h.rd_data,seq_items_h.exptd_data,$realtime),UVM_NONE);
        end
//         end
	endtask 
	
endclass
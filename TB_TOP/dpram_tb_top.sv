
// import uvm_pkg::*;
// import dpram_pkg::*;
module dpram_top;
	
	import uvm_pkg::*;
 	//int no_of_transfer = 10;
	parameter DATA_WIDTH = 8;
	parameter ADDR_WIDTH = 4;
	parameter DEPTH = 16;
	`include"uvm_macros.svh"
  	`include "dpram_if.sv"
	`include"dpram_seq_items.sv"
	`include"dpram_wseqs.sv"
	`include"dpram_rseqs.sv"
	`include"dpram_seqr.sv"
	`include"dpram_driver.sv"
	`include"dpram_monitor.sv"
	`include"dpram_agent.sv"
	`include"dpram_sb.sv"
  	`include"dpram_coverage.sv"
	`include"dpram_env.sv"
	`include"dpram_test.sv"
	
// 	parameter DATA_WIDTH = 8;
// 	parameter ADDR_WIDTH = 4;
// 	parameter DEPTH = 16;
	bit clk = 0;
	bit rst = 0;
	
	dpram_if #(ADDR_WIDTH, DATA_WIDTH) inf(clk);
	
  DPRAM dut(.clk(clk),.rst(inf.rst),.wr_en(inf.wr_en),.rd_en(inf.rd_en),.wr_addr(inf.wr_addr),.rd_addr(inf.rd_addr),.wr_data(inf.wr_data),.rd_data(inf.rd_data));

	always begin 
      #5 clk = ~clk;
//       $display("inside clk block clock = %0d",clk);
    end

	initial begin 
      
	@(posedge clk) inf.rst = 1;
//       `uvm_info("rst",$sformatf("@%0t inside rst block reset = %0d",$realtime,inf.rst),UVM_NONE);
	#10;
	@(posedge clk) inf.rst = 0;
//       `uvm_info("rst",$sformatf("@%0tinside rst block reset = %0d",$realtime,inf.rst),UVM_NONE);
	end
	
	initial begin 
      uvm_config_db #(virtual dpram_if #(ADDR_WIDTH, DATA_WIDTH)) :: set(null,"*","vif",inf);
//       $display("inside the tb top run test");
		run_test("dpram_base_test");

	end
	
	initial begin 
		$dumpfile("dump.vcd");
		$dumpvars;
	end 
endmodule 
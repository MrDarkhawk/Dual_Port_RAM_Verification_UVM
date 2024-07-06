package dpram_pkg;
	import uvm_pkg::*;
 	int no_of_transfer = 10;
	parameter DATA_WIDTH = 8;
	parameter ADDR_WIDTH = 4;
	parameter DEPTH = 16;
	`include"uvm_macros.svh"
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
endpackage 
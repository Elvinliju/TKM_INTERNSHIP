`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 21:09:18
// Design Name: 
// Module Name: aes_interface
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


interface aes_interface(input logic clk);

  logic reset_n;
  logic IN_valid;
  logic [127:0] IN_state;
  logic [127:0] key;

  logic OUT_valid;
  logic [127:0] OUT_state;

  clocking drv_cb @(posedge clk);
    output reset_n;
    output IN_valid;
    output IN_state;
    output key;

    input OUT_valid;
    input OUT_state;
  endclocking

  clocking mon_cb @(posedge clk);
    input reset_n;
    input IN_valid;
    input IN_state;
    input key;
    input OUT_valid;
    input OUT_state;
  endclocking

  modport DRIVER (
    clocking drv_cb,
    input clk
  );

  modport MONITOR (
    clocking mon_cb,
    input clk
  );

endinterface
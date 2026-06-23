`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 21:11:32
// Design Name: 
// Module Name: aes_transaction
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
class aes_transaction;

  // -------------------------------
  // INPUTS
  // -------------------------------
  rand bit [127:0] plaintext;
  rand bit [127:0] key;

  // -------------------------------
  // EXPECTED (for directed tests)
  // -------------------------------
  bit [127:0] expected_ciphertext;

  // -------------------------------
  // ACTUAL (from monitor)
  // -------------------------------
  bit [127:0] actual_ciphertext;

  // -------------------------------
  // METADATA
  // -------------------------------
  string test_name;

  time start_time;
  time end_time;

  // -------------------------------
  // DISPLAY METHOD (VERY IMPORTANT)
  // -------------------------------
  function void display(string tag);
    $display("[%s] TEST=%s PT=%h KEY=%h EXP=%h ACT=%h TIME=%0t->%0t",
      tag,
      test_name,
      plaintext,
      key,
      expected_ciphertext,
      actual_ciphertext,
      start_time,
      end_time
    );
  endfunction

endclass
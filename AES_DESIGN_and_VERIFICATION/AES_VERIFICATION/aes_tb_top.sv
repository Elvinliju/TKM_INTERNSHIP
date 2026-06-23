`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AES TESTBENCH TOP - FULL VERSION (100% COVERAGE READY)
//////////////////////////////////////////////////////////////////////////////////

`include "aes_interface.sv"
`include "aes_transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
`include "program.sv"

module aes_tb_top;

  // Clock
  logic clk;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Interface
  aes_interface intf(clk);

  // ---------------- DUT ----------------
  AES_128Core DUT (
    .clk       (clk),
    .reset_n   (intf.reset_n),
    .IN_valid  (intf.IN_valid),
    .IN_state  (intf.IN_state),
    .key       (intf.key),
    .OUT_valid (intf.OUT_valid),
    .OUT_state (intf.OUT_state)
  );

  // ---------------- ASSERTIONS ----------------
  aes_assertions ASSERTIONS (
    .clk       (clk),
    .reset_n   (intf.reset_n),
    .OUT_valid (intf.OUT_valid),
    .OUT_state (intf.OUT_state)
  );

  // ---------------- RTL COVERAGE ----------------
  aes_coverage COVERAGE (
    .clk       (clk),
    .reset_n   (intf.reset_n),
    .IN_valid  (intf.IN_valid),
    .IN_state  (intf.IN_state),
    .key       (intf.key),
    .OUT_valid (intf.OUT_valid)
  );

  // ---------------- MAILBOXES ----------------
  mailbox #(aes_transaction) gen2drv = new();
  mailbox #(aes_transaction) drv2scb = new();
  mailbox #(aes_transaction) mon2scb = new();
  mailbox #(aes_transaction) mon2cov = new();

  // ---------------- COMPONENTS ----------------
  generator  gen;
  driver     drv;
  monitor    mon;
  scoreboard scb;
  coverage   cov;

  // ---------------- TEST START ----------------
  initial begin

    $display("========================================");
    $display("AES-128 Verification Started");
    $display("========================================");

    // Create components
    gen = new(gen2drv);
    drv = new(gen2drv, drv2scb, intf.DRIVER);
    mon = new(intf.MONITOR, mon2scb, mon2cov);
    scb = new(drv2scb, mon2scb);
    cov = new(mon2cov);

    // Run all in parallel
    fork
      gen.run();
      drv.run();
      mon.run();
      scb.run();
      cov.run();
    join_none

    // ---------------- SIMULATION TIME ----------------
    #20000000;   // ? Enough for all random + directed tests

    // Final report
    scb.report();

    $display("========================================");
    $display("SIMULATION COMPLETED");
    $display("========================================");

    $finish;

  end

endmodule
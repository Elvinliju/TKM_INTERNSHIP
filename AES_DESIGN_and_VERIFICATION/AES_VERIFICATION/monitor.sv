`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Monitor - Updated for Coverage + Scoreboard + Stability
//////////////////////////////////////////////////////////////////////////////////

class monitor;

  // Virtual Interface
  virtual aes_interface.MONITOR vif;

  // Mailboxes
  mailbox #(aes_transaction) mon2scb;
  mailbox #(aes_transaction) mon2cov;

  // Constructor
  function new(
      input virtual aes_interface.MONITOR vif,
      input mailbox #(aes_transaction) mon2scb,
      input mailbox #(aes_transaction) mon2cov
  );

    this.vif = vif;
    this.mon2scb = mon2scb;
    this.mon2cov = mon2cov;

  endfunction


  // ------------------------------------------
  // MAIN RUN
  // ------------------------------------------
  task run();

    aes_transaction tr;

    forever begin

      @(vif.mon_cb);

      if (vif.mon_cb.OUT_valid == 1'b1) begin

        tr = new();

        // Capture output
        tr.actual_ciphertext = vif.mon_cb.OUT_state;

        // Capture timing
        tr.end_time = $time;

        // ----------------------------------
        // SEND TO SCOREBOARD
        // ----------------------------------
        mon2scb.put(tr);

        // ----------------------------------
        // SEND TO COVERAGE
        // ----------------------------------
        mon2cov.put(tr);

        // Debug prints
        $display("[MONITOR] OUT_valid detected at %0t", $time);
        $display("[MONITOR] Actual Ciphertext = %032h",
                 tr.actual_ciphertext);

      end

    end

  endtask

endclass
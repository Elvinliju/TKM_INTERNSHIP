`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026
// Module Name: scoreboard
// Description: Improved scoreboard (supports directed + random tests safely)
// 
//////////////////////////////////////////////////////////////////////////////////

class scoreboard;

  // Mailboxes
  mailbox #(aes_transaction) drv2scb;
  mailbox #(aes_transaction) mon2scb;

  // Counters
  int pass_count;
  int fail_count;

  // Constructor
  function new(
      input mailbox #(aes_transaction) drv2scb,
      input mailbox #(aes_transaction) mon2scb
  );
    this.drv2scb = drv2scb;
    this.mon2scb = mon2scb;
  endfunction


  // ------------------------------------------
  // MAIN RUN TASK
  // ------------------------------------------
  task run();

    aes_transaction exp_tr;
    aes_transaction act_tr;

    forever begin

      // Get transactions
      drv2scb.get(exp_tr);
      mon2scb.get(act_tr);

      // Safety check
      if (exp_tr == null || act_tr == null) begin
        $display("[SCOREBOARD] ERROR: Null transaction");
        continue;
      end

      // Capture end time
      act_tr.end_time = $time;

      // Display info
      $display("========================================");
      $display("TEST NAME : %s", exp_tr.test_name);
      $display("PLAINTEXT : %032h", exp_tr.plaintext);
      $display("KEY       : %032h", exp_tr.key);
      $display("EXPECTED  : %032h", exp_tr.expected_ciphertext);
      $display("ACTUAL    : %032h", act_tr.actual_ciphertext);

      // ------------------------------------------
      // RANDOM TEST DETECTION (SAFE)
      // ------------------------------------------
      if (^exp_tr.expected_ciphertext === 1'bx) begin

        // Random test ? skip comparison
        $display("[SCOREBOARD] RANDOM TEST (SKIPPED CHECK)");

      end
      else begin

        // Directed test ? compare safely
        if (exp_tr.expected_ciphertext === act_tr.actual_ciphertext) begin
          pass_count++;
          $display("[SCOREBOARD] TEST PASSED");
        end
        else begin
          fail_count++;
          $display("[SCOREBOARD] TEST FAILED");
        end

      end

      // Latency calculation
      $display("LATENCY = %0t ns",
               act_tr.end_time - exp_tr.start_time);

      $display("========================================");

    end

  endtask


  // ------------------------------------------
  // FINAL REPORT
  // ------------------------------------------
  function void report();

    $display("========================================");
    $display("FINAL SCOREBOARD REPORT");
    $display("PASS COUNT = %0d", pass_count);
    $display("FAIL COUNT = %0d", fail_count);
    $display("========================================");

  endfunction

endclass
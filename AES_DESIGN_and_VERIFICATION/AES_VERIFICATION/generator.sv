`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 21:25:35
// Design Name: 
// Module Name: aes_tb_top
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
`timescale 1ns/1ps

class generator;

  mailbox #(aes_transaction) gen2drv;

  function new(input mailbox #(aes_transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  // -------------------------------
  // SEND TASK
  // -------------------------------
  task send(input aes_transaction tr);
    gen2drv.put(tr);
    tr.display("GENERATOR");
  endtask

  // -------------------------------
  // DIRECTED TESTS
  // -------------------------------
  task directed_tests();

    aes_transaction tr;

    tr = new();
    tr.test_name = "ALL_ZERO";
    tr.plaintext = 0;
    tr.key = 0;
    tr.expected_ciphertext = 128'h66e94bd4ef8a2c3b884cfa59ca342b2e;
    send(tr);

    tr = new();
    tr.test_name = "ALL_ONES";
    tr.plaintext = '1;
    tr.key = '1;
    tr.expected_ciphertext = 128'hbcbf217cb280cf30b2517052193ab979;
    send(tr);

  endtask

  // -------------------------------
  // RANDOM TESTS
  // -------------------------------
  task random_tests(int count = 200);

    aes_transaction tr;

    repeat(count) begin
      tr = new();
      assert(tr.randomize());

      tr.test_name = "RANDOM";
      tr.expected_ciphertext = 'x;

      send(tr);
    end

  endtask

  // -------------------------------
  // SPARSE (TOGGLE BOOST)
  // -------------------------------
  task sparse_tests(int count = 100);

    aes_transaction tr;

    repeat(count) begin
      tr = new();

      tr.plaintext = 0;
      tr.key = 0;

      repeat(5) begin
        tr.plaintext[$urandom_range(0,127)] = 1;
        tr.key[$urandom_range(0,127)] = 1;
      end

      tr.test_name = "SPARSE";
      tr.expected_ciphertext = 'x;

      send(tr);
    end

  endtask

  // -------------------------------
  // WALKING 1s (VERY IMPORTANT)
  // -------------------------------
  task walking_ones();

    aes_transaction tr;

    for(int i=0;i<128;i++) begin
      tr = new();

      tr.plaintext = (128'h1 << i);
      tr.key = (128'h1 << (127-i));

      tr.test_name = "WALKING_ONE";
      tr.expected_ciphertext = 'x;

      send(tr);
    end

  endtask

  // -------------------------------
  // MAIN RUN
  // -------------------------------
  task run();

    directed_tests();

    random_tests(300);

    sparse_tests(200);

    walking_ones();

  endtask

endclass
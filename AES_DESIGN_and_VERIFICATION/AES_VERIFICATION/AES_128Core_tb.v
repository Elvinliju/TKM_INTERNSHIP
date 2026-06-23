`timescale 1 ns / 1 ps

module AES_128Core_tb;

    reg clk;
    reg reset_n;

    reg          IN_valid;
    reg  [127:0] IN_state;
    reg  [127:0] key;

    wire         OUT_valid;
    wire [127:0] OUT_state;

    // Instantiate the Device Under Test (DUT)
    AES_128Core DUT(
        .clk(clk), 
        .reset_n(reset_n),
        .IN_valid(IN_valid),
        .IN_state(IN_state),
        .key(key),
        .OUT_valid(OUT_valid),
        .OUT_state(OUT_state)
    );

    // Clock period (10 ns = 100 MHz)
    localparam PERIOD = 10.0;
    
    // Clock generation
    always #(PERIOD/2) clk = ~clk;

    initial begin
        // 1. Initialize Signals
        clk = 0;
        reset_n = 0;
        IN_valid = 0;
        IN_state = 128'h0;
        key = 128'h0;

        // 2. Apply Reset
        #(5 * PERIOD);
        @(negedge clk); // Synchronize to falling edge for clean setup
        reset_n = 1;

        // 3. Apply Input Stimulus
        #(2 * PERIOD);
        @(negedge clk);
        IN_valid = 1;
        
        // Test Vector from Appendix B
        IN_state = 128'h32_43_f6_a8_88_5a_30_8d_31_31_98_a2_e0_37_07_34;
        key      = 128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
        
        // De-assert valid after 1 cycle to ensure pipeline correctly handles single-block feeds
        @(negedge clk);
        IN_valid = 0; 
        
        // 4. Wait for the pipeline to complete (Dynamic Hardware Handshaking)
        wait(OUT_valid == 1'b1);
        
        // 5. Display Results & Auto-Verify
        $display("---------------------------------------------------------");
        $display("Time: %0t | Expected: 3925841d02dc09fbdc118597196a0b32", $time);
        $display("Time: %0t | Actual  : %h", $time, OUT_state);
        $display("---------------------------------------------------------");
        
        if (OUT_state == 128'h39_25_84_1d_02_dc_09_fb_dc_11_85_97_19_6a_0b_32)
            $display(">>> TEST PASSED <<<");
        else
            $display(">>> TEST FAILED <<<");
        $display("---------------------------------------------------------");

        // Wait a few cycles before ending simulation
        #(5 * PERIOD);
        $finish;
    end

endmodule
//=========================================================
// EOF AES_128Core_tb
//=========================================================
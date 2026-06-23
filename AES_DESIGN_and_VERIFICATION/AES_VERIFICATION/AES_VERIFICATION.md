
<img width="1600" height="900" alt="veroutput" src="https://github.com/user-attachments/assets/3ea8cec8-001f-403c-a6c0-01bc0a4e68ab" />
This screenshot shows the successful verification of the AES-128 encryption core using a SystemVerilog-based verification environment in Vivado. The setup includes a structured testbench with components such as driver, monitor, scoreboard, and interface.

🧪 Verification Environment

The AES design is verified using:

Testbench (aes_tb_top)
DUT (AES_128Core)
Interface (aes_interface)
Verification Components:
Driver
Monitor
Scoreboard
Environment

This modular setup ensures proper stimulus generation, signal observation, and result checking.

📊 Simulation & Console Results
Total Latency: 320000 ns
PASS Count: 10
FAIL Count: 0

✔️ All test cases passed successfully.

The final console message confirms:

AES-128 Verification Completed
⚙️ Functional Behavior
Input Stimulus
Testbench applies multiple plaintext and key combinations.
IN_valid controls when inputs are sampled.
Processing
DUT performs AES encryption over multiple clock cycles.
Internal FSM handles round operations.
Monitoring
The monitor captures DUT inputs and outputs.
Transactions are forwarded to the scoreboard.
Scoreboard Checking
Compares DUT output (OUT_state) with expected ciphertext.
Logs PASS/FAIL results for each test case.
Final Result
All 10 test cases matched expected outputs.
No mismatches detected.
🧠 Key Highlights
✔️ Zero functional errors (FAIL = 0)
✔️ Accurate AES-128 implementation
✔️ Robust verification using scoreboard methodology
✔️ Deterministic latency across test cases

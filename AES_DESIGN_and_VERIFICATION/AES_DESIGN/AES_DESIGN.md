<img width="1600" height="758" alt="design output" src="https://github.com/user-attachments/assets/9373ee32-d682-43be-ac78-e5ce8e1f22d1" />

This waveform represents the behavioral simulation of the AES-128 encryption core, verified using a testbench in Vivado. It demonstrates the correct sequencing of control signals, input data handling, and final ciphertext generation.

📊 Signal Description
clk: System clock driving the sequential AES core.
reset_n: Active-low reset signal used to initialize the design.
IN_valid: Indicates when the input plaintext and key are valid.
IN_state[127:0]: 128-bit plaintext input to the AES core.
key[127:0]: 128-bit encryption key.
OUT_valid: Asserted when the encryption process is complete.
OUT_state[127:0]: 128-bit ciphertext output.
PERIOD: Clock period (10 ns in this simulation).
⚙️ Operation Flow
Initialization Phase
reset_n is held low initially to reset internal registers.
All outputs remain zero during this phase.
Input Application
IN_valid is asserted.
Plaintext (IN_state) and key (key) are applied:
Plaintext: 0x3243f6a8885a308d313198a2e0370734
Key: 0x2b7e151628aed2a6abf7158809cf4f3c
These correspond to the standard AES test vector.
Encryption Phase
The AES core processes the data over multiple clock cycles using its iterative FSM architecture.
Internal transformations include:
SubBytes
ShiftRows
MixColumns
AddRoundKey
Output Generation
After the final round, OUT_valid is asserted.
The resulting ciphertext appears on OUT_state:
Ciphertext: 0x3925841d02dc09fbdc118597196a0b32

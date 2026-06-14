<img width="1865" height="337" alt="image" src="https://github.com/user-attachments/assets/14e90668-6711-4d62-a1df-7b61ca93cf6c" />
This project is a 4-Bit Binary Coded Decimal (BCD) Adder. It is written in Verilog. Tested using a SystemVerilog testbench. The project shows how to design and verify a circuit on EDA Playground.

How the Hardware Works

The system adds two 4-bit BCD numbers and a carry-in signal. When we add two numbers the result can be bigger than 9, which is not a valid BCD number. So the design has a logic to detect this. If the result is bigger than 9. If there is a carry the hardware adds 6 to the result and gives the correct BCD sum and a carry-out.

The Verification Setup

The testbench does not connect directly to the hardware. Instead it uses a SystemVerilog Interface to send and receive signals. This interface groups the inputs (A B, cin) and outputs (Sum, cout) into one channel. This is how it is done in real-world verification.

Simulation and Waveform Results

The testbench checks the logic in situations:

Standard Addition: When we add 4 and 4 the result is 8 with no carry-out. The hardware does not need to correct the result.

BCD Correction Enabled: When we add 7 and 6 the result is 13, which's not a valid BCD number. The detection circuit fixes this. Gives a BCD sum of 3 with a carry-out of 1.

Maximum Boundary Check: When we add 9, 9 and a carry-in of 1 the system is, at its limit. The design correctly gives a BCD sum of 9 (which's 19) with a carry-out of 1.

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 18:55:31
// Design Name: 
// Module Name: tb
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

module tb;

    reg  [3:0] A, B;
    reg  cin;
    wire [3:0] Sum;
    wire cout;

    bcd_adder dut (
        .A(A),
        .B(B),
        .cin(cin),
        .Sum(Sum),
        .cout(cout)
    );

    initial begin
        $monitor("Time=%0t A=%0d B=%0d Cin=%0b --> Cout=%0b Sum=%0d",
                  $time, A, B, cin, cout, Sum);

        A = 4'd0; B = 4'd0; cin = 1'b0;
        #10;

        A = 4'd4; B = 4'd4; cin = 1'b0;
        #10;

        A = 4'd7; B = 4'd6; cin = 1'b0;
        #10;

        A = 4'd9; B = 4'd9; cin = 1'b1;
        #10;

        $finish;
    end

endmodule
    end

endmodule
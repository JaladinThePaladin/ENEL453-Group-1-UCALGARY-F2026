`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2026 09:31:17 AM
// Design Name: 
// Module Name: switch_pause
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


module switch_pause(
    input logic clk, 
    input logic reset,
    input logic bottom_PB,              // Enable signal for flip flopz
    input logic [15:0]  paused_vals,    // Input directly from switches
    output logic [15:0] sent_vals       // What pause module sends to the 7 segment sequence
    );
    
    always_ff @(posedge clk)
        if      (reset) sent_vals <= 16'b0;
        else if (bottom_PB) sent_vals <= paused_vals;

    
endmodule

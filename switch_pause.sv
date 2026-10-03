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
    input logic storage_ON,
    input logic [15:0]  switches_inputs,    // Input directly from switches
    output logic [15:0] storage_vals       // What pause module sends to the 7 segment sequence
    );
    
    // logic [15:0] storage;    // Stores paused intermediary values
    
    always_ff @(posedge clk)
    
        if (reset)
            storage_vals <= 16'b0;
        else if (storage_ON)
            storage_vals <= switches_inputs;        
            
endmodule

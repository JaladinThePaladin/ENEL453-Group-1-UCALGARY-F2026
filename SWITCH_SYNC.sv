`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2026 04:56:43 PM
// Design Name: 
// Module Name: SWITCH_SYNC
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


module SWITCH_SYNC(
    input  logic        clk,
    input  logic [15:0] switches_inputs,
    output logic [15:0] switches_outputs 
    );
    
    always_ff @(posedge clk)
        switches_outputs <= switches_inputs;
    
endmodule

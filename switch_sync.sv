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


module switch_sync(
    input  logic        clk,
    input  logic [15:0] switches_inputs,
    output logic [15:0] switches_outputs 
    );
    
    logic n1;
    
    always_ff @(posedge clk)
        n1 <= switches_inputs;
    always_ff @(posedge clk)
        switches_outputs <= n1;
    
endmodule

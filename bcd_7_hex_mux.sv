`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Me
// Engineer: Luke Zenha
// 
// Create Date: 09/23/2026 06:08:36 PM
// Module Name: bcd_7_hex_mux
// Project Name: 
// Tool Versions: 
// Description: Takes input from bin_to_bcd giving the 7_seg_display module values from it if PB is pressed
// 
// Dependencies: 
//
//////////////////////////////////////////////////////////////////////////////////


module bcd_7_hex_mux(
        input logic  [15:0] decimal_vals,
        input logic  [15:0] hex_vals,
        input logic         decider,
        output logic [15:0] bcd_real_out
    ); 
    
    always_comb begin
    
        if(~decider)
            bcd_real_out = decimal_vals;
        else
            bcd_real_out = hex_vals;
    end

endmodule
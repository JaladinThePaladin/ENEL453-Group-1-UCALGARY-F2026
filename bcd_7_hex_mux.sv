`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Me
// Engineer: Luke Zenha
// 
// Create Date: 09/23/2026 06:08:36 PM
// Module Name: bcd_7_hex_mux
// Project Name: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
//
//////////////////////////////////////////////////////////////////////////////////


module bcd_7_hex_mux(   
        input logic  [15:0] BCD_vals,                       // Current BCD values from BIN_TO_BCD module
        input logic  [15:0] stored_BCD,                    // Stored BCD values from BIN_TO_BCD module
        input logic  [15:0] hex_vals,                     // Current hex values directly from SWITCHES modules
        input logic  [15:0] stored_hex,                  // Stored hex values from SWITCH_PAUSE module
        input logic         storage_enable,             // Left PB overrides Top PB and sends the stored values 
        input logic         hex_or_BCD_decider,        // Top PB decides whether Hex or Decimal Vals are sent to 7 Seg
        output logic [15:0] bcd_real_out
    ); 
    
    always_comb begin
        
        if (storage_enable & ~hex_or_BCD_decider)    // If Bottom PB is pressed and the hexidecimal enable isn't it sends stored BCD to 7 segment display
            bcd_real_out = stored_BCD; 
            
        if (storage_enable & hex_or_BCD_decider)     // If Bottom PB is pressed and the hexidecimal enable is it sends stored hex to 7 segment display
            bcd_real_out = stored_hex;
            
        if(~storage_enable & hex_or_BCD_decider)     // If Bottom PB isn't pressed and hexidecimal enable is it sends current hex to 7 segment display
            bcd_real_out = hex_vals;    
        else
            bcd_real_out = BCD_vals;                 // If nothing is pressed it defaults to current switches value from BCD to 7 segment display
    end

endmodule
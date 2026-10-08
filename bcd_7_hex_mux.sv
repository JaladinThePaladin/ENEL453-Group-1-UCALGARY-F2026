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
        input logic         storage_enable,             // Right PB sends the stored values 
        input logic         hex_or_BCD_decider,        // Top PB decides whether Hex or Decimal Vals are sent to 7 Seg
        output logic [15:0] bcd_real_out
    ); 
    
    logic [1:0] s;
    
    always_comb begin
        
        s[0] = hex_or_BCD_decider;
        s[1] = storage_enable;

        case (s)
            2'b00: bcd_real_out = BCD_vals;
            2'b01: bcd_real_out = hex_vals;     // If only top PB is pressed sends hex values
            2'b10: bcd_real_out = stored_BCD;   // If storage (right PB) is pressed sends stored BCD values
            2'b11: bcd_real_out = stored_hex;   // If both top and right PB are pressed sends stored hex values
            default: bcd_real_out = BCD_vals;   // If nothing is pressed sends current BCD values
            endcase              
    end

endmodule
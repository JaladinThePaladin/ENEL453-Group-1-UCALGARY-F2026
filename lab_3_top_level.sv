module lab_3_top_level (
    input  logic        clk,
    input  logic        reset,
    input logic         top_PB,     //PB used for bcd_7_hex_mux module
    input logic         bottom_PB,  // PB used for switches_pause module
    input  logic [15:0] switches_inputs, // slide switches (0 towards Basys3 board edge, 1 towards board center)
    output logic        CA, CB, CC, CD, CE, CF, CG, DP, // segment outputs (active-low) 
    output logic [15:0] led, // mapped to the LEDs above the slide switches, LEDs: write a 1 to light LED, 0 to turn it off
    output logic        AN1, AN2, AN3, AN4 // anode outputs for digit selection (active-low)
);

    // Internal signal declarations
    logic [15:0] switches_outputs;
    logic [15:0] storage_hex_vals; 
    logic [15:0] bcd_intermediary;
    logic [15:0] seg_inputs;
    logic [15:0] storage_BCD_vals;
    logic top_PB_result;
    logic bottom_PB_result;
    
    // Instantiate components

    switch_logic SWITCHES (
        .clk(clk),
        .switches_inputs( switches_inputs),
        .switches_outputs(switches_outputs)
    );
    
    debounce_bottomPB DEBOUNCE_PB_BOTTOM (
        .clk(clk), .reset(reset),     // input clock and synchronous active high reset 
        .button(bottom_PB),          // input signal to be debounced  
        .result(bottom_PB_result)          // debounced signal      
    );
    
    debounce_topPB DEBOUNCE_PB_TOP (  
        .clk(clk), .reset(reset),     // input clock and synchronous active high reset 
        .button(top_PB),          // input signal to be debounced  
        .result(top_PB_result)          // debounced signal    
    );
    
    switch_pause SWITCH_PAUSE (
        .clk(clk), .reset(reset),               // clk and reset
        .storage_ON     ( bottom_PB_result),                // Enables new hex value to be stored
        .switches_inputs( switches_outputs),        // Takes input directly from switches 
        .storage_vals(    storage_hex_vals)        // Output is frozen switches values or just passed through the module
    );
    
    bin_to_bcd BIN_TO_BCD ( 
        .clk(clk), .reset(reset),     // clk and reset 
        .storage_ON( bottom_PB_result),               // When bottom_PB is pushed storage vals are displayed
        .stored_BCD(     storage_BCD_vals),   // Stored BCD values from the module
        .bin_in(         switches_outputs),  // Set switches_inputs to be configured as BCD_inputs 
        .bcd_out(        bcd_intermediary)  // Set switches_outputs to be configured as BCD_outputs
    );

    bcd_7_hex_mux BCD_HEX_MUX (
        .storage_enable  (bottom_PB_result),                      // When bottom_PB is pushed storage vals are displayed
        .BCD_vals        (bcd_intermediary),              // BCD decimal outputs
        .stored_BCD      (storage_BCD_vals),              // BCD stored values gotten from bin_to_bcd module
        .stored_hex      (storage_hex_vals),  // Hex stored values gotten from storage module
        .hex_vals        (switches_outputs),             // Represents hexidecimal values
        .bcd_real_out       (seg_inputs),                 //  What values 7 segment display recieves
        .hex_or_BCD_decider (top_PB_result)                     //   Takes top button signal for multiplexor module
    );

    seven_segment_display_subsystem SEVEN_SEGMENT_DISPLAY(
        .reset(reset), .clk(clk),
        .AN1(AN1), .AN2(AN2), .AN3(AN3), .AN4(AN4),
        .CA( CA), .CB(  CB), .CC(  CC), .CD(  CD), .CE(CE), .CF(CF), .CG(CG), .DP(DP),
        .sec_dig1(seg_inputs[3:0]),
        .sec_dig2(seg_inputs[7:4]),
        .min_dig1(seg_inputs[11:8]),
        .min_dig2(seg_inputs[15:12])
    );
      
    assign led = switches_outputs;
    

endmodule
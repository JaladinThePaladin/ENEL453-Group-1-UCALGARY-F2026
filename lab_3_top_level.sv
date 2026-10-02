
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
    logic [15:0] switches_pause_intermediary; 
    logic [15:0] bcd_intermediary;
    logic [15:0] seg_inputs;
    
    // Instantiate components

    switch_logic SWITCHES (
        .clk(clk),
        .switches_inputs( switches_inputs),
        .switches_outputs(switches_outputs)
    );
    
    switch_pause SWITCH_PAUSE (
        .clk(clk), .reset(reset),                   // clk and reset
        .paused_vals( switches_outputs),             // Takes input directly from switches
        .bottom_PB(   bottom_PB),                   // PB that decides whether values are paused (enable signal?)
        .sent_vals(   switches_pause_intermediary)  // Output is frozen switches values or just passed through the module
    );
    
    bin_to_bcd BIN_TO_BCD ( 
        .clk(clk), .reset(reset),     // clk and reset 
        .bin_in(      switches_pause_intermediary),  // Set switches_inputs to be configured as BCD_inputs 
        .bcd_out(     bcd_intermediary)  // Set switches_outputs to be configured as BCD_outputs
    );

    bcd_7_hex_mux BCD_HEX_MUX (
        .decimal_vals    (bcd_intermediary),    // BCD decimal outputs
        .hex_vals        (switches_pause_intermediary),    // Represents hexidecimal values
        .bcd_real_out    (seg_inputs),        //  What values 7 segment display recieves
        .decider         (top_PB)            //   Takes top button signal for multiplexor module
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
// Testbench for switch_pause

`timescale 1ns/1ps

module switch_pause_tb; 

    // parameters
    parameter CLK_PERIOD = 10; // 10 ns = 100 MHz

    // Testbench Signals
    logic                   clk;
    logic                   reset;
    logic                   bottom_PB;
    logic [15:0]            switches_outputs;
    logic [15:0]            storage_hex_vals;

    // Instantiate the DUT
    switch_pause DUT (
        .clk                (clk                ),
        .reset              (reset              ),
        .storage_ON         (bottom_PB          ),
        .switches_inputs    (switches_outputs   ), // switches_outputs is the synchronized storage_inputs
        .storage_vals       (storage_hex_vals   )
    );

    // Generate 100 MHz Clock
    always #(CLK_PERIOD / 2) clk = ~clk;

    // Test Sequence
    initial begin

        // Initial Values 
        clk             = 0;
        reset           = 1;
        bottom_PB       = 0;
        switches_outputs    = 16'd0;

        // Test reset
        # CLK_PERIOD;
        reset           = 0;

        // Test 1: Store a Value
        switches_outputs = 16'd25;
        bottom_PB       = 1;

        # CLK_PERIOD;

        bottom_PB       = 0;

        // Test 2: Change switches WITHOUT pressing the button
        // This means that storage_vals should remain 25
        switches_outputs = 16'd100;

        # (2*CLK_PERIOD);

        // Test 3: Press button to store the new Value
        bottom_PB    = 1;

        # (2*CLK_PERIOD);

        bottom_PB       = 0;

        // Change switches again
        // This will show that the stored value should remain 100
        switches_outputs = 16'd500;

        # (2*CLK_PERIOD);


        $stop;
    
    end

endmodule
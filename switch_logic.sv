module switch_logic (
    input  logic        clk,
    input  logic [15:0] switches_inputs,
    output logic [15:0] switches_outputs 
);
    
    SWITCH_SYNC SWITCH_SYNC(
        .clk(clk),
        .switches_inputs( switches_inputs),
        .switches_outputs(switches_outputs)
    );

endmodule

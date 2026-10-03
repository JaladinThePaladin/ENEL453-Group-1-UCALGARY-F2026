`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/24/2026 12:44:57 AM
// Design Name: 
// Module Name: two_input_multiplexer_tb
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


module two_input_multiplexer_tb();
    
    parameter DELAY = 10;
    
    // Testbench signals
    logic [15:0] input_0;
    logic [15:0] input_1;
    logic        select;
    logic [15:0] mux_output;
    
    // Instantiate the mux
    two_input_multiplexer MUX (
        .input_0     (input_0      ),
        .input_1     (input_1      ),
        .select      (select       ),
        .mux_output  (mux_output)
    );    
    
    // Test stiumulus
    initial begin
        
        // Inital values
        input_0 = 16'h0000;
        input_1 = 16'h0000;
        select  = 1'b0;
        
        #DELAY;
        
        // Test alternating A5 pattern
        input_0 = 16'hA5A5;
        input_1 = 16'h5A5A;
        select = 1'b0;
        
        #DELAY;
        
        // Select input_1
        select = 1'b1;
        
        #DELAY;
        
        // STOP
        $stop;
        
    end
endmodule

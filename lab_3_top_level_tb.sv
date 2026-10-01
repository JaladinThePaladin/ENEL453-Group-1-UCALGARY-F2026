`timescale 1ns / 1ps

module lab_3_top_level_tb();

    // Parameters
    parameter CLK_PERIOD = 10; // 100ns for 100MHz clock To also follow GSR guidelines

    // Signals
    logic [15:0] switches_inputs;

    logic [15:0] led;
    
    logic clk;
    logic reset;
    logic top_PB;
    
    logic CA, CB, CC, CD, CE, CF, CG, DP;
    logic AN1, AN2, AN3, AN4;
    

    // Instantiate the Unit Under Test (UUT)
    lab_2_top_level uut (
        .switches_inputs(switches_inputs),
        .led(led),
        .AN1(AN1), .AN2(AN2), .AN3(AN3), .AN4(AN4),
        .CA( CA), .CB(  CB), .CC(  CC), .CD(  CD), .CE(  CE), .CF(  CF), .CG(  CG), .DP(  DP),
        .clk(clk), .reset(reset),
        .top_PB(top_PB)
    );

  
    // Test stimulus
    initial begin
        // Clock
        clk = 0;
        forever #(CLK_PERIOD / 2) clk = ~clk;
    end
    
    initial begin    
        // Initialize inputs
        reset = 1;
        switches_inputs = 16'b0;
        top_PB = 1'b1;
        #(5 * CLK_PERIOD);
        
        reset = 0;
        
        
        //Test batch 1 (top_PB is pressed)
        // Test case 1:
        top_PB = 1'b1;
        switches_inputs = 16'b0000_0000_0000_0000; #CLK_PERIOD;
        
        // Test case 2:
        switches_inputs = 16'b1111_1111_1111_1111; #CLK_PERIOD;

        // Test case 2:
        switches_inputs = 16'b0101_0101_0101_0101; #CLK_PERIOD;

        // Test case 3:
        switches_inputs = 16'b1010_1010_1010_1010; #CLK_PERIOD;
        
        // Test case 4:
        switches_inputs = 16'b1100_1100_1100_1100; #CLK_PERIOD;
        
        // Test case 5:
        switches_inputs = 16'b0011_0011_0011_0011; #CLK_PERIOD;
        
         //Test batch 2 (top_PB is not pressed)
        // Test case 1:
        top_PB = 1'b0;
        switches_inputs = 16'b0000_0000_0000_0000; #CLK_PERIOD;
        
        // Test case 2:
        switches_inputs = 16'b1111_1111_1111_1111; #CLK_PERIOD;

        // Test case 2:
        switches_inputs = 16'b0101_0101_0101_0101; #CLK_PERIOD;

        // Test case 3:
        switches_inputs = 16'b1010_1010_1010_1010; #CLK_PERIOD;
        
        // Test case 4:
        switches_inputs = 16'b1100_1100_1100_1100; #CLK_PERIOD;
        
        // Test case 5:
        switches_inputs = 16'b0011_0011_0011_0011; #CLK_PERIOD;       
        // End simulation
        #(5 * CLK_PERIOD);
        $stop;
    end

    // Optional: Monitor changes
    initial begin
        $monitor("Time = %0t: switches_inputs = %b, led = %b", 
                 $time, switches_inputs, led);
    end

endmodule
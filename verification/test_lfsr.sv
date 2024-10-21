module test_lfsr;
    logic clk;
    logic nreset;
    logic [14:0] out;

    lfsr lfsr15 (
        .clk(clk),
        .nreset(nreset),
        .out(out)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 0
        nreset = 1;

        #5
        nreset = 0;

        #5
        nreset = 1;
        
        #200
        $finish;
    end


    initial begin
        $monitor("Time: %0t | nReset: %b | LFSR Output: %b", 
            $time, nreset, out);
    end

endmodule

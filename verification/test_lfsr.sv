module test_lfsr;
    logic clk;
    logic reset_n;
    logic [14:0] out;

    lfsr lfsr15 (
        .clk(clk),
        .reset_n(reset_n),
        .out(out)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 0;
        reset_n = 1;

        #5
        reset_n = 0;

        #5
        reset_n = 1;
        
        #200
        $finish;
    end


    initial begin
        $monitor("Time: %0t | reset_n: %b | LFSR Output: %b", 
            $time, reset_n, out);
    end

endmodule

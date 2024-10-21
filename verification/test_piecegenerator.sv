module test_piecegenerator;
    logic clk, nreset, ready;
    logic [2:0] piece;
    integer file;

    piecegenerator pcgen (
        .clk(clk),
        .nreset(nreset),
        .ready(ready),
        .piece(piece)
    );

    always #10 clk = ~clk;

    initial begin
        clk = 0;
        nreset = 1;

        #5
        nreset = 0;

        #5
        nreset = 1;

        #1000000
        $fclose(file);
        $finish;
    end
    
    initial begin
        file = $fopen("/tmp/piecegen.csv");
    end

    always @(posedge clk) begin
        if(ready)
            $fwrite(file, "%d,",piece);
            $display("Time: %0t | nReset: %b | Ready: %b | Piece: %d",
                $time, nreset, ready, piece);
    end

endmodule

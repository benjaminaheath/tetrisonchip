module test_randombag;
    logic clk;
    logic nreset;
    logic newbag;
    logic ready;
    logic [20:0] pieces;

    integer file;

    randombag ranbag0 (
        .clk(clk),
        .nreset(nreset),
        .newbag(newbag),
        .ready(ready),
        .pieces(pieces)
    );

    always #5 clk = ~clk;

    task automatic get_new_bag;
        // kick off a new bag generation
        newbag = 1;
        // wait for the ready signal out
        @(posedge ready);
        // write out the piecess to a file
        $fwrite(file, "%d,%d,%d,%d,%d,%d,%d\n",
            pieces[2:0], pieces[5:3], pieces[8:6],
            pieces[11:9], pieces[14:12], pieces[17:15],
            pieces[20:18]);
        newbag = 0;
        #10;
    endtask

    initial begin
        $monitor("time: %0t | newbag: %b | ready: %b | pieces %b",
            $time, newbag, ready, pieces);
    end 

    initial begin
        clk = 0;
        nreset = 1;
        file = $fopen("/tmp/piecesgen.csv");

        #5
        nreset = 0;

        #5
        nreset = 1;
        
        //for(int i = 0; i <10; i++) begin
            get_new_bag();
        //end

        $fclose(file);
        $finish;
    end

endmodule

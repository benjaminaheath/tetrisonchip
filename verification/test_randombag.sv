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

    task automatic get_new_bag;
        // kick off a new bag generation
        newbag = 1;
        #10
        newbag = 0;
        // wait for the ready signal out
        @(posedge ready);
        // write out the piecess to a file
        $fwrite(file, "%d,%d,%d,%d,%d,%d,%d\n",
            pieces[2:0], pieces[5:3], pieces[8:6],
            pieces[11:9], pieces[14:12], pieces[17:15],
            pieces[20:18]);
        $display("Bag:{%d,%d,%d,%d,%d,%d,%d}\n",
            pieces[2:0], pieces[5:3], pieces[8:6],
            pieces[11:9], pieces[14:12], pieces[17:15],
            pieces[20:18]);
        #10;
    endtask

    initial begin
        //$monitor("time: %0t | newbag: %b | ready: %b | pieces %b\nnewpiece: %b | piecebits %b",
        //    $time, newbag, ready, pieces, ranbag0.newpiece, ranbag0.piecebits);
    end 

    always #5 clk = ~clk;

    int n_bags;
    int totals [6:0];
    real bag [6:0];
    real averages [6:0];

    initial begin
        clk = 0;
        nreset = 1;
        newbag = 0;
        file = $fopen("/tmp/piecesgen.csv");

        #5
        nreset = 0;

        #5
        nreset = 1;


        n_bags = 10000;
        for(int i = 0; i < n_bags; i++) begin
            get_new_bag();

            bag[0] = pieces[2:0];
            bag[1] = pieces[5:3];
            bag[2] = pieces[8:6];
            bag[3] = pieces[11:9];
            bag[4] = pieces[14:12]; 
            bag[5] = pieces[17:15];
            bag[6] = pieces[20:18];
            for(int i = 0; i <=6; i++) begin
                totals[i] += bag[i];
            end 
        end

        for(int i = 0; i <= 6; i++) begin
            averages[i] = totals[i] / n_bags;
        end
        $display("Bag Averages after %d bags: {%f,%f,%f,%f,%f,%f,%f}",
            n_bags, averages[0],averages[1],averages[2],averages[3],
            averages[4],averages[5],averages[6]);

        $fclose(file);
        $finish;
    end

    initial begin
        #10000000
        $error("Reached 100,000 ticks, ending.");
        $fatal;
    end

endmodule

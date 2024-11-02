module test_board;
    logic clk;
    logic wnr;
    logic reset_n;
    logic [4:0] rowid;
    logic [19:0] in;
    logic [19:0] out;
    logic [4:0] i;

    board board (
        .clk(clk),
        .wnr(wnr),
        .reset_n(reset_n),
        .rowid(rowid),
        .in(in),
        .out(out)
    );

    always #1 clk = ~clk;

    initial begin
        clk = 0;
        reset_n = 1;
        wnr = 0;
        rowid = '0;
        #2
        reset_n = 0;
        #2
        reset_n = 1;
        #2
        for(i=0; i<30; i++) begin
            #2
            rowid = i;
            in = {'0, i};
            wnr = 1;
            #2
            wnr = 0;
        end
        #2
        wnr = 0;
        
        #10
        $finish;
    end


    initial begin
        $monitor("Time: %0t | reset_n: %b | wnr: %b | rowid : %b | in: %b | out: %b", 
            $time, reset_n, wnr, rowid, in, out);
    end

endmodule

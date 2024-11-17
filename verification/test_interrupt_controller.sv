module test_interrupt_controller;
    logic left;
    logic right;
    logic down;
    logic up;
    logic select;
    logic start;
    logic a;
    logic b;
    logic [3:0] interrupt;

    interrupt_controller ic (
        .left(left),
        .right(right),
        .down(down),
        .up(up),
        .select(select),
        .start(start),
        .a(a),
        .b(b),
        .interrupt(interrupt)
    );

    //always #1 clk = ~clk;

    initial begin
        a       = 0;
        b       = 0;
        left    = 0;
        right   = 0;
        down    = 0;
        up      = 0;
        select  = 0;
        start   = 0;
        #2
        left = 1;
        #2
        down = 1;
        #2
        left = 0;
        #2
        down = 0;
        a = 1;        
        #10
        $finish;
    end


    initial begin
        $monitor("Time: %0t | left: %b | down: %b | a: %b | b: %b | interrupt: %b", 
            $time, left, down, a, b, interrupt);
    end

endmodule

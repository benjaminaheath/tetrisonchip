module controller (
    input logic clk,
    input logic reset_n,
    input logic interrupt
);
    logic newbag;
    logic ready;
    logic [20:0] pieces;
    logic [2:0] curpiece; 

    randombag bag1 (
        .clk(clk),
        .reset_n(reset_n),
        .newbag(newbag),
        .ready(ready),
        .pieces(pieces)
    );

endmodule


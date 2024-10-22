module controller (
    input logic clk,
    input logic nreset
);
    logic newbag;
    logic ready;
    logic [20:0] pieces;
    logic [2:0] curpiece; 

    randombag bag1 (
        .clk(clk),
        .nreset(nreset),
        .newbag(newbag),
        .ready(ready),
        .pieces(pieces)
    );

endmodule


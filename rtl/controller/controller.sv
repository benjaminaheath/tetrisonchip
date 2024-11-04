module controller (
    input logic clk,
    input logic nreset
);
    logic newbag;
    logic ready;
    logic [20:0] pieces;

    randombag bag0 (
        .clk(clk),
        .nreset(nreset),
        .newbag(newbag),
        .ready(ready),
        .pieces(pieces)
    );

endmodule


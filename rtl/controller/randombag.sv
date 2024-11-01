module randombag (
    input logic clk,
    input logic nreset,
    input logic newbag,
    output logic ready,
    output logic [20:0] pieces
);
    logic newpiece;
    logic [2:0] piecebits;

    lfsr # (.SEED(15'h2A5)) bitgen0 (
            .clk(clk), 
            .nreset(nreset), 
            .out(piecebits[0]));
    lfsr # (.SEED(15'h6B5)) bitgen1 (
            .clk(clk), 
            .nreset(nreset), 
            .out(piecebits[1]));
    lfsr # (.SEED(15'hDB7)) bitgen2 (
            .clk(clk), 
            .nreset(nreset), 
            .out(piecebits[2]));

    bag piecebag (
            .clk(clk),
            .nreset(nreset),
            .newbag(newbag),
            .newpiece(newpiece),
            .piece(piecebits),
            .done(ready),
            .bag(pieces)
        );

    always_latch @(clk, nreset, ready) begin
        if(!nreset | ready) begin
            newpiece <= 0;
        end else begin
            if(newbag | ready)
                newpiece <= 1;
        end
    end

endmodule


module piecegenerator (
    input logic clk,
    input logic nreset,
    output logic ready,
    output logic [2:0] piece
);

    logic [2:0][14:0] bitsout;

    lfsr # (.SEED(15'h6A5)) bitgen0
        (.clk(clk), 
            .nreset(nreset), 
            .out(bitsout[0])
        );
    lfsr # (.SEED(15'h6A5)) bitgen1
        (.clk(clk), 
            .nreset(nreset), 
            .out(bitsout[1])
        );
    lfsr # (.SEED(15'hDB7)) bitgen2
        (.clk(clk), 
            .nreset(nreset), 
            .out(bitsout[2])
        );

    logic [2:0] piecebits;
    assign piecebits = {bitsout[0][0], bitsout[1][0], bitsout[2][0]};

    always_ff @(posedge clk or negedge nreset) begin
        if(!nreset) begin // reset state of piece generator
            ready <= 0;
            piece <= 3'b0;
        end else begin // check the new generated piece is valid
            if (piecebits != 3'b111) begin
                ready <= 1;
                piece <= piecebits;
            end else begin
                ready <= 0;
                piece <= 3'bZZZ;
            end
        end
    end

endmodule

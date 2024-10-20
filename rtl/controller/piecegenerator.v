module piecegenerator (
    input enable, 
    input clk,
    input nreset,
    output reg ready,
    output reg [2:0] piece
);

    wire [2:0][14:0] bitsout;
    lfsr # (0xB6F)
        bitgen0
        (.clk(clk), 
            .nreset(nreset), 
            .out(bitsout[0])
        );
    lfsr # (0x6A5)
        bitgen1
        (.clk(clk), 
            .nreset(nreset), 
            .out(bitsout[1])
        );
    lfsr # (0xDB7)
        bitgen2
        (.clk(clk), 
            .nreset(nreset), 
            .out(bitsout[2])
        );

    wire [2:0] piecebits;
    assign piecebits = {bitsout[0][0], bitsout[1][0], bitsout[2][0]};

    always @(posedge clk or negedge nreset) begin
        if(!nreset) begin // reset state of piece generator
            ready <= 0;
            piece <= 3'b0;
            piececount <= 3'b0;
        end else begin // check the new generated piece is valid
            ready <= (piecebits != 3'b111)
            piece <= piecebits;
        end
    end

endmodule

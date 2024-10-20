module piecegenerator #(
    localparam num_pieces
) (
    input enable, 
    input clk,
    input nreset,
    output ready,
    output [3*num_pieces:0] bits
);

lfsr bitgen (.clk(clk), .nreset(nreset), .bit(bit)); // LFSR bit generator

always @(clk) begin
end

endmodule

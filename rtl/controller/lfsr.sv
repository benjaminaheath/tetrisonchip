module lfsr #(
    parameter SEED = 15'b1
) (
    input logic clk,
    input logic nreset,
    output logic out
);

    logic [14:0] bits;
    assign out = bits[0];

    logic tap1, tap2;
    assign tap1 = bits[0] ^ bits[13];
    assign tap2 = bits[0] ^ bits[14];

    always_ff @(posedge clk or negedge nreset) begin
        if(!nreset) bits <= SEED;
        else        bits <= {bits[12:0], tap1, tap2};
    end

endmodule
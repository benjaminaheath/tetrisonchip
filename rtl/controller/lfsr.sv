module lfsr #(
    parameter SEED = 15'b1
) (
    input logic clk,
    input logic nreset,
    output logic [14:0] out
);

    logic tap1, tap2;
    assign tap1 = out[0] ^ out[13];
    assign tap2 = out[0] ^ out[14];

    always_ff @(posedge clk or negedge nreset) begin
        if(!nreset) out <= SEED;
        else        out <= {out[12:0], tap1, tap2};
    end

endmodule

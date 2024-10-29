module bag(
    input logic clk,
    input logic nreset,
    input logic newbag,
    input logic [2:0] piece,
    output logic done,
    output logic [2:0] bag [6:0]
);

    logic [6:0] bagflags;

    assign done = &bagflags;

    always_ff @(posedge clk, posedge newbag, negedge nreset) begin
        if (!nreset | newbag) begin
            bag <= '0;
            bagflags <= '0;
        end else begin
            if (!bagflags[piece]) begin
                bagflags[piece] <= 1;
                bag <= {piece,bag[5:0]};
            end
        end
    end

endmodule


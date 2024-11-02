module bag(
    input logic clk,
    input logic nreset,
    input logic newbag,
    input logic newpiece,
    input logic [2:0] piece,
    output logic done,
    output logic [20:0] bag
);

    logic [6:0] bagflags;

    assign done = &bagflags;

    always_ff @(posedge clk, posedge newbag, negedge nreset) begin
        if (!nreset or newbag) begin
            bag <= '0;
            bagflags <= '0;
        end else begin
            if (piece != 3'b111 & bagflags[piece] == 0 & newpiece) begin
                bagflags[piece] <= 1;
                bag <= {piece,bag[20:3]};
            end
        end
    end

endmodule


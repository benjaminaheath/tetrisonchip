module randombag (
    input logic clk,
    input logic nreset,
    input logic newbag,
    output logic ready,
    output logic [20:0] pieces
);
    logic newpiece;
    logic [2:0] piecebits;

    lfsr # (.SEED(15'd1)) bitgen0 (
            .clk(clk), 
            .nreset(nreset), 
            .out(piecebits[0]));
    lfsr # (.SEED(15'd15)) bitgen1 (
            .clk(clk), 
            .nreset(nreset), 
            .out(piecebits[1]));
    lfsr # (.SEED(15'd31)) bitgen2 (
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
            .bag(pieces));

    //an internal register to clock in the 'newpiece' signal
    //hold the newpiece signal high from clock edge until done
    always_ff @(posedge clk, negedge nreset, posedge ready) begin
        if(!nreset) begin
            newpiece <= 0;
        end else begin
            if(newbag & !newpiece) begin
                newpiece <= 1;
            end else if(ready) begin
                newpiece <= 0;
            end
        end
    end

endmodule


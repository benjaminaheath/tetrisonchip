module randombag (
    input logic clk,
    input logic reset_n,
    input logic newbag,
    output logic ready,
    output logic [20:0] pieces
);
    logic newpiece;
    logic [2:0] piecebits;

    lfsr # (.SEED(15'd1)) bitgen0 (
            .clk(clk), 
            .reset_n(reset_n), 
            .out(piecebits[0]));
    lfsr # (.SEED(15'd15)) bitgen1 (
            .clk(clk), 
            .reset_n(reset_n), 
            .out(piecebits[1]));
    lfsr # (.SEED(15'd31)) bitgen2 (
            .clk(clk), 
            .reset_n(reset_n), 
            .out(piecebits[2]));

    bag piecebag (
            .clk(clk),
            .reset_n(reset_n),
            .newbag(newbag),
            .newpiece(newpiece),
            .piece(piecebits),
            .done(ready),
            .bag(pieces));

    //an internal register to clock in the 'newpiece' signal
    //hold the newpiece signal high from clock edge until done
    always_ff @(posedge clk, negedge reset_n, posedge ready) begin
        if(!reset_n) begin
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


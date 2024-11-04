module pieces (
    input logic clk,
    input logic nreset,
    input logic newpiece,       // Get next piece
    output logic ready,         // At least 1 bag is ready
    output logic [2:0] piece    // Active piece
); 
    logic [1:0] newbags;        // Request a new bag of pieces
    logic [1:0] bagready;       // Bag of pieces is ready
    logic [20:0] [1:0] pieces;  // Output wires to pieces

    logic activebag;            // Boolean for which bag is active
    logic newactivebag;         // Flag for when a new bag request issued
    logic [2:0] piececount;     // Count the pieces which have been used

    randombag # (.SEED1(15'd1),
                 .SEED2(15'd15),
                 .SEED3(15'd31)) bag0 (
                .clk(clk),
                .nreset(nreset),
                .newbag(newbags[0]),
                .ready(bagready[0]),
                .pieces(pieces[0]));
    randombag # (.SEED1(15'd63),
                 .SEED2(15'd127),
                 .SEED3(15'd255)) bag1 (
                .clk(clk),
                .nreset(nreset),
                .newbag(newbags[1]),
                .ready(bagready[1]),
                .pieces(pieces[1]));

    // Assign ready out the ready flag of the active bag
    assign ready = bagready[activebag];

    // Assign the active piece out as the active bag piece and 
    // a slice based on the active piece count
    assign piece = pieces[activebag][2*piececount+2:2*piececount];

    // When a new piece is requested:
    //  Point the active bag and piece count toward next piece
    //  Every time we run out of a bag, switch to the next one
    always_ff @(posedge clk, negedge nreset) begin
        if(!nreset) begin
            activebag <= 0;     // Reset the active bag to 0
            piececount <= 0;    // Reset the active piece to 0
            newactivebag <= 1;  // Reset new active bag flag to 1
        end else begin
            if(newpiece) begin
                if(piececount == 3'd6)  begin
                    piececount      <= 0;
                    activebag       <= ~activebag;
                    newactivebag    <= 1;
                end else 
                    piececount <= piececount + 1;
                end
            end
        end
    end

    // Bag request controller
    // Request a new bag on the bag that isn't active right now
    // Single cycle request, then wait
    always_ff @(posedge clk, negedge nreset) begin
        if(!nreset) begin
            newbags <='1;
        end else begin
            if(newactivebag) begin
                newbags[activebag]  <= 0;
                newbags[~activebag] <= 1;
                newactivebag        <= 0;
            end
        end
    end

endmodule


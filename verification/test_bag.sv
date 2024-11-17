module test_bag;

    logic clk;
    logic reset_n;
    logic newbag;
    logic newpiece;
    logic [2:0] piece;
    logic done;
    logic [20:0] bag;

    bag bag0(
        .clk(clk),
        .reset_n(reset_n),
        .newbag(newbag),
        .newpiece(newpiece),
        .piece(piece),
        .done(done),
        .bag(bag));
    
    logic [6:0] test_flags;

    task automatic drive_piece(
        logic [2:0] new_piece);
        
        piece = new_piece;
        newpiece = 1;
        #10;
    endtask

    task automatic check_piece(
        logic [6:0] flags);

        assert(bag0.bagflags == flags)
        else $error("Bag Flags (%b) != Flags (%b)", 
            bag0.bagflags, flags);
    endtask

    always #5 clk = ~clk;

    initial begin
        $monitor("Time: %0t |\nNewbag: %b | Newpiece: %b | Done: %b |\nPiece: %d (%b) | Bag %b |\nFlags %b | test_flags %b",
            $time, newbag, newpiece, done, piece, piece, bag, bag0.bagflags, test_flags);
    end

    initial begin
        clk = 0;
        reset_n = 1;
        newbag = 0;
        piece = 0;
        newpiece = 0;

        #10
        reset_n = 0;
        
        #5
        reset_n = 1;

        // Assert bag is emptied
        assert(bag == '0)
        else $error("Bag string not zero on init");
        //else $error("Bag (%s) != {0,0,0,0,0,0,0}",
        //    get_bag_string(bag));

        // Assert done flag is lowered
        assert(!done)
        else $error("Done flag not lowered at start");
        
        test_flags = '0;
        for(int i = 7; i >= 0 ; i--) begin
            drive_piece(i);
            test_flags[i] = 1;
            check_piece(test_flags);
        end
        newpiece = 0;

        // Assert all flags have been raised
        assert(bag0.bagflags == 7'b1111111)
        else $error("Bag flags not all raised after all pieces");
        //else $error("Bag Flags (%b) != 7'b11111111",
        //            bag0.bagflags);
               
        // Assert done flag is raised
        assert(done)
        else $error("Done flag not raised after all pieces");
        //else $error("Done (%b) != 1", 
        //            done);

        // Assert bag is as expected
        assert(bag == {3'd0,3'd1,3'd2,3'd3,3'd4,3'd5,3'd6})
        else $error("Bag is not {6,5,4,3,2,1,0}");
        //else $error("Bag (%s) != {6,5,4,3,2,1,0}",
        //    get_bag_string(bag));

        #10
        // Clear bag and generate new bag
        newbag = 1;
        
        #10
        // Assert bag is emptied
        assert(bag == '0)
        else $error("Bag is not emptied after new bag raise");
        //else $error("Bag (%s) != {0,0,0,0,0,0,0}",
        //    get_bag_string(bag));
        
        // Assert done flag is lowered after reset
        assert(!done)
        else $error("Done flag not lowered after reset");
        
        $display("End of test_bag.sv.");
        $finish;
    end

endmodule

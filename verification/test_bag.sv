module test_bag;

    logic clk;
    logic nreset;
    logic newbag;
    logic [2:0] piece;
    logic done;
    logic [2:0] bag [6:0];

    bag bag0(
        .clk(clk),
        .nreset(nreset),
        .newbag(newbag),
        .piece(piece),
        .done(done),
        .bag(bag));
    
    logic [6:0] test_flags;

    function automatic string get_bag_string(logic [2:0] bag);
        string bag_string = "";

        foreach (bag[i])
            if(i!=6) bag_string = {bag_string, $sformatf("%0d,",bag[i])};
            else bag_string = {bag_string, $sformatf("%0d",bag[i])};

        return bag_string;
    endfunction

    task automatic drive_piece(
        logic [2:0] piece, 
        logic [6:0] flags);

        piece = i;
        flags[i] = piece;
        #10;
    endtask

    task automatic check_piece(
        logic [6:0] flags);

        assert(bag0.bagflags == flags)
        else $error("Bag Flags (%b) != Flags (%b)", 
            bag0.bagflags, flags);
    endtask

    always #10 clk = ~clk;

    initial begin
        clk = 0;
        nreset = 1;
        newbag = 0;
        piece = 0;

        #5
        nreset = 1;
        
        #5
        nreset = 0;

        // Assert bag is emptied
        assert(bag == '0)
        else $error("Bag string not zero on init");
        //else $error("Bag (%s) != {0,0,0,0,0,0,0}",
        //    get_bag_string(bag));

        // Assert done flag is lowered
        assert(!done)
        else $error("Done flag not lowered at start");
        
        test_flags = '0;
        for(int i = 0; i < 8; i++) begin
            drive_piece(i, flags);
            check_piece(flags);
        end

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
        assert(bag == {6,5,4,3,2,1,0})
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
        $stop("Everything passed.");
    end

endmodule

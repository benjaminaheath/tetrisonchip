`include "include/part.sv"
module chip(

);

board_mem prev_state(.*);
board_mem curr_state(.*);

interrupt_controller ic (
        .left(left),
        .right(right),
        .down(down),
        .up(up),
        .select(select),
        .start(start),
        .a(a),
        .b(b),
        .interrupt(interrupt)
    );

controller controller (
    .clk(1'b0),
    .reset_n(1'b1),
    .interrupt(interrupt)
)

endmodule
module interrupt_controller(
    input logic left,
    input logic right,
    input logic down,
    input logic up,
    input logic select,
    input logic start,
    input logic a,
    input logic b,
    output logic [3:0] interrupt
);
    typedef enum logic [3:0] {
        DO_NOTHING  = 4'd0,
        MOVE_LEFT   = 4'd1,
        MOVE_RIGHT  = 4'd2,
        MOVE_DOWN   = 4'd3,
        MOVE_UP     = 4'd4,
        SELECT      = 4'd5,
        START       = 4'd6,
        ROTATE_CW   = 4'd7,
        ROTATE_CCW  = 4'd8 
    } interrupts_t;

    logic [7:0] inputs;
    assign inputs = {b,a,start,select,up,down,right,left};

always@(inputs)
    case(inputs)
        8'b0000_0001: interrupt <= MOVE_LEFT;
        8'b0000_0010: interrupt <= MOVE_RIGHT;
        8'b0000_0100: interrupt <= MOVE_DOWN;
        8'b0000_1000: interrupt <= MOVE_UP;
        8'b0001_0000: interrupt <= SELECT;
        8'b0010_0000: interrupt <= START;
        8'b0100_0000: interrupt <= ROTATE_CW;
        8'b1000_0000: interrupt <= ROTATE_CCW;
        default:      interrupt <= DO_NOTHING;
    endcase

endmodule
typedef enum logic [2:0] {
    I_Block = 3'b000, // I-shaped Tetromino
    O_Block = 3'b001, // O-shaped Tetromino
    T_Block = 3'b010, // T-shaped Tetromino
    J_Block = 3'b011, // J-shaped Tetromino
    L_Block = 3'b100, // L-shaped Tetromino
    S_Block = 3'b101, // S-shaped Tetromino
    Z_Block = 3'b110  // Z-shaped Tetromino
} Block;

import Board, Piece

class Game:
    def __init__(self):
        self.Board = Board()
        self.Piece = Piece()
        self.Score = 0
        self.RowsCompleted = 0
        self.Level = 0
        self.GameOver = False
        self.Pause = False

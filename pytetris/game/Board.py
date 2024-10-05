
class BoardTile:

    def __init__(self, texture: str) -> None:
        self.Texture = texture

    def __str__(self) -> str:
        return self.Texture

class Board:
    
    @classmethod
    def __init__(self, width: int = 10, height: int = 20) -> None:
        self.Width = width
        self.Height = height
        self.Board = [[BoardTile('.') for _ in range(width)] for _ in range(height)]

    @classmethod
    def __str__(self) -> str:
        rows = []
        for h in range(self.Height):
            rowstr = str()
            for w in range(self.Width):
                rowstr += str(self.Board[h][w])
            rows.append(rowstr)
        return '\n'.join(rows)
                
                

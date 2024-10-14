import random
import copy

pieces = {
    1: [[0,0,0,0],[0,0,0,0],[0,0,0,0],[1,1,1,1]],
    2: [[1,1,1],[1,0,0],[0,0,0]],
    3: [[1,1,1],[0,0,1],[0,0,0]],
    4: [[1,1,1],[0,1,0],[0,0,0]],
    5: [[1,1,0],[0,1,1],[0,0,0]],
    6: [[0,1,1],[1,1,0],[0,0,0]],
    7: [[1,1],[1,1]]
}

class Piece:
    def __init__(self):
        """Initialise the piece"""
        self.piece = pieces[random.randint(1,7)]

    def rotate(self):
        """Rotate the piece"""
        n = len(self.piece)
        copy_piece = copy.deepcopy(self.piece)
        for i in range(n):
            for j in range(n):
                copy_piece[j][n-1-i] = self.piece[i][j]
        self.piece = copy_piece

    def render(self):
        """Display the piece in text"""
        for row in self.piece:
            print(''.join('X' if col else ' ' for col in row))
        print()
    
    def bottommost(self):
        """Calculate the bottom boundary for each piece column"""
        n = len(self.piece)
        bottom = [-1] * n
        for i in range(n):
            for j in range(n-1, -1, -1):
                if self.piece[j][i]:
                    bottom[i] = j
                    break
                
        return bottom

    def leftmost(self):
        """Calculate the left boundary for each piece row"""
        n = len(self.piece)
        left = [-1] * n
        for i in range(n):
            for j in range(n):
                if self.piece[i][j]:
                    left[i] = j
                    break
        return left
    
    def rightmost(self):
        """Calculate the right boundary for each piece row"""
        n = len(self.piece)
        right = [-1] * n
        for i in range(n):
            for j in range(n-1,-1,-1):
                if self.piece[i][j]:
                    right[i] = j
                    break
        return right
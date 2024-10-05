import sys
from Tetromino import Tetromino
from Board import Board


if __name__=='__main__':
    Shapes = { 'o', 'l', 's', 'z', 'L', 'J', 'T' }
    for s in Shapes:
        shape = Tetromino(s)
        for _ in range(4):
            print(shape,end='\n')
            shape.RotateRight()
            print("")
        print("\n")


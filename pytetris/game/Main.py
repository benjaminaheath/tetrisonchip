import sys
from Tetromino import Tetromino


if __name__=='__main__':
    Shapes = { 'o', 'l', 's', 'z', 'L', 'J', 'T' }
    for s in Shapes:
        shape = Tetromino(s)
        print(f'==={s}===')
        for _ in range(4):
            print(shape)
            shape.RotateLeft()

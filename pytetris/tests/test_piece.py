import pytest
from game import Piece, pieces

@pytest.fixture
def piece():
    """Fixture to create a new Piece for testing"""
    return Piece(1)

@pytest.mark.parametrize("piece_type",[1,2,3,4,5,6,7])
def test_piece_init(piece_type):
    piece = Piece(piece_type)
    assert piece.piece == pieces[piece_type]


#
#def test_piece_random_init():
#    piece = Piece

def test_rotate_right(piece):
    piece.RotateRight()
    assert [[1,0,0,0],[1,0,0,0],[1,0,0,0],[1,0,0,0]] == piece.piece

def test_rotate_left(piece):
    piece.RotateLeft()
    assert [[0,0,0,1],[0,0,0,1],[0,0,0,1],[0,0,0,1]] == piece.piece

def test_rotate_right_left(piece):
    piece.RotateRight()
    piece.RotateLeft()
    assert [[0,0,0,0],[0,0,0,0],[0,0,0,0],[1,1,1,1]]== piece.piece
    

def test_rotate_left_right(piece):
    piece.RotateLeft()
    piece.RotateRight()
    assert [[0,0,0,0],[0,0,0,0],[0,0,0,0],[1,1,1,1]]== piece.piece

def test_bottommost(piece):
    assert [3,3,3,3] == piece.Bottommost()

def test_leftmost(piece):
    assert [-1, -1, -1, 0] == piece.Leftmost()

def test_rightmost(piece):
    assert [-1, -1, -1, 3] == piece.Rightmost()

@pytest.mark.parametrize("rotate", ["rotate_right","rotate_left"])
def test_boundary_after_rotate(piece, rotate):
    if rotate == 'rotate_right': 
        piece.RotateRight()
        assert piece.Rightmost() == [0,0,0,0] 
        assert piece.Leftmost() == [0,0,0,0] 
        assert piece.Bottommost() == [3,-1,-1,-1]

    elif rotate == 'rotate_left':
        piece.RotateLeft()
        assert piece.Rightmost() == [3,3,3,3]
        assert piece.Leftmost() == [3,3,3,3]
        assert piece.Bottommost() == [-1,-1,-1,3]

    
def test_piece_after_four_rotations(piece):
    for _ in range(4): piece.RotateRight()
    assert [[0,0,0,0],[0,0,0,0],[0,0,0,0],[1,1,1,1]]== piece.piece
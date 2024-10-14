import pytest
from game.Piece import Piece

@pytest.fixture
def piece():
    """Fixture to create a new Piece for testing"""

@pytest.mark.parametrize("piece_type",[1,2,3,4,5,6,7])
def test_piece_init(piece_type):
    pass

def test_piece_random_init():
    pass

def test_rotate_right(piece):
    pass

def test_rotate_left(piece):
    pass

def test_rotate_right_left(piece):
    pass

def test_rotate_left_right(piece):
    pass

def test_bottommost(piece):
    pass

def test_leftmost(piece):
    pass

def test_rightmost(piece):
    pass

@pytest.mark.parametrize("rotate", ["rotate_right","rotate_left"])
def test_boundary_after_rotate(piece, rotate):
    pass

def test_piece_after_four_rotations(piece):
    pass
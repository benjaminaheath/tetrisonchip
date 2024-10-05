class Tetromino:

    @classmethod
    def __init__(self, shape: str) -> None:
        self.Shapes = { 'o', 'l', 's', 'z', 'L', 'J', 'T' }
        self.Pieces = {
            'o': {
                0:   ((1,1), (1,2), (2,1), (2,2)),
                90:  ((1,1), (1,2), (2,1), (2,2)),
                180: ((1,1), (1,2), (2,1), (2,2)),
                270: ((1,1), (1,2), (2,1), (2,2))
            },
            'l': { # this one is a bit different and might need a 2x4 matrix
                0:   ((0,2), (1,2), (2,2), (2,3)),
                90:  ((2,0), (2,1), (2,2), (2,3)),
                180: ((0,2), (1,2), (2,2), (2,3)),
                270: ((2,0), (2,1), (2,2), (2,3))
            },
            's': {
                0:   ((0,1), (1,1), (1,2), (2,2)),
                90:  ((0,2), (0,3), (1,1), (1,2)),
                180: ((0,1), (1,1), (1,2), (2,2)),
                270: ((0,2), (0,3), (1,1), (1,2))
            },
            'z': {
                0:   ((0,2), (1,2), (1,1), (2,1)),
                90:  ((1,1), (1,2), (2,2), (2,3)),
                180: ((0,2), (1,2), (1,1), (2,1)),
                270: ((1,1), (1,2), (2,2), (2,3))
            },
            'L': {
                0:   ((0,1), (0,2), (1,2), (2,2)),
                90:  ((0,3), (1,3), (1,2), (1,1)),
                180: ((0,1), (1,1), (2,1), (2,2)),
                270: ((1,1), (1,2), (1,3), (2,1))
            },
            'J': {
                0:   ((0,2), (1,2), (2,2), (2,1)),
                90:  ((0,1), (1,1), (1,2), (1,3)),
                180: ((0,1), (0,2), (1,1), (2,1)),
                270: ((1,1), (1,2), (1,3), (2,3))
            },
            'T': {
                0:   ((0,2), (1,2), (1,1), (2,2)),
                90:  ((0,2), (1,1), (1,2), (1,3)),
                180: ((0,1), (1,1), (2,1), (1,2)),
                270: ((1,1), (1,2), (1,3), (2,2))
            }

        }
        if shape not in self.Shapes: return

        self.Shape = shape
        self.Rotation = 0

    @classmethod
    def RotateRight(self)-> None:
        """
        Rotate the piece right by 90 degrees
        """
        if self.Rotation < 270: self.Rotation += 90
        else:                   self.Rotation  = 0

    @classmethod
    def RotateLeft(self) -> None:
        """
        Rotate the piece left by 90 degrees
        """
        if self.Rotation > 0: self.Rotation -= 90
        else:                 self.Rotation  = 270

    @classmethod
    def GetVector(self) -> tuple[tuple]:
        """
        Return 2x4 matrix representing the offsets of each piece of the
        tetromino based on the piece type and the rotation
        """
        # Get initial 
        return self.Pieces[self.Shape][self.Rotation]

    def __str__(self):
        vec = self.GetVector()
        return str(vec)
        



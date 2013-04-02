var block;
var component

function finishObject() {
    block = component.createObject(root);
}

function spawnBlock() {
    var blocks = ["O.qml", "I.qml", "T.qml", "L.qml", "J.qml", "S.qml",
                  "Z.qml"];
    var i = Math.floor(Math.random() * blocks.length);
    component = Qt.createComponent(blocks[i]);
    if (component.status === Component.Ready)
        finishObject()
    else
        component.statusChanged.connect(finishObject);

    grid.currentPiece = block;

    var array = block.shape;

    for (var j in array) {
        var xval = (array[j].x);
        var yval = (array[j].y);
        var index = (xval-1)*10 + yval-1;
        matrix.itemAt(index).color=block.color;
        matrix.itemAt(index).occupied=true;
    }
}

function gravity() {
    // TODO: determine which blocks should be allowed to fall.
    var validBlocks = matrix;

    for (var i = validBlocks.count - 1; i >= 0; i--) {
        var square = validBlocks.itemAt(i);
        if (square === undefined) {
            continue;
        }

        if (grid.currentPiece !== null) {
            for (var j in grid.currentPiece.shape) {
                if (j.x === square.x && j.y === square.y) {
                    (j.y)++;
                    break;
                }
                else {
                    continue;
                }
            }
        }

        var newSquare = validBlocks.itemAt(i + 10);

        if (square.occupied) {
            square.occupied = false;

            if (newSquare !== null) {
                if (newSquare.occupied) {
                    print("Overwriting block!");
                }
                else {
                    newSquare.occupied = true;
                }
                newSquare.color = square.color;
            }
            else {
                print("Falling off the board!");
            }

            square.color = "black";
        }
    }
}

var block;
var component

function getIndex(x, y) {
    return (y-1)*10 + x-1;
}

function getX(index) {
    return (index%10)+1;
}

function getY(index) {
    return Math.floor(index/10)+1;
}

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
        var index = getIndex(xval, yval);
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
        var squareX = getX(square.idx);
        var squareY = getY(square.idx);

        if (grid.currentPiece !== null) {
            var shape = grid.currentPiece.shape;
            var newshape = new Array(shape.length);
            for (var j = 0; j < shape.length; j++) {
                var point = shape[j];
                if (point.x === squareX && point.y === squareY) {
                    newshape[j] = Qt.point(point.x, ++point.y);
                }
                else {
                    newshape[j] = point;
                }
            }
            grid.currentPiece.shape = newshape;
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

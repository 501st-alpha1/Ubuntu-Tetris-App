var block;
var component;

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

    var quit = false;
    for (var j in array) {
        var xval = (array[j].x);
        var yval = (array[j].y);
        var index = getIndex(xval, yval);
        var square = matrix.itemAt(index);

        if (square.occupied) {
            print("You lose!");
            Qt.quit();
            break;
        }

        square.color=block.color;
        square.occupied=true;
    }
}

function isCurrentPiece(index) {
    if (grid.currentPiece !== null) {
        var shape = grid.currentPiece.shape;
        for (var i = 0; i < shape.length; i++) {
            var point = shape[i];
            if (point.x === getX(index) && point.y === getY(index)) {
                return true;
            }
        }
    }
    return false;
}

function recursiveGravityCheck(square) {
    if (!square.occupied)
        return

    var index = square.idx;
    var left = matrix.itemAt(index - 1);
    var right = matrix.itemAt(index + 1);
    var up = matrix.itemAt(index - 10);
    var down = matrix.itemAt(index + 10);

    square.gravity = false;

    if (left !== null && left.gravity && !isCurrentPiece(index-1)) {
        recursiveGravityCheck(left);
    }
    if (right !== null && right.gravity && !isCurrentPiece(index+1)) {
        recursiveGravityCheck(right);
    }
    if (up !== null && up.gravity) {
        if (isCurrentPiece(index - 10))
            grid.currentPiece = null;
        recursiveGravityCheck(up);
    }
    if (down !== null && down.gravity && !isCurrentPiece(index+10)) {
        recursiveGravityCheck(down);
    }
}

function instaDrop() {
    while (grid.currentPiece !== null) {
        gravity();
    }
}

function gravity() {
    if (grid.currentPiece === null) {
        spawnBlock();
        return;
    }

    //Reset gravity
    for (var m = 0; m < 200; m++) {
        matrix.itemAt(m).gravity = true;
    }

    for (var k = 0; k < 10; k++) {
        var index = getIndex(k+1, 20);
        recursiveGravityCheck(matrix.itemAt(index));
    }

    var validBlocks = new Array(0);
    for (var l = 0; l < 200; l++) {
        var temp = matrix.itemAt(l);
        if (temp.occupied && temp.gravity) {
            validBlocks.push(temp);
        }
    }

    //for (var i = validBlocks.count - 1; i >= 0; i--) {
    while (validBlocks.length > 0) {
        var square = validBlocks.pop();
        if (square === undefined) {
            continue;
        }
        var squareX = getX(square.idx);
        var squareY = getY(square.idx);

        var shape = grid.currentPiece.shape;
        var newshape = new Array(shape.length);

        if (isCurrentPiece(square.idx)) {
            for (var j = 0; j < shape.length; j++) {
                var point = shape[j];
                var idx = getIndex(point.x, point.y);
                if (square.idx === idx) {
                    newshape[j] = Qt.point(point.x, ++point.y);
                }
                else {
                    newshape[j] = point;
                }
            }
            grid.currentPiece.shape = newshape;
        }

        var newSquare = matrix.itemAt(square.idx + 10);

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

    clearLineCheck();
}

function clearLineCheck() {
    for (var i = 0; i < 20; i++) {
        var full = true;
        for (var j = 0; j < 10; j++) {
            var index = getIndex(j+1, i+1);

            if (isCurrentPiece(index)) {
                full = false;
                break;
            }

            if (!matrix.itemAt(index).occupied) {
                full = false;
                break;
            }
        }

        if (full) {
            setLineColor(i+1, "black");
        }
    }
}

function setLineColor(line, color) {
    for (var i = 1; i < 11; i++) {
        var index = getIndex(i, line);
        matrix.itemAt(index).occupied = false;
        matrix.itemAt(index).color = color;
    }
}

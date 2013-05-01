import QtQuick 2.0
import "Logic.js" as Logic

Rectangle {
    color: "black"
    property var shape
    property var centerIdx
    property point pos

    function moveLeft() {
        var array = new Array(shape.length);

        for (var i = 0; i < shape.length; i++) {
            var xval = shape[i].x;
            var yval = shape[i].y;
            if (xval > 1) {
                array[i] = Qt.point(--xval, yval);
            }
            else {
                //Edge of board, do nothing.
                return false;
            }
        }

        redraw(array);

        return true;
    }

    function moveRight() {
        var array = new Array(shape.length);

        for (var i = 0; i < shape.length; i++) {
            var xval = shape[i].x;
            var yval = shape[i].y;
            if (xval < 10) {
                array[i] = Qt.point(++xval, yval);
            }
            else {
                //Edge of board, do nothing.
                return false;
            }
        }

        redraw(array);

        return true;
    }

    function rotate() {
        var newshape = new Array(0);
        for (var i = 0; i < shape.length; i++) {
            if (i === centerIdx) {
                newshape.push(shape[centerIdx]);
                continue;
            }
            var diffx = shape[i].x - shape[centerIdx].x;
            var diffy = shape[i].y - shape[centerIdx].y;

            var changex = (diffy === 0) ? diffy : -diffy;
            var changey = (diffx === 0) ? -diffx : diffx;

            newshape.push(Qt.point(shape[centerIdx].x + changex, shape[centerIdx].y + changey));
        }

        redraw(newshape);
    }

    function redraw(array) {
        for (var i = 0; i < shape.length; i++) {
            var xval = (shape[i].x);
            var yval = (shape[i].y);
            var index = Logic.getIndex(xval, yval);
            var square = matrix.itemAt(index);
            if (array.indexOf(Qt.point(xval, yval)) === -1) {
                square.color="black"
                square.occupied=false;
            }

            xval = (array[i].x);
            yval = (array[i].y);
            index = Logic.getIndex(xval, yval);
            square = matrix.itemAt(index);
            matrix.itemAt(index).color=color;
            matrix.itemAt(index).occupied=true;
        }

        shape = array;
    }
}

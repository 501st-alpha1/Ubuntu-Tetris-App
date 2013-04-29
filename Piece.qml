import QtQuick 2.0
import "Logic.js" as Logic

Rectangle {
    color: "black"
    property var shape
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

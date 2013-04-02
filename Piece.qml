import QtQuick 2.0

Rectangle {
    color: "black"
    property var shape
    property point pos

    function moveLeft() {
        var array = shape;

        for (var i in array) {
            if (array[i].x > 1) {
                array[i].x--;
            }
            else {
                return false;
            }
        }

        redraw(array);

        return true;
    }

    function moveRight() {
        var array = shape;

        for (var i in array) {
            if (array[i].x < 10) {
                array[i].x++;
            }
            else {
                return false;
            }
        }

        redraw(array);

        return true;
    }

    function redraw(array) {
        for (var j in array) {
            var xval = (array[j].x);
            var yval = (array[j].y);

            var idx = shape.indexOf(Qt.point(xval, yval))

            if (idx === -1) {
                print("you lose!");
            }
            else {
                print(idx);
            }

            var index = (xval-1)*10 + yval-1;
            matrix.itemAt(index).color=color;
            matrix.itemAt(index).occupied=true;
        }

        shape = array;
    }
}

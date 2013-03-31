import QtQuick 2.0

Rectangle {
    color: "black"
    property var shape
    property point pos
    property bool isCurrent: false

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

        shape = array;
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

        shape = array;
        return true;
    }
}

import QtQuick 2.0

Rectangle {
    color: "orange"
    property var shape: [Qt.point(1,5), Qt.point(2,5), Qt.point(3,5),
        Qt.point(3,6)]
    property point pos: Qt.point(1,5)
}

import QtQuick 2.0

Rectangle {
    color: "green"
    property var shape: [Qt.point(1,5), Qt.point(1,6), Qt.point(2,4),
        Qt.point(2,5)]
    property point pos: Qt.point(1,5)
}

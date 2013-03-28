import QtQuick 2.0

Rectangle {
    color: "yellow"
    property var shape: [Qt.point(1,5), Qt.point(1,6), Qt.point(2,5),
        Qt.point(2,6)]
    property point pos: Qt.point(1,5)
}

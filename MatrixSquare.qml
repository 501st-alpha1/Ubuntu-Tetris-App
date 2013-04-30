import QtQuick 2.0

Rectangle {
    width: units.gu(4)
    height: units.gu(4)
    color: "black"
    border.color: "white"
    property bool occupied: false
    property int idx: 0
    property bool gravity: true
}

import QtQuick 2.0
import Ubuntu.Components 0.1
import "Logic.js" as Logic

MainView {
    applicationName: "Tetris"
    id: root

    width: units.gu(50)
    height: units.gu(90)

    Grid {
        columns: 10

        Repeater {
            id: matrix
            model: 200
            MatrixSquare {}
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: false
        onTriggered: Logic.spawnBlock()
    }
}

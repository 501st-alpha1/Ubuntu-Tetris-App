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
        focus: true

        Repeater {
            id: matrix
            model: 200
            MatrixSquare {}
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_Left) {
                print("Move left");
                event.accepted = true;
            }
            else if (event.key === Qt.Key_Right) {
                print("Move right");
                event.accepted = true;
            }
            else if (event.key === Qt.Key_Down) {
                print("Speed up");
                event.accepted = true;
            }
            else if (event.key === Qt.Key_Up) {
                print("Insta-drop");
                event.accepted = true;
            }
            else if (event.key === Qt.Key_Space) {
                print("Rotate");
                event.accepted = true;
            }
            else if (event.key === Qt.Key_Return) {
                Logic.spawnBlock();
                event.accepted = true;
            }
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: Logic.gravity();
    }
}

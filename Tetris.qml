import QtQuick 2.0
import Ubuntu.Components 0.1
import "Logic.js" as Logic

MainView {
    applicationName: "Tetris"
    id: root

    width: units.gu(40)
    height: units.gu(80)

    Grid {
        columns: 10
        focus: true
        id: grid
        property Piece currentPiece
        property Piece mainChunk
        property var brokenChunks

        Repeater {
            id: matrix
            model: 200
            MatrixSquare { idx: index }
        }

        Keys.onPressed: {
            if (event.key === Qt.Key_Left) {
                if (currentPiece !== null)
                    currentPiece.moveLeft();
                event.accepted = true;
            }
            else if (event.key === Qt.Key_Right) {
                if (currentPiece !== null)
                    currentPiece.moveRight();
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

import QtQuick 2.0
import Ubuntu.Components 0.1

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
        interval: 5000
        running: true
        repeat: false
        onTriggered: spawnBlock()
    }

    function spawnBlock() {
        var block;
        var component = Qt.createComponent("O.qml");
        if (component.status === Component.Ready)
            block = component.createObject(root);
        else
            component.statusChanged.connect(block = component.createObject(root));

        var array = block.shape;

        for (var i in array) {
            var xval = (array[i].x);
            var yval = (array[i].y);
            var index = (xval-1)*10 + yval-1;
            matrix.itemAt(index).color="yellow";
        }
    }
}

var block;
var component

function finishObject() {
    block = component.createObject(root);
}

function spawnBlock() {
    var blocks = ["O.qml", "I.qml"];
    var i = Math.floor(Math.random() * blocks.length);
    component = Qt.createComponent(blocks[i]);
    if (component.status === Component.Ready)
        finishObject()
    else
        component.statusChanged.connect(finishObject);

    var array = block.shape;

    for (var j in array) {
        var xval = (array[j].x);
        var yval = (array[j].y);
        var index = (xval-1)*10 + yval-1;
        matrix.itemAt(index).color="yellow";
    }
}

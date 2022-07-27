import QtQuick 2.0
import QtQuick.Window 2.2
Window {
    id: window
    width: 950
    height: 605
//    visible: true
    title: qsTr("场景切换")
    signal sendScenceMsgQml(string item)
    color: "#1A1A1B"
    Rectangle {
        anchors.fill: parent
        color: "#1A1A1B"
        Grid {
            id: grid
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.leftMargin: 30
            anchors.topMargin: 20

            layoutDirection: Qt.LeftToRight
//            spacing: 25
            rowSpacing: 10
            columnSpacing:50
            clip: false
            flow: Grid.TopToBottom
            rows: 0
            columns: 4
        }
    }
    function _addAutoScenceWidget(_motion,_path)
    {

        for(var i in _motion)
        {
            var component=Qt.createComponent("ScenceWidget.qml")
            if(component.status === Component.Ready){
                var newCompopnent=component.createObject(grid)
                newCompopnent._name=_motion[i]
                newCompopnent._path=_path
                newCompopnent.sendScenceMsgQml.connect(window.sendScenceMsgQml)

            }
        }
        return false
    }
    function _clearScenceWidget()
    {
        for(var i in grid.children)
        {
            grid.children[i].destroy()
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:16}
}
##^##*/

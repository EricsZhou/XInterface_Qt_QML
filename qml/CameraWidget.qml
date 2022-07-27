import QtQuick 2.0
import QtQuick.Controls 2.5

Item {
    id: root
    width: 300
    height: rectangle.height

    property string name:""
    signal sendCameraMsgQml(string camera,string motion)
    function _addMotionButton(_motion)
    {
        for(var i in _motion)
        {
            var component1=Qt.createComponent("CameraMotionButton.qml")
            if(component1.status === Component.Ready)
            {
                var newCompopnent1=component1.createObject(grid)
                newCompopnent1.width=90
                newCompopnent1.height=32
                newCompopnent1.text=qsTr(_motion[i])
                newCompopnent1.name=_motion[i]
                newCompopnent1.cameraname=name
                newCompopnent1.sendCameraMsgQml.connect(root.sendCameraMsgQml)
            }
        }
    }
    function _addCameraButton(_cameralist,_map,_path)
    {
        for(var i in _cameralist)
        {
            var component1=Qt.createComponent("CameraButton.qml")
            if(component1.status === Component.Ready)
            {
                var newCompopnent1=component1.createObject(cameragrid)
                newCompopnent1.width=110
                newCompopnent1.height=(_cameralist[i][0]==="横")?90:178
                newCompopnent1.name=""
                newCompopnent1.cameraname=_cameralist[i]
                newCompopnent1.map=_map
                newCompopnent1.path=_path
                newCompopnent1.bRow=(_cameralist[i][0]==="横")
                newCompopnent1.sendCameraMsgQml.connect(root.sendCameraMsgQml)
            }
        }
    }
    function _refresh(_camera,_motion)
    {
        for(var i in grid.children)
        {
            grid.children[i].destroy()
        }
        name=_camera
        _addMotionButton(_motion)
    }
    function _refreshTexture(_name,textureId)
    {
        for(var i in grid.children)
        {
//            grid.children[i].image.
        }
    }
    Rectangle {
        id: rectangle
        height: column.height
        color: "#303133"
        anchors.left: parent.left
        anchors.right: parent.right

        Column {
            id: column
            height: row.height+grid.height+cameragrid.height+image1.height+100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0


            Row {
                id: row
                width: 70
                height: 30
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 20


                Image {
                    id: image
                    width: 14
                    height: 10
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    source: "qrc:/Resource/Vector.png"
                    anchors.leftMargin: 0
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    id: text1
                    width: text1.contentWidth
                    color: "#ffffff"
                    text: qsTr(name)
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: image.right
                    anchors.top: parent.top
                    font.pixelSize: 14
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 6
                    anchors.topMargin: 0
                }
            }

            Grid {
                id: cameragrid
                width: 300
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: row.bottom
                columnSpacing: 20
                rowSpacing: 20
                columns: 2
                anchors.topMargin: 24
                anchors.leftMargin: 30
                anchors.rightMargin: 30
            }


            Image {
                id: image1
                height: 2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: cameragrid.bottom
                source: "qrc:/Resource/Line 1.png"
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 20
                sourceSize.height: 2
                sourceSize.width: 300
                fillMode: Image.PreserveAspectFit
            }

            Grid {
                id: grid
                width: 300
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: image1.bottom
                columnSpacing: 40
                rowSpacing: 20
                columns: 2
                anchors.topMargin: 20
                anchors.leftMargin: 30
                anchors.rightMargin: 30
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.9}
}
##^##*/

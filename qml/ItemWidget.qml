import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick3D 6.2

Rectangle {
    id:root
    width: 300
    height: 100
    color: "#303133"

    property string name: "name"
    property string path: "qrc:/qtquickplugin/images/template_image.png"

    signal sendItemMsgQml(string item)

    Row {
        id: row
        width: root.width
        height: root.height

        MyButton {
            id: button
            width: 100
            height: 32
            text: qsTr("使用")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 190
            anchors.topMargin: 51
            enabled: true


            onClicked: {root.sendItemMsgQml(root.name)}


        }

        Text {
            id: text1
            color: "#ffffff"
            text: qsTr(name)
            anchors.left: parent.left
            anchors.top: parent.top
            font.pixelSize: 14
            anchors.topMargin: 20
            anchors.leftMargin: 190
        }
        AnimatedImage {
            id: image
            width: 112
            height: 63
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            source: qsTr(path)

            playing: false
            MouseArea{
                id:mouse
                width: image.width
                height: image.height
                anchors.fill: image
                hoverEnabled: true
                onEntered: image.playing = true
                onExited: image.playing = false
            }


//            playing: mouse ? true:false
//            playing: true
            anchors.leftMargin: 20
            fillMode: Image.PreserveAspectFit

        }
    }

    Image {
        id: image1
        width: root.width
        height: 2
        anchors.bottom: parent.bottom
        source: "qrc:/Resource/Line 1.png"
        anchors.bottomMargin: 0
        fillMode: Image.PreserveAspectFit
    }

}

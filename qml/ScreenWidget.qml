import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle {
    id:root
    width: 300
    height: 128
    color: "#303133"

    property string name: ""
    property string type: "Screen"
    property string path: ""

    signal openScreenFileQml(string screen,string type)
    Row {
        id: row
        width: root.width
        height: root.height

        Column {
            id: column
            width: 60
            height: root.height
            anchors.left: parent.left
            anchors.leftMargin: 30

            Text {
                id: text1
                width: 70
                height: 20
                color: "#ffffff"
                text: qsTr(name)
                anchors.top: parent.top
                font.pixelSize: 14
                anchors.topMargin: 10
            }

            Image {
                id: image
                width: 144
                height: 81
                anchors.top: parent.top
                source: "file:///"+path
                anchors.topMargin: 36
                fillMode: Image.PreserveAspectFit
            }
        }

        MyButton {
            id: button
            width: 90
            height: 32
            text: {
                if(type==="Screen")
                   qsTr("切换视频")
                else if(type==="Poster")
                    qsTr("切换图片")
            }
            enabled: true
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.rightMargin: 20
            onClicked: {
                root.openScreenFileQml(root.name,root.type)
                image.source= "file:///"+root.path
            }
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



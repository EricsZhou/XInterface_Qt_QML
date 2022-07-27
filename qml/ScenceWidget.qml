import QtQuick 2.0
import QtQuick.Controls 2.5
Item {
    id: item1
    width: 180
    height: 140
    //    color:"#1A1A1B"
    property string _name: "name"
    property string _path: "qrc:/qtquickplugin/images/template_image.png"
    signal sendScenceMsgQml(string item)
    Rectangle{
        id: bordset
        width: 160
        height: 90
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 10
        anchors.topMargin: 10
//        bordset.border.color:"green"
//        bordset.width : 5
        Image {
            id: image
            anchors.fill: parent
            source: qsTr("file:"+_path+"/Resource/"+qsTr(text1.text)+".png")

        }

        MouseArea{
            anchors.fill: parent
            onClicked:{
                item1.sendScenceMsgQml(text1.text)
            }
//            onEntered: {
//                item1.width = 166
//                item1.height = 94
//                anchors.leftMargin = 7
//                anchors.topMargin = 8
//            }
//            onExited: {
//                item1.width = 160
//                item1.height = 90
//                anchors.leftMargin = 10
//                anchors.topMargin = 10

//            }
        }
    }

    Text {
        id: text1
        width: 100
        height: 22
        text: qsTr(_name)
        anchors.left: parent.left
        anchors.top: parent.top
        color: "#ffffff"
        font.pixelSize: 12
        anchors.topMargin: 110
        anchors.leftMargin: 10
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:2}
}
##^##*/

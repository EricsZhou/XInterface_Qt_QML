import QtQuick 2.0
import QtQuick.Controls 2.5
import QtMultimedia 5.9
//import PaintItemModule 1.0
Item {
    id: camerabutton

    property string cameraname:""
    property string name: ""
    property string map: "SmallStage_master"
    property string path:""
    property bool bRow:true
    signal sendCameraMsgQml(string camera,string motion)
    signal sendCameraMsgData(string data)
    signal timeoverImage()
    Column {
        id: column
        width: 110
        height:bRow?90:178
        Text {
            id: text1
            color: "#ffffff"
            text: qsTr(cameraname)
            font.pixelSize: 12
        }

        Image {
//        Rectangle{

            id: image
            width: bRow?110:90
            height: bRow?62:160
            anchors.top: text1.bottom
            horizontalAlignment: Image.AlignLeft
            verticalAlignment: Image.AlignTop
            source: "file:"+path+"/Resource/"+map+"/"+qsTr(cameraname)+".png"
            anchors.topMargin: 6

            fillMode: parent.Stretch

            MouseArea{
                anchors.fill: parent
                onClicked:{camerabutton.sendCameraMsgQml(cameraname,name)}
            }
//            PaintItem {
//                width:image.width
//                height:image.height
//                id: paintItem
//                transformOrigin: image.Center
//                anchors.horizontalCenter: parent.horizontalCenter
//                anchors.verticalCenter: parent.verticalCenter
//            }

        }
//        Connections{
//            target: CodeImage
//            onCallQmlRefeshImg:{
//                image.source = "file:"+path+"/Resource/"+map+"/"+qsTr(cameraname)+".png"
//            }
//        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.5;height:480;width:640}
}
##^##*/

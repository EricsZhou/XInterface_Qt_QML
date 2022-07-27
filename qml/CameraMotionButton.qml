import QtQuick 2.0
import QtQuick.Controls 2.5


MyButton {
    id: motionbutton

    property string cameraname:""
    property string name: ""
    signal sendCameraMsgQml(string camera,string motion)
    onClicked: sendCameraMsgQml(cameraname,name)
}




/*##^##
Designer {
    D{i:0;formeditorZoom:4;height:32;width:90}
}
##^##*/

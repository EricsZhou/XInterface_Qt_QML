import QtQuick 2.0
import QtQuick.Controls 2.5


MyButton {
    id: fbbutton

    property string cameraname:""
    property string name: ""
    signal sendFwMsgQml(string camera)
    onClicked: sendFwMsgQml(name)
}


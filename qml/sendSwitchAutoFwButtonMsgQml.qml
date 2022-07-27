import QtQuick 2.0
import QtQuick.Controls 2.5


MyButton {
    id: motionbutton

    property string cameraname:""
    property string name: ""
    signal sendSwitchAutoFwButtonMsgQml(string name)
    onClicked: sendSwitchAutoFwButtonMsgQml(name)
}


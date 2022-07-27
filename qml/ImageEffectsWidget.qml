import QtQuick 2.0
import QtQuick.Controls 2.5

Rectangle {
    id:root
    width: 300
    height: 60
    color: "#303133"

    signal sendSwitchAutoMotionImageEffectsMsgQml(bool checked)

    function _setAutoMotionState(_state)
    {
        switchbox.enabled=false;
        switchbox.checked=_state
        switchbox.enabled=true;
    }

    Row {
        id: row
        width: root.width
        height: root.height

        Switch {
            id: switchbox
            width: 100
            height: 32
            enabled: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.verticalCenterOffset: 0
            anchors.rightMargin: 30
            checked: false

            onCheckedChanged: {if(switchbox.enabled){root.sendSwitchAutoMotionImageEffectsMsgQml(switchbox.checked )}}


        }
        Text {
            id: text2
            color: "#ffffff"
            text: switchbox.checked?qsTr("开"):qsTr("关")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: switchbox.right
            font.pixelSize: 14
            anchors.leftMargin: 0
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id: text1
            color: "#ffffff"
            text: qsTr("镜像特效")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pixelSize: 14
            anchors.leftMargin: 30
            anchors.horizontalCenterOffset: 0
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}

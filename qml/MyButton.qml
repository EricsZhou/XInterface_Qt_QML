import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.impl 2.5
import QtQuick.Templates 2.5 as T
import QtTest 1.2

T.Button {
    id: button

    property color normalColor: "#717171"  //按钮颜色
//    property color pressColor: Qt.darker(normalColor)
    property color pressColor:"#17ACFF"

    contentItem: Text {
        text: button.text
        font.pixelSize:12
        color:"#ffffff"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background:Rectangle{
        implicitWidth:90
        implicitHeight: 32
        radius: 1
        color: button.down?pressColor:normalColor
        opacity:0.5
    }
    TestCase {
        id: testCase
        name: "MyTest"
        when: windowShown

        function test_click() {

        }
    } 
}


import QtQuick 2.7
import QtQuick.Controls 2.0
//import QtQuick.Layouts 1.0
import QtQuick.Templates 2.5 as T

T.Slider {
    id: control
       value: 0.5

       property color sliderColor: "white"

       background: Rectangle {
           x: control.leftPadding
           y: control.topPadding + control.availableHeight / 2 - height / 2
           implicitWidth: 200
           implicitHeight: 4
           width: control.availableWidth
           height: implicitHeight
           radius: 2
           color: Qt.darker(sliderColor)


           Rectangle {
               width: control.visualPosition * parent.width
               height: parent.height
               color: sliderColor
               radius: 2
           }
       }

       handle: Rectangle {
           x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
           y: control.topPadding + control.availableHeight / 2 - height / 2
           implicitWidth: 20
           implicitHeight: 20
           radius: 10
           color: sliderColor
           border.color: sliderColor

       }
}

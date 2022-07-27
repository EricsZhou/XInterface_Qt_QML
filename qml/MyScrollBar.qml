import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.impl 2.5
import QtQuick.Templates 2.5 as T


T.ScrollBar {
    id: control

    property color handleNormalColor: "darkCyan"  //按钮颜色
    property color handleHoverColor: Qt.lighter(handleNormalColor)
    property color handlePressColor: Qt.darker(handleNormalColor)

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 1 //背景整体size和handle的间隔
    visible: control.policy !== T.ScrollBar.AlwaysOff

    contentItem: Rectangle {
        implicitWidth: control.interactive ? 10 : 2
        implicitHeight: control.interactive ? 10 : 2

        radius: width / 2
        color: control.pressed
               ?handlePressColor
               :control.hovered
                 ?handleHoverColor
                 :handleNormalColor
        //修改为widgets那种alwayson/超出范围才显示的样子
        opacity:(control.policy === T.ScrollBar.AlwaysOn || control.size < 1.0)?1.0:0.0

    }

}


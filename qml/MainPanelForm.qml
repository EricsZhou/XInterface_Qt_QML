import QtQuick 2.1
import QtQuick.Controls 2.5
//import QtQuick.Controls.Material 2.3

Item {
    id: root
    width: 1040
    height: 680
    objectName: "QMLWindow"
    property color normalColor: "#717171"  //按钮颜色
    //    property color pressColor: Qt.darker(normalColor)
    property color pressColor:"#17ACFF"
    property int _SliderValue: 0
    signal sendSliderVlue(int a)
    Rectangle {
        id: rectangle
        color: "#1a1a1c"
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Row {
            id: row
            anchors.fill: parent
            anchors.bottomMargin: 20
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.topMargin: 20
            spacing: 40

            Column {
                id: column
                width: 320
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.topMargin: 0
                anchors.bottomMargin: 0


                Rectangle {
                    id: rectangle1
                    height: 90
                    color: "#303133"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0

                    Text {
                        id: text1
                        x: 60
                        y: 0
                        color: "#ffffff"
                        text: qsTr("机位控制")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        minimumPointSize: 12
                        minimumPixelSize: 12
                    }
                }


                Rectangle {
                    id: rectangle2
                    width: parent.width
                    color: "#303133"
                    anchors.top: rectangle1.bottom
                    anchors.bottom: rectangle7.top
                    anchors.topMargin: 2
                    anchors.bottomMargin: 2

                    ScrollView {
                        id: scrollView
                        x: 0
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.topMargin: 0
                        anchors.bottomMargin: 0

                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

                        ScrollBar.vertical: MyScrollBar {
                            parent: scrollView
                            x: scrollView.mirrored ? 1 : scrollView.width - width-1
                            y: scrollView.topPadding
                            z: 10
                            height: scrollView.availableHeight
                            active: scrollView.ScrollBar.horizontal.active
                            policy: ScrollBar.AsNeeded
                            handleNormalColor: "#717171"
                        }




                        Column {
                            id: cameraCol
                            width: 307
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 0
                            anchors.topMargin: 0
                        }
                    }
                    ChangeScen{
                        id:changeWidows
                    }
                    Button {
                        id: myButton
                        x: 0
                        width: 60
                        height: 30
                        anchors.right: parent.right
                        anchors.top: parent.top
                        clip: false
                        anchors.rightMargin: 26
                        anchors.topMargin: 20
                        text: qsTr("场景切换")
                        background: Rectangle{
                            color: normalColor
                        }
                        onClicked:
                        {
                            changeWidows.show()
                        }

                    }
                }

                Rectangle {
                    id: rectangle7
                    height:100
                    color: "#303133"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    ScrollView {
                        id: scrollView7
                        x: 0
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 5
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                        ScrollBar.vertical: MyScrollBar {
                            parent: scrollView7
                            x: scrollView7.mirrored ? 1 : scrollView7.width - width-1
                            y: scrollView7.topPadding
                            z: 10
                            height: scrollView7.availableHeight
                            active: scrollView7.ScrollBar.horizontal.active
                            policy: ScrollBar.AsNeeded
                            handleNormalColor: "#717171"
                        }
                        Column {
                            id: switchCol
                            width: parent.width
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 0
                            anchors.topMargin: 0
                        }
                    }
                }
            }

            Column {
                id: column1
                width: 320
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 340
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                Rectangle {
                    id: rectangle3
                    height: 90
                    color: "#303133"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    Text {
                        id: text2
                        x: 60
                        y: 0
                        color: "#ffffff"
                        text: qsTr("大荧幕")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        minimumPointSize: 12
                        minimumPixelSize: 12
                    }
                }

                Rectangle {
                    id: rectangle4
                    color: "#303133"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: rectangle3.bottom
                    anchors.bottom: rectangle8.top
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 20
                    anchors.leftMargin: 0
                    anchors.topMargin: 2
                    ScrollView {
                        id: scrollView1
                        x: 0
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                        ScrollBar.vertical: MyScrollBar {
                            parent: scrollView1
                            x: scrollView1.mirrored ? 1 : scrollView1.width - width-1
                            y: scrollView1.topPadding
                            z: 10
                            height: scrollView1.availableHeight
                            active: scrollView1.ScrollBar.horizontal.active
                            policy: ScrollBar.AsNeeded
                            handleNormalColor: "#717171"
                        }
                        Column {
                            id: screenCol
                            width: parent.width
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 0
                            anchors.topMargin: 0
                        }
                        anchors.topMargin: 0
                    }
                }

                Rectangle {
                    id: rectangle8
                    height: 90
                    color: "#303133"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: rectangle9.top
                    anchors.bottomMargin: 2
                    Text {
                        id: text4
                        x: 60
                        y: 0
                        width: 140
                        height: 14
                        color: "#ffffff"
                        text: "氛围切换"
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        minimumPointSize: 12
                        minimumPixelSize: 12
                    }
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                }

                Rectangle {
                    id: rectangle9
                    height: 180
                    color: "#303133"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    ScrollView {
                        id: scrollView3
                        x: 0
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 0
                        ScrollBar.vertical: MyScrollBar {
                            x: scrollView3.mirrored ? 1 : scrollView3.width - width-1
                            y: scrollView3.topPadding
                            height: scrollView3.availableHeight
                            parent: scrollView3
                            active: scrollView3.ScrollBar.horizontal.active
                            handleNormalColor: "#717171"
                            z: 10
                            policy: ScrollBar.AsNeeded
                        }
                        anchors.leftMargin: 0
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0

                        Grid {
                            id: grid
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.bottomMargin: 0
                            anchors.leftMargin: 39
                            anchors.topMargin: 20

                            layoutDirection: Qt.LeftToRight
                            spacing: 25
                            //                            rowSpacing: 1
                            //                            columnSpacing:1
                            clip: false
                            flow: Grid.TopToBottom
                            rows: 0
                            columns: 2

                        }
                    }
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                }
            }

            Column {
                id: column2
                width: 320
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 680
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                Rectangle {
                    id: rectangle5
                    height: 90
                    color: "#303133"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    Text {
                        id: text3
                        x: 60
                        y: 0
                        color: "#ffffff"
                        text: qsTr("互动道具")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        minimumPointSize: 12
                        minimumPixelSize: 12
                    }
                }

                Rectangle {
                    id: rectangle6
                    color: "#303133"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: rectangle5.bottom
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 2
                    anchors.bottomMargin: 0
                    ScrollView {
                        id: scrollView2
                        x: 0
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        anchors.leftMargin: 0
                        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                        ScrollBar.vertical: MyScrollBar {
                            parent: scrollView2
                            x: scrollView2.mirrored ? 1 : scrollView2.width - width-1
                            y: scrollView2.topPadding
                            z: 10
                            height: scrollView2.availableHeight
                            active: scrollView2.ScrollBar.horizontal.active
                            policy: ScrollBar.AsNeeded
                            handleNormalColor: "#717171"
                        }
                        Column {
                            id: itemCol
                            anchors.fill: parent
                        }
                        anchors.topMargin: 60
                    }

                    //                    Component
                    //                        {
                    //                            id: m_Slider
                    //                            Rectangle
                    //                            {
                    //                                implicitHeight:8
                    //                                color:"gray"
                    //                                radius:8
                    //                            }
                    //                        }

                    Text {
                        id: text5
                        width: 98
                        height: 15
                        color: "#ffffff"
                        text: qsTr("音乐可视化强度")
                        anchors.left: parent.left
                        anchors.top: parent.top
                        font.pixelSize: 12
                        anchors.leftMargin: 20
                        anchors.topMargin: 10
                    }

                    //                    Myslider {
                    //                        id: myslider
                    //                        x: 20
                    //                        width: 280
                    //                        height: 15
                    //                        anchors.top: parent.top
                    //                        stepSize: 0.01
                    //                        value: 0.01
                    //                        to: 0.31
                    //                        from: 0.01
                    //                        anchors.topMargin: 40
                    //                        sliderColor: "#ffffff"
                    //                    }

                    //                    Myslider {
                    //                        id: myslider
                    //                        x: 20
                    //                        width: 280
                    //                        height: 15
                    //                        anchors.top: parent.top
                    //                        anchors.topMargin: 40
                    //                        stepSize: 0.01
                    //                        value: 0.01
                    //                        to: 0.31
                    //                        from: 0.01

                    //                    }

                    Myslider {
                        id: myslider
                        x: 20
                        width: 280
                        height: 5
                        anchors.top: parent.top
                        anchors.topMargin: 40
                        from: 0
                        to:100
                        value: 0
                        stepSize: 1
                        onMoved: {
                            root.sendSliderVlue(myslider.position*myslider.to)
                        }
                    }

                    Text {
                        id: erroeText
                        x: -180
                        y: -92
                        width: erroeText.contentWidth
                        height: erroeText.contentHeight
                        color: "#ff0000"
                        text: qsTr(errorMsg)
                        font.pixelSize: 14
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

        }
    }


    ////////////////////////////////////////////
    property string errorMsg:""
    ////////////////////////////////////////////
    signal sendCameraMsgQml(string camera,string motion)
    signal openScreenFileQml(string screen,string type)
    signal sendItemMsgQml(string item)
    signal sendSwitchAutoMotionMsgQml(bool checked)
    signal sendSwitchAutoMotionMusicMsgQml(bool checked)
    signal sendSwitchAutoMotionImageEffectsMsgQml(bool checked)
    signal sendFwMsgQml(string name)
    signal sendScenceMsgQml(string name)

    ////////////////////////////////////////////
    function _addScrenceWidget(_motion,_path)
    {
        changeWidows._addAutoScenceWidget(_motion,_path)
//        changeWidows.sendScenceMsgQml.connect(root.sendScenceMsgQml)
    }
    function _SendScenMsg()
    {
        changeWidows.sendScenceMsgQml.connect(root.sendScenceMsgQml)
    }


    function _addCameraWidget(_name,_motion,_map,_path)
    {
        var component=Qt.createComponent("CameraWidget.qml")
        if(component.status === Component.Ready){
            var newCompopnent=component.createObject(cameraCol)
            newCompopnent.name=_name[0]
            newCompopnent.sendCameraMsgQml.connect(root.sendCameraMsgQml)
            newCompopnent._addMotionButton(_motion)
            newCompopnent._addCameraButton(_name,_map,_path)
            return true
        }
        return false
    }
    function _addScreenWidget(_name,_type)
    {
        var component=Qt.createComponent("ScreenWidget.qml")
        if(component.status === Component.Ready){
            var newCompopnent=component.createObject(screenCol)
            newCompopnent.name=_name
            newCompopnent.type=_type
            newCompopnent.openScreenFileQml.connect(root.openScreenFileQml)
            return true
        }
        return false
    }
    function _addItemWidget(_name,_path)
    {
        var component=Qt.createComponent("ItemWidget.qml")
        if(component.status === Component.Ready){
            var newCompopnent=component.createObject(itemCol)
            newCompopnent.name=_name
            newCompopnent.path="file:"+_path+"/Resource/"+qsTr(_name)+".gif"
            newCompopnent.sendItemMsgQml.connect(root.sendItemMsgQml)
            return true
        }
        return false
    }
    function _addAutoMotionWidget()
    {
        var component=Qt.createComponent("AutoMotionWidget.qml")
        if(component.status === Component.Ready){
            var newCompopnent=component.createObject(switchCol)
            newCompopnent.width=300
            newCompopnent.height=30
            newCompopnent.sendSwitchAutoMotionMsgQml.connect(root.sendSwitchAutoMotionMsgQml)
            return true
        }
        return false
    }
    function _addAutoMotionMusicWidget()
    {
        var component=Qt.createComponent("MusicSwitchForm.qml")
        if(component.status === Component.Ready){
            var newCompopnent=component.createObject(switchCol)
            newCompopnent.width=300
            newCompopnent.height=30
            newCompopnent.sendSwitchAutoMotionMusicMsgQml.connect(root.sendSwitchAutoMotionMusicMsgQml)
            return true
        }
        return false
    }
    function _addAutoMotionImageEffectsWidget()
    {
        var component=Qt.createComponent("ImageEffectsWidget.qml")
        if(component.status === Component.Ready){
            var newCompopnent=component.createObject(switchCol)
            newCompopnent.width=300
            newCompopnent.height=30
            newCompopnent.sendSwitchAutoMotionImageEffectsMsgQml.connect(root.sendSwitchAutoMotionImageEffectsMsgQml)
            return true

        }
        return false
    }
    function _addAutoFwbuttonWidget(_name)
    {
        var component=Qt.createComponent("FwButton.qml")
        if(component.status === Component.Ready){
            var newCompopnent=component.createObject(grid)
            newCompopnent.text=_name
            newCompopnent.name=_name
            newCompopnent.width=100
            newCompopnent.height=32

            newCompopnent.sendFwMsgQml.connect(root.sendFwMsgQml)
            return true
        }
        return false
    }
//    function _addAutoScenceWidget(_name,_path)
//    {
//        var component=Qt.createComponent("ScenceWidget.qml")
//        if(component.status === Component.Ready){
//            var newCompopnent=component.createObject(changeWidows)
//            newCompopnent.name=_name
//            newCompopnent.path="file:"+_path+"/Resource/"+qsTr(_name)+".png"
//            newCompopnent.width=180
//            newCompopnent.height=140

//            newCompopnent.sendScenceMsgQml.connect(root.sendScenceMsgQml)
//            return true
//        }
//        return false
//    }
    //TODO:
    function _addAutoFSliderWidget(_Value)
    {
        myslider.value = _Value
    }

    function _refreshCameraWidget(_camera,_motion)
    {
        cameraCol.children[0]._refresh(_camera,_motion)
    }
    function _setAutoMotionState(_state)
    {
        switchCol.children[0]._setAutoMotionState(_state)
    }
    function _clearSecnecWidget()
    {
        changeWidows._clearScenceWidget()
    }
    function _clearWidget()
    {
        for(var i in cameraCol.children)
        {
            cameraCol.children[i].destroy()
        }
        for(var j in screenCol.children)
        {
            screenCol.children[j].destroy()
        }
        for(var k in itemCol.children)
        {
            itemCol.children[k].destroy()
        }
        for(var m in switchCol.children)
        {
            switchCol.children[m].destroy()
        }
        for(var n in grid.children)
        {
            grid.children[n].destroy()
        }
//        for(var o in changeWidows.children)
//        {
//            changeWidows.children[o].destroy()
//        }
    }
    //////////////////////////////////////////////
    Component.onCompleted: {

    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/

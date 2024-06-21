import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

Window {
    id: mainWindow
    width: 800
    height: 480
    visible: true
    title: qsTr("Printer")
    color: "#455170"
    //flags: Qt.FramelessWindowHint

    // TODO add colors singleton

    component BarSelector: Item{
        property alias barColor: selectorBarHighlight.color
        property alias barWidth: selectorBarHighlight.width
        property alias text: selectorText.text
        property alias textColor: selectorText.color
        property alias textSize: selectorText.font.pixelSize
        property alias iconItem: selectorIcon.data

        property bool active: false
        property int selectorId


        property color textHighlightColor

        signal pressed()

        Rectangle{
            id: selectorHightlight
            width: parent.width - selectorBarHighlight.width
            height: parent.height
            color: Qt.tint(leftBar.color, Qt.rgba(0.4,0.4,1,0.1));
            opacity: 0.7
            visible: active
        }

        Rectangle{
            id: selectorBarHighlight
            x: selectorHightlight.width
            height: parent.height
            // anchors.right: selectorHightlight.right
            visible: active
        }

        Column {
            id: iconColumn
            anchors.centerIn: selectorHightlight
            spacing: 8
            Item{
                id:selectorIcon
                width: selectorHightlight.width/2
                height: selectorHightlight.width/2
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text{
                id: selectorText
                font.bold: true
            }
        }

        TapHandler {
            id: tapHandler
            onTapped: {
                parent.pressed();
            }
        }
    }

    Rectangle {
        id: leftBar
        width: 80
        height: parent.height
        color: "#2A3342"
        anchors.left: parent.left

        property int currentSelection: 1

        Rectangle {
            id: leftBarSeparator
            width: 5
            height: leftBar.height
            anchors.right: leftBar.right
            color: "#687DA2"
        }

        BarSelector{
            id: printSelector
            selectorId: 1
            active: leftBar.currentSelection === selectorId

            width: parent.width
            height: parent.height/3
            barWidth: leftBarSeparator.width
            anchors.left: parent.left
            barColor: "#4BE9FF"

            iconItem: Rectangle{
                width: 40
                height: width
                color: "#546286"
            }

            text: "PRINT"
            textColor: active ? "#7AEFFF" : "#546286"
            textSize: 13

            onPressed: {
                parent.currentSelection = Qt.binding(function() { return selectorId });
                // console.log("printSelector Button Pressed, current selection: ", parent.currentSelection);
            }
        }

        BarSelector{
            id: moveSelector
            selectorId: 2
            active: leftBar.currentSelection === selectorId

            y: parent.height/3
            width: parent.width
            height: parent.height/3
            barWidth: leftBarSeparator.width
            anchors.left: parent.left
            barColor: "#4BE9FF"

            iconItem: Rectangle{
                width: 40
                height: width
                color: "#546286"
            }

            text: "MOVE"
            textColor: active ? "#7AEFFF" : "#546286"
            textSize: 13

            onPressed: {
                parent.currentSelection = Qt.binding(function() { return selectorId });
                // console.log("moveSelector Button Pressed, current selection: ", parent.currentSelection);
            }
        }

        BarSelector{
            id: settingsSelector
            selectorId: 3
            active: leftBar.currentSelection === selectorId

            y: parent.height/3*2
            width: parent.width
            height: parent.height/3
            barWidth: leftBarSeparator.width
            anchors.left: parent.left
            barColor: "#4BE9FF"

            iconItem: Rectangle{
                width: 40
                height: width
                color: "#546286"
            }

            text: "SETTINGS"
            textColor: active ? "#7AEFFF" : "#546286"
            textSize: 13

            onPressed: {
                parent.currentSelection = Qt.binding(function() { return selectorId });
                // console.log("settingsSelector Button Pressed, current selection: ", parent.currentSelection);
            }
        }
    }

    Item {
        id: mainViewItem
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.25/2+parent.height*0.05
        anchors.left: leftBar.right
        anchors.leftMargin: 25

        Rectangle {
            id: mainView
            z: 10
            width: 300
            height: mainWindow.height*0.75
            radius: 20
            border.color: "#455170"
            border.width: 5
            color: "#2A3342"
            gradient: Gradient {
                        GradientStop { position: 0.1; color: "#3A4455" }
                        GradientStop { position: 0.8; color: "#1C212B" }
                    }
        }

        MultiEffect {
            id: mainViewDropShadow
            z: 3
            source: mainView
            anchors.fill: mainView
            shadowEnabled: true
            // shadowColor: "#191F2A"
            shadowColor: "#2D3544"
            shadowScale: 1
            shadowVerticalOffset: 12
            visible: true
        }

        MultiEffect {
            id: mainViewEmboss
            z: 2
            source:  mainView
            anchors.fill: mainView
            brightness: 0.3
            blurEnabled: true
            blurMultiplier: 2
            blur: 1
            visible: true
        }
    }

    component SpecialButton: Item {

        id: root
        property int size

        property color colorTint
        property color contourColor

        property alias shadowVisible: buttonDropShadow.visible
        property alias embossVisible: buttonEmboss.visible
        property alias shadowColor: buttonDropShadow.shadowColor
        property alias shadowOffset: buttonDropShadow.shadowVerticalOffset

        property bool showBorders: false

        signal switchPressed()
        signal switchReleased()

        // onSwitchPressed: {console.log("Button Pressed")}
        // onSwitchReleased: {console.log("Button Released")}

        width: size
        height: size

        MultiEffect {
            id: buttonEmboss
            source:  buttonOuter
            anchors.fill: parent
            blurEnabled: true
            blur: 1
            blurMax: 64
            // blurMultiplier: 3
            brightness: blurEnabled ? 0.4 : 0
        }

        MultiEffect {
            id: buttonDropShadow
            source: buttonOuter
            anchors.fill: parent
            shadowEnabled: true
            shadowVerticalOffset: 12
            // shadowScale: 1.02
        }

        Rectangle{
            id: checker
            width:parent.width
            height:parent.height
            anchors.fill: parent
            border.color: "red"
            border.width: 1
            //color: "transparent"
            color: Qt.rgba(0,0,0,0)
            visible: root.showBorders
        }

        Rectangle {
            id: buttonOuter
            width: parent.width
            height: width
            anchors.centerIn: parent
            visible: true
            radius: 30
            color: colorTint
            gradient: Gradient {
                GradientStop { position: 0.1; color: Qt.tint(colorTint, Qt.hsla(0,0,1,0.1)) }
                GradientStop { position: 1.0; color: Qt.tint(colorTint, Qt.hsla(0,0,0,0.2)) }
            }

            RoundButton {
                id: buttonContour
                width: buttonOuter.width*0.91
                height: buttonOuter.height*0.91
                radius: buttonOuter.radius-buttonOuter.radius*0.1
                anchors.centerIn: buttonOuter
                onPressed : root.switchPressed()
                onReleased : root.switchReleased()
                background: Rectangle {
                    id: buttonContourBkg
                    radius: parent.radius
                    anchors.fill: parent
                    // color: buttonContour.down ? contourColorPressed : contourColor
                    color: contourColor
                }
            }

            Rectangle {
                id: buttonBevel
                width: buttonContour.width*0.92
                height: buttonContour.height*0.92
                anchors.centerIn: buttonContour
                radius: buttonContour.radius - buttonContour.radius*0.1
                gradient: Gradient {
                    GradientStop { position: 0.1; color: Qt.tint(colorTint, Qt.hsla(0,0,1,0.25)) }
                    GradientStop { position: 1.0; color: Qt.tint(colorTint, Qt.hsla(0,0,0,0.4)) }
                }
                visible: true
            }

            Rectangle {
                id: buttonInner
                width: buttonBevel.width*0.92
                height: buttonBevel.height*0.92
                anchors.centerIn: buttonBevel
                radius: buttonBevel.radius - buttonBevel.radius*0.1
                gradient: Gradient {
                    GradientStop { position: 0.1; color: Qt.tint(colorTint, Qt.hsla(0,0,1,0.1)) }
                    GradientStop { position: 1.0; color: Qt.tint(colorTint, Qt.hsla(0,0,0,0.2)) }
                }
            }
        }
    }

    SpecialButton{
        id: stopButton
        size: 110
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 60
        anchors.bottomMargin: 60
        colorTint: "#455170"
        contourColor: "#161A23"
        shadowColor: "#2D3544"

        onSwitchPressed: {
                            stopIcon.visible = !stopIcon.visible;
                            startIcon.visible=!startIcon.visible;
                            if (stopIcon.visible)
                                contourColor = Qt.binding(function() { return "#7AEFFF" })
                            else
                                contourColor = Qt.binding(function() { return "#161A23" })
        }

        Rectangle {
            id: stopIcon
            width: stopButton.width*0.3
            height: width
            anchors.centerIn: parent
            radius: 6
            border.color: "#B4CBF5"
            border.width: 5
            color: "transparent"
            visible: false
        }

        Shape {
            id: startIcon
            antialiasing: true
            visible: true

            ShapePath {
                id: startButtonPath
                strokeColor: "#B4CBF5"
                strokeWidth: 5
                fillColor: "transparent"

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: startButton.width/2-10
                startY: startButton.width/2+16

                PathLine { x: startButtonPath.startX+26; y: startButtonPath.startY-16 }
                PathLine { x: startButtonPath.startX; y: startButtonPath.startY-32 }
                PathLine { x: startButtonPath.startX; y: startButtonPath.startY }
            }
        }
    }

    SpecialButton{
        id: startButton
        size: 110
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 220
        anchors.bottomMargin: 60
        colorTint: "#455170"
        contourColor: "#161A23"
        // shadowColor: "#2B3343"
        shadowColor: "#2D3544"


        property bool buttonPressed: false

        Rectangle {
            width: 6
            height: 38
            x: parent.width/2-16
            y: parent.width/2-height/2
            radius: 6
            color: "#B4CBF5"
        }

        Rectangle {
            width: 6
            height: 38
            x: parent.width/2+10
            y: parent.width/2-height/2
            radius: 6
            color: "#B4CBF5"
        }

        onSwitchPressed: {
                            buttonPressed = !buttonPressed
                            contourColor = Qt.binding(function() { return "#7AEFFF" })
        }
        onSwitchReleased:{
                            if (buttonPressed)
                                contourColor = Qt.binding(function() { return "#59BDC9" })
                            else
                                contourColor = Qt.binding(function() { return "#161A23" })
        }
    }
}

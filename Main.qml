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
    color: "#586E95"
    //flags: Qt.FramelessWindowHint

    Rectangle {
        id: leftBar
        width: 80
        height: parent.height
        color: "#2A3342"
        anchors.left: parent.left

        Rectangle {
            id: leftBarSeparator
            width: 5
            height: leftBar.height
            anchors.right: leftBar.right
            color: "#7F99C5"
        }
    }

    Item {
        id: mainViewItem
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.25/2+parent.height*0.05
        anchors.left: leftBar.right
        anchors.leftMargin: 20

        Rectangle {
            id: mainView
            z: 10
            width: 300
            height: mainWindow.height*0.75
            radius: 20
            border.color: "#7F99C5"
            border.width: 5
            color: "#2A3342"
            gradient: Gradient {
                        GradientStop { position: 0.3; color: "#6D82A5" }
                        GradientStop { position: 1.0; color: "#2A3342" }
                    }
        }

        MultiEffect {
            id: mainViewDropShadow
            z: 3
            source: mainView
            anchors.fill: mainView
            shadowEnabled: true
            shadowColor: "#191F2A"
            blurMultiplier: 1.2
            shadowVerticalOffset: 14
            visible: true
        }

        MultiEffect {
            id: mainViewEmboss
            z: 2
            source:  mainView
            anchors.fill: mainView
            brightness: 0.3
            blurEnabled: true
            blurMax: 32
            blur: 1
            visible: true
        }
    }

    component SpecialButton: Item {

        property int size
        property color colorTint

        property color contourColor
        property color contourColorPressed

        property alias shadowVisible: buttonDropShadow.visible
        property alias embossVisible: buttonEmboss.visible
        property alias shadowColor: buttonDropShadow.shadowColor
        property alias shadowOffset: buttonDropShadow.shadowVerticalOffset

        property bool showBorders: checker.visible = false

        // TODO add signals

        width: size
        height: size

        MultiEffect {
            id: buttonEmboss
            source:  buttonOuter
            anchors.fill: parent
            brightness: 0.5
            blurEnabled: true
            blurMax: 36
            blur: 1
            blurMultiplier: 2
        }

        MultiEffect {
            id: buttonDropShadow
            source: buttonOuter
            anchors.fill: parent
            shadowEnabled: true
            blurMultiplier: 1.2
            shadowVerticalOffset: 12
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
        }

        Rectangle {
            id: buttonOuter
            width: parent.width
            height: width
            radius: 30
            color: colorTint
            gradient: Gradient {
                // GradientStop { position: 0.1; color: Qt.rgba(97/255,119/255,157/255,1) }
                // GradientStop { position: 1.0; color: Qt.rgba(69/255,85/255,114/255,1) }
                GradientStop { position: 0.1; color: Qt.tint(colorTint, Qt.hsla(0,0,1,0.1)) }
                GradientStop { position: 1.0; color: Qt.tint(colorTint, Qt.hsla(0,0,0,0.2)) }
            }
            anchors.centerIn: parent
            visible: true

            RoundButton {
                id: buttonContour
                width: buttonOuter.width*0.91
                height: buttonOuter.height*0.91
                radius: buttonOuter.radius-buttonOuter.radius*0.1
                anchors.centerIn: buttonOuter
                onPressed : {console.log("Button Pressed")}
                onReleased : {console.log("Button Released")}
                background: Rectangle {
                    id: buttonContourBkg
                    radius: parent.radius
                    anchors.fill: parent
                    color: buttonContour.down ? contourColorPressed : contourColor
                }
            }

            Rectangle {
                id: buttonBevel
                width: buttonContour.width*0.92
                height: buttonContour.height*0.92
                anchors.centerIn: buttonContour
                radius: buttonContour.radius - buttonContour.radius*0.1
                gradient: Gradient {
                    // GradientStop { position: 0.1; color: Qt.rgba(140/255,161/255,198/255,1) }
                    // GradientStop { position: 1.0; color: Qt.rgba(53/255,65/255,88/255,1) }
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
                    // GradientStop { position: 0.1; color: Qt.rgba(97/255,119/255,157/255,1) }
                    // GradientStop { position: 1.0; color: Qt.rgba(69/255,85/255,114/255,1) }
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

        colorTint: "#586E95"

        contourColorPressed: "#7AEFFF"
        contourColor: "#161A23"

        // shadowVisible: false
        // embossVisible: false
        shadowColor: "#10131A"
        shadowOffset: 8

        // showBorders: true

        Rectangle {
            id: stopButtonIcon
            width: stopButton.width*0.3
            height: width
            anchors.centerIn: parent
            radius: 6
            border.color: "#B4CBF5"
            border.width: 5
            color: "transparent"
        }
    }

    SpecialButton{
        id: startButton
        size: 110
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 220
        anchors.bottomMargin: 60

        colorTint: "#586E95"

        contourColorPressed: "#7AEFFF"
        contourColor: "#161A23"

        // shadowVisible: false
        // embossVisible: false
        shadowColor: "#10131A"

        // showBorders: true

        Shape {

            antialiasing: true

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
}

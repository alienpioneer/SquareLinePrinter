import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Layouts
import "Components" as Components

Item{
    id: printerPage
    anchors.fill: parent

    component SpecialButton: Item {
        id: specialButtonRoot
        property int size

        property color colorTint: Style.baseColor
        property color contourColor: Style.buttonOffColor

        property alias shadowVisible: buttonDropShadow.visible
        property alias embossVisible: buttonEmboss.visible
        property alias shadowOffset: buttonDropShadow.shadowVerticalOffset

        property bool showBorders: false

        signal switchPressed()
        signal switchReleased()

        width: size
        height: size

        MultiEffect {
            id: buttonEmboss
            source:  buttonOuter
            anchors.fill: buttonOuter
            blurEnabled: Style.enableEffects
            blur: 1
            blurMax: Style.embossBlurMax
            blurMultiplier: Style.embossBlurMultiplier
            brightness: blurEnabled ? Style.embossBrightness : 0
        }

        MultiEffect {
            id: buttonDropShadow
            source: buttonOuter
            anchors.fill: buttonOuter
            shadowEnabled: Style.enableEffects
            shadowVerticalOffset: Style.shadowOffset
            shadowColor: Style.shadowColor
        }

        Rectangle{
            id: checker
            width: specialButtonRoot.width
            height: specialButtonRoot.height
            anchors.fill: specialButtonRoot
            border.color: "red"
            border.width: 1
            color: "transparent"
            visible: specialButtonRoot.showBorders
        }

        Rectangle {
            id: buttonOuter
            width: specialButtonRoot.width
            height: width
            anchors.centerIn: specialButtonRoot
            visible: true
            radius: 30
            color: specialButtonRoot.colorTint
            gradient: Gradient {
                GradientStop { position: 0.1; color: Qt.tint( specialButtonRoot.colorTint, Qt.hsla(0,0,1,0.1)) }
                GradientStop { position: 1.0; color: Qt.tint( specialButtonRoot.colorTint, Qt.hsla(0,0,0,0.2)) }
            }

            RoundButton {
                id: buttonContour
                width: buttonOuter.width*0.91
                height: buttonOuter.height*0.91
                radius: buttonOuter.radius-buttonOuter.radius*0.1
                anchors.centerIn: buttonOuter
                onPressed : specialButtonRoot.switchPressed()
                onReleased : specialButtonRoot.switchReleased()

                background: Rectangle {
                    id: buttonContourBkg
                    radius: buttonContour.radius
                    anchors.fill: buttonContour
                    color:  specialButtonRoot.contourColor
                }
            }

            Rectangle {
                id: buttonBevel
                width: buttonContour.width*0.92
                height: buttonContour.height*0.92
                anchors.centerIn: buttonContour
                radius: buttonContour.radius - buttonContour.radius*0.1
                gradient: Gradient {
                    GradientStop { position: 0.1; color: Qt.tint( specialButtonRoot.colorTint, Qt.hsla(220/255,30/255,1,0.4)) }
                    GradientStop { position: 1.0; color: Qt.tint( specialButtonRoot.colorTint, Qt.hsla(0,0,0,0.4)) }
                }
                visible: true
            }

            Rectangle {
                id: buttonInner
                width: buttonBevel.width*0.92
                height: buttonBevel.height*0.92
                anchors.centerIn: buttonBevel
                radius: buttonBevel.radius - buttonBevel.radius*0.1
                // radius: buttonBevel.radius - (buttonBevel.width-width)
                gradient: Gradient {
                    GradientStop { position: 0.1; color: Qt.tint( specialButtonRoot.colorTint, Qt.hsla(220/255,30/255,1,0.2)) }
                    GradientStop { position: 1.0; color: Qt.tint( specialButtonRoot.colorTint, Qt.hsla(0,0,0,0.1)) }
                }
            }
        }
    }

    Item {
        id: mainViewItem
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.170
        anchors.left: parent.left
        anchors.leftMargin: 25

        MultiEffect {
            id: mainViewEmboss
            source:  mainView
            anchors.fill: mainView
            blurEnabled: Style.enableEffects
            blur: 1
            blurMax: Style.embossBlurMax
            blurMultiplier: Style.embossBlurMultiplier
            brightness: blurEnabled ? Style.embossBrightness : 0
        }

        MultiEffect {
            id: mainViewDropShadow
            source: mainView
            anchors.fill: mainView
            shadowEnabled: Style.enableEffects
            shadowColor: Style.shadowColor
            shadowScale: 1
            shadowVerticalOffset: Style.shadowOffset
        }

        Rectangle {
            id: mainView
            width: 300
            height: 360
            radius: 20
            border.color: Style.baseColor
            border.width: 5
            color: "#2A3342"
            gradient: Gradient {
                        GradientStop { position: 0.1; color: "#3A4455" }
                        GradientStop { position: 0.8; color: "#1C212B" }
                    }
        }
    }

    SpecialButton{
        id: stopButton
        size: 120
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 60
        anchors.bottomMargin: 45


        onSwitchPressed: {
            stopIcon.visible = !stopIcon.visible;
            startIcon.visible=!startIcon.visible;
            if (stopIcon.visible)
                contourColor = Qt.binding(function() { return Style.highlightColor })
            else
                contourColor = Qt.binding(function() { return Style.buttonOffColor })
        }

        Rectangle {
            id: stopIcon
            width: stopButton.width*0.3
            height: stopButton.width*0.3
            anchors.centerIn: parent
            radius: 6
            border.color: Style.buttonIconColor
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
                strokeColor: Style.buttonIconColor
                strokeWidth: 5
                fillColor: "transparent"

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: startButton.width/2-10
                startY: startButton.width/2+16

                PathLine { x: startButtonPath.startX+26; y: startButtonPath.startY-18 }
                PathLine { x: startButtonPath.startX; y: startButtonPath.startY-36 }
                PathLine { x: startButtonPath.startX; y: startButtonPath.startY }
            }
        }
    }

    SpecialButton{
        id: startButton
        size: 120
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 220
        anchors.bottomMargin: 45

        property bool buttonPressed: false

        Rectangle {
            width: 6
            height: 40
            x: parent.width/2-16
            y: parent.width/2-height/2
            radius: 6
            color: Style.buttonIconColor
        }

        Rectangle {
            width: 6
            height: 40
            x: parent.width/2+10
            y: parent.width/2-height/2
            radius: 6
            color: Style.buttonIconColor
        }

        onSwitchPressed: {
            buttonPressed = !buttonPressed
            contourColor = Qt.binding(function() { return Style.highlightColor })
        }

        onSwitchReleased:{
            if (buttonPressed)
                contourColor = Qt.binding(function() { return "#51A6B0" })
            else
                contourColor = Qt.binding(function() { return Style.buttonOffColor })
        }
    }

    Components.SpecialDisplay {
        id: topSpecialDisplay
        width: 335
        height: 82
        anchors {
            right: printerPage.right
            top: printerPage.top
            rightMargin: 25
            topMargin: printerPage.height*0.170
        }

        leftUpperText: "Start Time"
        rightUpperText: "Printing Time"
        rightLowerText: "08:25"
        leftLowerText: "10:25"

        backgroundColor: Style.darkBkgColor
        backgroundBorderColor: Style.borderColor
        separatorColor: Style.displaySeparatorColor
        upperTextColor: Style.displayTextColor
        lowerTextColor: Style.displayTextAltColor
    }

    Components.SpecialDisplay {
        id: bottomSpecialDisplay
        width: 335
        height: 82
        anchors.right: parent.right
        anchors.top: topSpecialDisplay.bottom
        anchors.rightMargin: 25
        anchors.topMargin: 20

        backgroundColor: Style.darkBkgColor
        backgroundBorderColor: Style.borderColor
        separatorColor: Style.displaySeparatorColor
        upperTextColor: Style.displayTextColor
        lowerTextColor: Style.displayTextAltColor
    }
}

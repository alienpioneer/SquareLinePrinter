import QtQuick
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Layouts
import "Components" as Components

Item{
    id: printerPage
    anchors.fill: parent

    Item {
        id: mainViewItem
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.170
        anchors.left: parent.left
        anchors.leftMargin: 25

        // property int currentYPos: 250

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

            // clip: true

            // Rectangle {
            //     id : mainViewProgress

            //     anchors {
            //         top: mainView.top
            //         left: mainView.left
            //         topMargin: mainView.border.width
            //         leftMargin: mainView.border.width
            //     }

            //     width: mainView.width-mainView.border.width*2
            //     height: mainViewItem.currentYPos-y

            //     radius:  mainView.radius-mainView.border.width
            //     color: Style.barColor
            // }
        }

        // MouseArea{
        //     anchors.fill: mainView

        //     onPositionChanged: (mouse)=> {
        //         mainViewItem.currentYPos = Math.floor(mouseY)
        //         // console.log("Y:", mainViewItem.currentYPos)
        //     }
        // }

    }

    Components.SpecialButton{
        id: stopButton
        size: 120

        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 60
            bottomMargin: 45
        }

        colorTint: Style.baseColor
        contourColor: Style.buttonOffColor
        colorBevelHightlight: Style.baseColorLight

        effectsEnabled: Style.enableEffects
        effectBlurMax: Style.embossBlurMax
        effectBlurMultiplier: Style.embossBlurMultiplier

        effectEmbossBrightness: Style.embossBrightness
        effectShadowColor: Style.shadowColor
        effectShadowOffset: Style.shadowOffset

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

    Components.SpecialButton{
        id: startButton
        size: 120

        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 220
            bottomMargin: 45
        }

        colorTint: Style.baseColor
        contourColor: Style.buttonOffColor
        colorBevelHightlight: Style.baseColorLight

        effectsEnabled: Style.enableEffects
        effectBlurMax: Style.embossBlurMax
        effectBlurMultiplier: Style.embossBlurMultiplier

        effectEmbossBrightness: Style.embossBrightness
        effectShadowColor: Style.shadowColor
        effectShadowOffset: Style.shadowOffset

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

    // Upper time display
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

        leftTitleText: "Start Time"
        leftValueText: "08:25"

        rightTitleText: "Printing Time"
        rightValueText: "10:22"

        backgroundColor: Style.darkBkgColor
        backgroundBorderColor: Style.borderColor
        separatorColor: Style.displaySeparatorColor
        titleColor: Style.displayTextColor
        valueColor: Style.displayTextAltColor

        hasLeftIcon : true
        checkLeftIcon: false

        leftIconItem : Shape {
            id: leftClockIcon
            antialiasing: true
            asynchronous: true
            visible: true

            ShapePath {
                fillColor: "transparent"
                strokeColor: Style.displayTextColor
                strokeWidth: 2

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: 10
                startY: 0

                PathArc { x: 10 ; y: 20 ; radiusX: 1; radiusY: 1}
                PathArc { x: 10 ; y: 0 ; radiusX: 1; radiusY: 1}
            }

            ShapePath {
                fillColor: "transparent"
                strokeColor: Style.displayTextColor
                strokeWidth: 2

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: 10
                startY: 3

                PathLine { x: 10 ; y: 10 }
                PathLine { x: 14 ; y: 6 }
            }
        }

        hasRightIcon : true
        checkRightIcon: false

        rightIconItem : Shape {
            id: rightClockIcon
            antialiasing: true
            asynchronous: true
            visible: true

            ShapePath {
                fillColor: "transparent"
                strokeColor: Style.displayTextColor
                strokeWidth: 2

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: 10
                startY: 0

                PathArc { x: 10 ; y: 20 ; radiusX: 1; radiusY: 1}
                PathArc { x: 10 ; y: 0 ; radiusX: 1; radiusY: 1}
            }

            ShapePath {
                fillColor: "transparent"
                strokeColor: Style.displayTextColor
                strokeWidth: 2

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: 14
                startY: 6

                PathLine { x: 10 ; y: 10 }
                PathLine { x: 10 ; y: 14 }
            }
        }
    }

    // Lower temperatures display
    Components.SpecialDisplay {
        id: bottomSpecialDisplay
        width: 335
        height: 82

        anchors {
            right: parent.right
            top: topSpecialDisplay.bottom
            rightMargin: 25
            topMargin: 20
        }

        backgroundColor: Style.darkBkgColor
        backgroundBorderColor: Style.borderColor
        separatorColor: Style.displaySeparatorColor
        titleColor: Style.displayTextColor
        valueColor: Style.displayTextAltColor
        valueAltColor: Style.displayTextColor


        leftTitleText: "Head Temp."
        leftValueText: "195°"
        leftValueAltText: "/195°"
        hasLeftIcon : true
        checkLeftIcon: false

        rightTitleText: "Bed Temp."
        rightValueText: "65°"
        rightValueAltText: "/65°"
        hasRightIcon : true
        checkRightIcon: false

        leftIconItem : Shape {
            id: leftIcon
            antialiasing: true
            asynchronous: true
            visible: true

            ShapePath {
                fillColor: "transparent"
                strokeColor: Style.displayTextColor
                strokeWidth: 2

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: 4
                startY: 0

                PathLine { x: 16 ; y: 0 }
                PathLine { x: 18 ; y: 2 }
                PathLine { x: 18 ; y: 10 }
                PathLine { x: 2 ; y: 10 }
                PathLine { x: 2 ; y: 2 }
                PathLine { x: 4 ; y: 0 }
            }

            ShapePath {
                fillColor: "transparent"
                strokeColor: Style.displayTextColor
                strokeWidth: 2

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: 4
                startY: 11

                PathLine { x: 5 ; y: 15 }
                PathLine { x: 15 ; y: 15 }
                PathLine { x: 16 ; y: 11 }
            }

            ShapePath {
                fillColor: "transparent"
                strokeColor: Style.displayTextColor
                strokeWidth: 2

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: 10
                startY: 16

                PathArc { x: 10 ; y: 20 ; radiusX: 1; radiusY: 1}
                PathArc { x: 10 ; y: 16 ; radiusX: 1; radiusY: 1}
            }

            ShapePath {
                fillColor: "transparent"
                strokeColor: Style.displayTextColor
                strokeWidth: 2

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: 10
                startY: 21

                PathLine { x: 10 ; y: 23 }
            }
        }

        rightIconItem : Shape {
            id: rightIcon
            antialiasing: true
            asynchronous: true
            visible: true

            ShapePath {
                fillColor: "transparent"
                strokeColor: Style.displayTextColor
                strokeWidth: 2

                strokeStyle: ShapePath.SolidLine
                capStyle: ShapePath.RoundCap
                joinStyle: ShapePath.RoundJoin

                startX: 4
                startY: 4

                PathLine { x: 16 ; y: 4 }
                PathLine { x: 20 ; y: 16 }
                PathLine { x: 18 ; y: 18 }
                PathLine { x: 2 ; y: 18 }
                PathLine { x: 0 ; y: 16 }
                PathLine { x: 4 ; y: 4 }
            }
        }
    }
}

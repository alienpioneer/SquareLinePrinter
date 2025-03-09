import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes
import QtQuick.Layouts

Window {
    id: mainWindow
    width: 800
    height: 480
    visible: true
    title: qsTr("SquareLinePrinter")
    color: Style.baseColor

    // maximumHeight: height
    // maximumWidth: width
    // minimumHeight: height
    // minimumWidth: width

    // visibility: Window.FullScreen
    // flags: Qt.FramelessWindowHint


    // Selector type for the left bar
    component BarSelector: Item {
        id: barSelector

        required property int barWidth
        required property string text
        property alias iconItem: selectorIcon.data

        property bool active: false
        property int selectorId: 0

        signal pressed()

        Rectangle{
            id: selectorHightlight
            implicitWidth: barSelector.width - selectorBarHighlight.width
            implicitHeight: barSelector.height
            color: Qt.tint(leftBar.color, Qt.rgba(0.4,0.4,1,0.1));
            opacity: 0.7
            visible: active
        }

        Rectangle{
            id: selectorBarHighlight
            anchors.left: selectorHightlight.right
            implicitHeight: barSelector.height
            implicitWidth: barSelector.barWidth

            visible: active
            color: Style.highlightColor
        }

        MultiEffect {
            id: iconGlow
            source:  selectorIcon
            anchors.fill: selectorIcon
            brightness: 0.5
            blurEnabled: active ? Style.enableEffects : false
            blurMax: Style.embossBlurMax
            blur: 1
            opacity: 0.8
            visible: active
        }

        MultiEffect {
            id: textGlow
            source:  selectorText
            anchors.fill: selectorText
            brightness: 0.5
            blurEnabled: active ? Style.enableEffects : false
            blurMax: Style.embossBlurMax
            blur: 1
            opacity: 0.8
            visible: active
        }

        Item{
            id:selectorIcon

            implicitWidth: selectorHightlight.width/2
            implicitHeight: selectorHightlight.width/2

            anchors.centerIn: barSelector
        }

        Text{
            id: selectorText

            text: barSelector.text

            anchors {
                horizontalCenter: barSelector.horizontalCenter
                top: selectorIcon.bottom
                topMargin: 8
            }

            font {
                bold: true
                pixelSize: Style.textSize
            }

            color: active ? Style.highlightColor : Style.barIconColor
        }

        MouseArea {
            anchors.fill: barSelector
            onClicked: {
                barSelector.pressed()
            }
        }
    }

    // Background effects
    MultiEffect {
        id: backgroundBrightness
        source:  backgroundLightSource
        anchors.fill: backgroundLightSource
        blurEnabled: Style.enableBackgroundLight
        blur: 1
        blurMax: 100
        blurMultiplier: 4
        brightness: Style.enableBackgroundLight ? 0.2 : 0
        visible: Style.enableBackgroundLight
        opacity: 0.6
    }

    Rectangle {
        id: backgroundLightSource
        width: 200
        height: width
        radius: width/2
        visible: false

        anchors {
            top: parent.top
            right: parent.right
            topMargin: 70
            rightMargin: 220
        }
    }

    // Main view
    Loader{
        id: mainLoader
        anchors.right: parent.right
        anchors.left:leftBar.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        source: {
            switch(leftBar.currentSelection){
                case 1:
                    return "PrinterPage.qml";
                case 2:
                    return "MovePage.qml";
                case 3:
                    return "SettingsPage.qml";
                default:
                    return "";
            }
        }
    }

    // Left selection bar
    Rectangle {
        id: leftBar
        width: 80
        height: parent.height
        color: Style.barColor
        anchors.left: parent.left

        property int currentSelection: 1

        Rectangle {
            id: leftBarSeparator
            width: 5
            height: leftBar.height
            anchors.right: leftBar.right
            color: Style.borderColor
        }

        BarSelector{
            id: printSelector
            selectorId: 1
            active: leftBar.currentSelection === selectorId

            text: "PRINT"

            width: parent.width
            height: parent.height/3
            barWidth: leftBarSeparator.width
            anchors.left: parent.left

            iconItem: Shape {
                id: printIcon
                antialiasing: true
                asynchronous: true
                anchors.centerIn: parent
                visible: true

                // On QT>6.7 use transforms
                // transform: Translate {
                //     x: 1.5*printIcon.width
                //     y: 1.5*printIcon.height
                // }

                ShapePath {
                    id: startButtonPath
                    fillColor: printSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeColor: fillColor
                    strokeWidth: 5

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: -14
                    startY: 10

                    PathLine { x: startButtonPath.startX+24; y: startButtonPath.startY-14 }
                    PathLine { x: startButtonPath.startX; y: startButtonPath.startY-28 }
                    PathLine { x: startButtonPath.startX; y: startButtonPath.startY }
                }
            }

            onPressed: {
                parent.currentSelection = Qt.binding(function() { return selectorId });
                // console.log("printSelector Button Pressed, current selection: ", parent.currentSelection);

            }
        }

        BarSelector{
            id: moveSelector
            selectorId: 2
            active: leftBar.currentSelection === selectorId

            text: "MOVE"

            y: parent.height/3
            width: parent.width
            height: parent.height/3
            barWidth: leftBarSeparator.width
            anchors.left: parent.left

            iconItem: Shape {
                id: moveIcon
                antialiasing: true
                asynchronous: true
                anchors.centerIn: parent
                visible: true

                // On QT>6.7 use transforms
                // transform: Translate {
                //     x: moveIcon.width
                //     y: moveIcon.height
                // }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: moveSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 4

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: 0
                    startY: -16

                    PathLine { x: 0 ; y: 16 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: moveSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 4

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: -16
                    startY: 0

                    PathLine { x: 16 ; y: 0 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: moveSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 4

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: -10
                    startY: -6

                    PathLine { x: -16 ; y: 0 }
                    PathLine { x: -10 ; y: 6 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: moveSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 4

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: 10
                    startY: -6

                    PathLine { x: 16 ; y: 0 }
                    PathLine { x: 10 ; y: 6 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: moveSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 4

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: -6
                    startY: 10

                    PathLine { x: 0 ; y: 16 }
                    PathLine { x: 6 ; y: 10 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: moveSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 4

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: -6
                    startY: -10

                    PathLine { x: 0 ; y: -16 }
                    PathLine { x: 6 ; y: -10 }
                }
            }

            onPressed: {
                parent.currentSelection = Qt.binding(function() { return selectorId });
            }
        }

        BarSelector{
            id: settingsSelector
            selectorId: 3
            active: leftBar.currentSelection === selectorId

            text: "SETTINGS"

            y: parent.height/3*2
            width: parent.width
            height: parent.height/3
            barWidth: leftBarSeparator.width
            anchors.left: parent.left

            iconItem: Shape {
                id: settingsIcon
                antialiasing: true
                asynchronous: true
                anchors.centerIn: parent
                visible: true

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: settingsSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 7

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: 0
                    startY: -12

                    PathArc { x: 0 ; y: 6 ; radiusX: 1; radiusY: 1}
                    PathArc { x: 0 ; y: -12 ; radiusX: 1; radiusY: 1}
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: settingsSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 6

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.SquareCap

                    startX: 0
                    startY: -15

                    PathLine { x: 0 ; y: -14 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: settingsSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 6

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.SquareCap

                    startX: 0
                    startY: 8

                    PathLine { x: 0 ; y: 9 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: settingsSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 6

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.SquareCap

                    startX: 8
                    startY: -12

                    PathLine { x: 9 ; y: -11 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: settingsSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 6

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.SquareCap

                    startX: 10
                    startY: -3

                    PathLine { x: 11 ; y: -3 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: settingsSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 6

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.SquareCap

                    startX: 8
                    startY: 4

                    PathLine { x: 9 ; y: 5 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: settingsSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 6

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.SquareCap

                    startX: -8
                    startY: -12

                    PathLine { x: -9 ; y: -11 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: settingsSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 6

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.SquareCap

                    startX: -8
                    startY: 4

                    PathLine { x: -9 ; y: 5 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: settingsSelector.active ? Style.highlightColor : Style.barIconColor
                    strokeWidth: 6

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.SquareCap

                    startX: -10
                    startY: -3

                    PathLine { x: -11 ; y: -3 }
                }

            }

            onPressed: {
                parent.currentSelection = Qt.binding(function() { return selectorId });
            }
        }
    }

    // Top display
    Rectangle {
        id: topDisplay
        height: 60

        anchors{
            top: parent.top
            topMargin: -12
            right: parent.right
            rightMargin: 25
            left: parent.left
            leftMargin: 105
        }

        radius: 16
        border.width: 3

        border.color: Style.borderColor
        color: Style.darkBkgColor

        Text {
            anchors {
                left: topDisplay.left
                leftMargin: 30
                top: topDisplay.top
                topMargin: 20
            }


            font {
                pixelSize: 18
                bold: true
            }

            color: Style.displayTextColor

            text: {
                switch(leftBar.currentSelection){
                    case 1:
                        return "The current file is being printed";
                    case 2:
                        return "Press the control buttons to move the tray and head";
                    case 3:
                        return "Adjust the print parameters";
                    default:
                        return "";
                }
            }
        }

        // Icons
        Row {
            spacing: 20

            anchors {
                right: topDisplay.right
                rightMargin: 40
                top: topDisplay.top
                topMargin: 20
            }

            Shape {
                id: usbIcon
                width: 30
                height: 30
                antialiasing: true
                asynchronous: true
                visible: true

                // Rectangle{
                //     width: parent.width
                //     height: parent.height
                //     anchors.fill: parent
                //     border.color: "red"
                //     border.width: 1
                //     color: "transparent"
                //     visible: true
                // }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: Style.displayTextColor
                    strokeWidth: 3

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: 2
                    startY: 12

                    PathLine { x: 4 ; y: 10 }
                    PathLine { x: 20 ; y: 10 }
                    PathLine { x: 20 ; y: 24 }
                    PathLine { x: 4 ; y: 24 }
                    PathLine { x: 2 ; y: 22 }
                    PathLine { x: 2 ; y: 12 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: Style.displayTextColor
                    strokeWidth: 3

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: 24
                    startY: 12

                    PathLine { x: 24 ; y: 22 }
                    PathLine { x: 28 ; y: 22 }
                    PathLine { x: 28 ; y: 17 }
                    PathLine { x: 26 ; y: 17 }
                    PathLine { x: 28 ; y: 17 }
                    PathLine { x: 28 ; y: 12 }
                    PathLine { x: 24 ; y: 12 }
                }
            }

            Shape {
                id: screenIcon
                width: 30
                height: 30
                antialiasing: true
                asynchronous: true
                visible: true

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: Style.displayTextColor
                    strokeWidth: 3

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: 2
                    startY: 6

                    PathLine { x: 4 ; y: 4 }
                    PathLine { x: 26 ; y: 4 }
                    PathLine { x: 28 ; y: 6 }
                    PathLine { x: 28 ; y: 20 }
                    PathLine { x: 26 ; y: 22 }
                    PathLine { x: 15 ; y: 22 }
                    PathLine { x: 15 ; y: 27 }
                    PathLine { x: 15 ; y: 22 }
                    PathLine { x: 4 ; y: 22 }
                    PathLine { x: 2 ; y: 20 }
                    PathLine { x: 2 ; y: 5 }
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: Style.displayTextColor
                    strokeWidth: 3

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: 8
                    startY: 28

                    PathLine { x: 22 ; y: 28 }
                }
            }

            Shape {
                id: wifiIcon
                width: 30
                height: 30
                antialiasing: true
                asynchronous: true
                visible: true

                ShapePath {
                    fillColor: Style.displayTextColor
                    strokeColor: Style.displayTextColor
                    strokeWidth: 2

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: 15
                    startY: 22

                    PathArc { x: 15 ; y: 26 ; radiusX: 1; radiusY: 1}
                    PathArc { x: 15 ; y: 22 ; radiusX: 1; radiusY: 1}
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: Style.displayTextColor
                    strokeWidth: 3

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: 7
                    startY: 18

                    PathArc { x: 23 ; y: 18 ; radiusX: 10; radiusY: 10}
                }

                ShapePath {
                    fillColor: "transparent"
                    strokeColor: Style.displayTextColor
                    strokeWidth: 3

                    strokeStyle: ShapePath.SolidLine
                    capStyle: ShapePath.RoundCap
                    joinStyle: ShapePath.RoundJoin

                    startX: 3
                    startY: 11

                    PathArc { x: 27 ; y: 11 ; radiusX: 16; radiusY: 16}
                }
            }
        }
    }
}

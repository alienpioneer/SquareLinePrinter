import QtQuick
import QtQuick.Effects
import QtQuick.Controls.Basic

Item {
    id: buttonRoot

    implicitWidth: 150
    implicitHeight: 150

    property string buttonText : ""

    property color buttonColorBase
    property color borderColorBase
    property color textColorBase
    property color baseColorHighlight

    property int effectBlurMax
    property bool effectBlurEnabled

    property bool selected: false
    property bool toggle: false
    property int buttonBorderOffset: buttonRoot.selected ? 3 : 4

    signal buttonPressed()

    Rectangle {
        id: buttonContour

        implicitWidth: buttonRoot.width - buttonRoot.buttonBorderOffset
        implicitHeight: 60 - buttonRoot.buttonBorderOffset
        radius: 30
        border.width: buttonRoot.buttonBorderOffset
        border.color: buttonRoot.selected ? buttonRoot.baseColorHighlight : buttonRoot.borderColorBase
        color: "transparent"
        opacity: buttonRoot.selected ? 0.3 : 1
    }

    Rectangle {
        id: innerButton

        implicitWidth: buttonContour.width-2*buttonRoot.buttonBorderOffset
        implicitHeight: buttonContour.height-2*buttonRoot.buttonBorderOffset
        radius: buttonContour.radius+buttonRoot.buttonBorderOffset
        color: buttonRoot.buttonColorBase
        anchors.centerIn: buttonContour

        gradient: Gradient {
            GradientStop { position: 0.1; color: Qt.tint(innerButton.color, Qt.hsla(220/255,30/255,1,0.2)) }
            GradientStop { position: 1.0; color: Qt.tint(innerButton.color, Qt.hsla(0,0,0,0.1)) }
        }

        Text {
            id: buttonId
            text: buttonRoot.buttonText
            color: selected ? buttonRoot.baseColorHighlight : buttonRoot.textColorBase
            anchors.centerIn: innerButton
            horizontalAlignment: Qt.AlignHCenter
            font.pixelSize: 16
            font.bold: true
        }

        MouseArea {
            anchors.fill: innerButton
            onClicked: {
                if (!buttonRoot.toggle){
                    buttonRoot.selected = !buttonRoot.selected
                    buttonRoot.buttonPressed()
                }
            }
            onPressed: {
                if (buttonRoot.toggle){
                    buttonRoot.selected = true
                    buttonRoot.buttonPressed()
                }
            }
            onReleased: {
                if (buttonRoot.toggle){
                    buttonRoot.selected = false
                }
            }
        }
    }

    // Button glow
    MultiEffect {
        id: iconGlow
        source:  buttonContour
        anchors.fill: buttonContour
        brightness: 0.2
        blurEnabled: buttonRoot.selected ? buttonRoot.effectBlurEnabled : false
        blurMax: buttonRoot.effectBlurMax
        blur: 1
        opacity: 1
        visible: buttonRoot.selected
    }
}

// Button end

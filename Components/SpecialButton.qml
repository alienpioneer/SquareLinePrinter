import QtQuick
import QtQuick.Effects
import QtQuick.Controls.Basic

Item {
    id: specialButtonRoot
    property int size

    property color colorTint
    property color colorBevelHightlight
    property color contourColor

    property bool effectsEnabled
    property int effectBlurMax
    property double effectBlurMultiplier

    property double effectEmbossBrightness
    property color effectShadowColor
    property int effectShadowOffset

    property bool showBorders: false

    signal switchPressed()
    signal switchReleased()

    implicitWidth: size
    implicitHeight: size

    MultiEffect {
        id: buttonEmboss
        source:  buttonOuter
        anchors.fill: buttonOuter
        blurEnabled: specialButtonRoot.effectsEnabled
        blur: 1
        blurMax: specialButtonRoot.effectBlurMax
        blurMultiplier: specialButtonRoot.effectBlurMultiplier
        brightness: blurEnabled ? specialButtonRoot.effectEmbossBrightness : 0
        visible: specialButtonRoot.effectsEnabled
    }

    MultiEffect {
        id: buttonDropShadow
        source: buttonOuter
        anchors.fill: buttonOuter
        shadowEnabled: specialButtonRoot.effectsEnabled
        shadowVerticalOffset: specialButtonRoot.effectShadowOffset
        shadowColor: specialButtonRoot.effectShadowColor
        visible: specialButtonRoot.effectsEnabled
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
                GradientStop { position: 0.1; color: Qt.tint( specialButtonRoot.colorBevelHightlight, Qt.hsla(220/255,30/255,1,0.4)) }
                GradientStop { position: 1.0; color: Qt.tint( specialButtonRoot.colorTint, Qt.hsla(0,0,0,0.4)) }
            }
            visible: true
        }

        Rectangle {
            id: buttonInner
            width: buttonBevel.width*0.94
            height: buttonBevel.height*0.94
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

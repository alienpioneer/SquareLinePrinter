import QtQuick
import QtQuick.Effects
import QtQuick.Controls

Item {
    id: rootTumbler

    implicitWidth: 150
    implicitHeight: 150

    property string title: ""
    property variant model: []

    property int effectBlurMax
    property int effectBlurMultiplier
    property int effectBlurEnabled
    property color effectEmbossBrightness
    property color effectShadowColor
    property color effectShadowOffset

    property color textColorHighlight
    property color textColor
    property color titleColor

    property color backgroundColor
    property color borderColor
    property color highlightBarColor

    MultiEffect {
        id: rootTumblerEmboss
        source:  tumblerContainer
        anchors.fill: tumblerContainer
        blurEnabled: rootTumbler.effectBlurEnabled
        blur: 1
        blurMax: rootTumbler.effectBlurMax
        blurMultiplier: rootTumbler.effectBlurMultiplier
        brightness: blurEnabled ? rootTumbler.effectEmbossBrightness : 0
    }

    MultiEffect {
        id: rootTumblerDropShadow
        source: tumblerContainer
        anchors.fill: tumblerContainer
        shadowEnabled: rootTumbler.effectBlurEnabled
        shadowColor: rootTumbler.effectShadowColor
        shadowScale: 1
        shadowVerticalOffset: rootTumbler.effectShadowOffset
    }

    Text {
        id: tumblerTitle
        text: rootTumbler.title
        color: rootTumbler.titleColor
        font.pixelSize: 20
        font.bold: true
        anchors{
            horizontalCenter: tumblerContainer.horizontalCenter
            bottom: tumblerContainer.top
            bottomMargin: 8
        }
        visible: rootTumbler.title != ""
    }

    // Tumbler background
    Rectangle {
        id: tumblerContainer

        implicitWidth: rootTumbler.width
        implicitHeight: rootTumbler.height

        radius: 20
        border.width: 5
        border.color: rootTumbler.borderColor
        color: rootTumbler.backgroundColor
        clip: true

        // tumbler middle line
        Rectangle {
            implicitWidth: tumblerContainer.width-tumblerContainer.border.width*2
            implicitHeight: (tumblerContainer.height-tumblerContainer.border.width*2)/3
            anchors.centerIn: tumblerContainer
            color: rootTumbler.highlightBarColor
        }

        Tumbler {
            id: customTumbler
            anchors.centerIn: tumblerContainer

            implicitWidth: tumblerContainer.width
            implicitHeight: tumblerContainer.height-tumblerContainer.border.width*2

            //Background+borders dictates the implicit size !!!
            visibleItemCount : 3
            model: rootTumbler.model

            delegate: Text {
                required property int index
                required property string modelData
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: modelData
                color: Tumbler.displacement < 0.4 &&  Tumbler.displacement > -0.4 ? rootTumbler.textColorHighlight : rootTumbler.textColor
                font.pixelSize: Math.max(0.7, 1 - Math.abs(Tumbler.displacement))*28
                font.bold: true
            }
        }
    }
}

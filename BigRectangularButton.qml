import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

Item {
    id: bigRectBtnRoot

    implicitWidth:  100
    implicitHeight: 260

    property int buttonRadius: 20
    property int innerOffset: 20
    property int outerEmbossOffset: 6

    property color baseColor
    property color highlightColor
    property color offColor

    property color textColor
    property int textSize: 20
    property string text: ""

    property color arrowsColor

    property bool enableEffects
    property color glowBaseColor
    property int glowBlurMax: 32
    property double glowEffectOpacity: 1
    property double glowBrightness: 0.2


    property int embossBlurMax
    property double embossBlurMultiplier
    property double embossBrightness

    property color shadowColor
    property int   shadowOffset

    MultiEffect {
        id: bigButtonEmboss
        source:  bigRectButton
        anchors.fill: bigRectButton
        blurEnabled: bigRectBtnRoot.enableEffects
        blur: 1
        blurMax: bigRectBtnRoot.embossBlurMax
        blurMultiplier: bigRectBtnRoot.embossBlurMultiplier
        brightness: bigRectBtnRoot.enableEffects ? bigRectBtnRoot.embossBrightness : 0
        visible: bigRectBtnRoot.enableEffects
    }

    MultiEffect {
        id: bigButtonDropShadow
        source: bigRectButton
        anchors.fill: bigRectButton
        shadowEnabled: bigRectBtnRoot.enableEffects
        shadowVerticalOffset: bigRectBtnRoot.shadowOffset
        shadowColor: bigRectBtnRoot.shadowColor
        blurMax: bigRectBtnRoot.embossBlurMax
        visible: bigRectBtnRoot.enableEffects
    }

    Rectangle {
        id: bigRectButton
        width: bigRectBtnRoot.width
        height: bigRectBtnRoot.height
        radius: bigRectBtnRoot.buttonRadius
        border.width: 6

        color: bigRectBtnRoot.offColor
        border.color: bigRectBtnRoot.baseColor

        ButtonGlow {
            id: upButtonGlow
            width: bigRectBtnRoot.width

            anchors{
                top: bigRectButton.top
                horizontalCenter: bigRectButton.horizontalCenter
            }
        }

        ButtonGlow {
            id: downButtonGlow
            width: upButtonGlow.width

            anchors{
                bottom: bigRectButton.bottom
                horizontalCenter: bigRectButton.horizontalCenter
            }
        }

        Rectangle {
            id: buttonHighlight
            width: bigRectButton.width-bigRectBtnRoot.innerOffset
            height:  bigRectButton.height-bigRectBtnRoot.innerOffset
            radius: bigRectButton.radius-bigRectBtnRoot.innerOffset/2

            gradient: Gradient {
                GradientStop { position: 0; color: Qt.tint(bigRectBtnRoot.highlightColor, Qt.hsla(0,0,1,0.1)) }
                GradientStop { position: 1.0; color: Qt.tint(bigRectBtnRoot.baseColor, Qt.hsla(0,0,0,0.5)) }
            }

            anchors.centerIn: bigRectButton

            Rectangle {
                id: buttonEmboss
                width: buttonHighlight.width-bigRectBtnRoot.outerEmbossOffset
                height:  buttonHighlight.height-bigRectBtnRoot.outerEmbossOffset
                radius: buttonHighlight.radius-bigRectBtnRoot.outerEmbossOffset/2

                gradient: Gradient {
                    GradientStop { position: 0.1; color: Qt.tint(bigRectBtnRoot.baseColor, Qt.hsla(0,0,1,0.1)) }
                    GradientStop { position: 1.0; color: Qt.tint(bigRectBtnRoot.baseColor, Qt.hsla(0,0,0,0.2)) }
                }

                anchors.centerIn: buttonHighlight

                Shape {
                    id: arrows
                    antialiasing: true
                    asynchronous: true
                    anchors.centerIn: buttonEmboss
                    visible: true

                    ShapePath {
                        id: upArrow
                        fillColor: "transparent"
                        strokeColor: upArrow.selected ? bigRectBtnRoot.glowBaseColor : bigRectBtnRoot.arrowsColor
                        strokeWidth: 4

                        property bool selected: false

                        strokeStyle: ShapePath.SolidLine
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.RoundJoin

                        startX: -12
                        startY: -buttonEmboss.height/2+20

                        PathLine { x: upArrow.startX+12; y: upArrow.startY-10 }
                        PathLine { x: upArrow.startX+24; y: upArrow.startY }
                    }

                    ShapePath {
                        id: downArrow
                        fillColor: "transparent"
                        strokeColor: downArrow.selected ? bigRectBtnRoot.glowBaseColor : bigRectBtnRoot.arrowsColor
                        strokeWidth: 4

                        property bool selected: false

                        strokeStyle: ShapePath.SolidLine
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.RoundJoin

                        startX: -12
                        startY: buttonEmboss.height/2-20

                        PathLine { x: downArrow.startX+12; y: downArrow.startY+10 }
                        PathLine { x: downArrow.startX+24; y: downArrow.startY }
                    }
                }

                Text {
                    text: bigRectBtnRoot.text
                    font.pixelSize: bigRectBtnRoot.textSize
                    color: bigRectBtnRoot.textColor
                    horizontalAlignment: Qt.AlignHCenter
                    anchors.centerIn: buttonEmboss
                }

                MouseArea {
                    id: moveUpArea

                    implicitWidth:  bigRectBtnRoot.width
                    implicitHeight:  width

                    anchors {
                        top: buttonEmboss.top
                        horizontalCenter: buttonEmboss.horizontalCenter
                    }

                    onPressed: {
                        upButtonGlow.glowEnable = bigRectBtnRoot.enableEffects
                        upArrow.selected = true
                    }
                    onReleased: {
                        upButtonGlow.glowEnable = false
                        upArrow.selected = false
                    }
                }

                MouseArea {
                    id: moveDownArea

                    implicitWidth:  bigRectBtnRoot.width
                    implicitHeight:  width

                    anchors {
                        bottom: buttonEmboss.bottom
                        horizontalCenter: buttonEmboss.horizontalCenter
                    }

                    onPressed: {
                        downButtonGlow.glowEnable = bigRectBtnRoot.enableEffects
                        downArrow.selected = true
                    }
                    onReleased: {
                        downButtonGlow.glowEnable = false
                        downArrow.selected = false
                    }
                }
            }
        }

        component ButtonGlow: Item {
            id: buttonGlowRoot

            implicitWidth: 40
            implicitHeight: width

            property bool glowEnable: false

            MultiEffect {
                id: buttonGlow
                source:  glowBase
                anchors.fill: glowBase
                brightness: bigRectBtnRoot.glowBrightness
                blurEnabled: buttonGlowRoot.glowEnable
                blurMax: bigRectBtnRoot.glowBlurMax
                blur: 1
                opacity: bigRectBtnRoot.glowEffectOpacity
                visible: buttonGlowRoot.glowEnable
            }

            Rectangle {
                id: glowBase
                width: bigRectBtnRoot.width
                height: glowBase.width
                radius: glowBase.width/2
                color:  bigRectBtnRoot.glowBaseColor
                visible: false
                anchors.fill: buttonGlowRoot
            }
        }
    }
}

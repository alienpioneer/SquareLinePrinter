import QtQuick
import QtQuick.Effects
import QtQuick.Shapes

Item {
    id: bigRoundBtnRoot

    implicitWidth:  260
    implicitHeight: bigRoundBtnRoot.width

    property int innerOffset: 20
    property int outerEmbossOffset: 6
    property int innerEmbossOffset: 22

    property color baseColor
    property color highlightColor
    property color offColor

    property color textColor
    property int textSize: 20
    property string text: ""

    property color arrowsColor

    property bool enableEffects: false
    property color glowBaseColor
    property int glowBlurMax: 32
    property double glowEffectOpacity: 1
    property double glowBrightness: 0.2


    property int embossBlurMax
    property double embossBlurMultiplier
    property double embossBrightness

    property color shadowColor
    property int   shadowOffset

    property bool qt_greater_6_5_2 : false

    signal pressedUp()
    signal pressedDown()
    signal pressedLeft()
    signal pressedRight()

    MultiEffect {
        id: bigButtonEmboss
        source:  bigRoundButton
        anchors.fill: bigRoundButton
        blurEnabled: bigRoundBtnRoot.enableEffects
        blur: 1
        blurMax: bigRoundBtnRoot.embossBlurMax
        blurMultiplier: bigRoundBtnRoot.embossBlurMultiplier
        brightness: bigRoundBtnRoot.enableEffects ? bigRoundBtnRoot.embossBrightness : 0
        visible: bigRoundBtnRoot.enableEffects
    }

    MultiEffect {
        id: bigButtonDropShadow
        source: bigRoundButton
        anchors.fill: bigRoundButton
        shadowEnabled: bigRoundBtnRoot.enableEffects
        shadowVerticalOffset: bigRoundBtnRoot.shadowOffset
        shadowColor: bigRoundBtnRoot.shadowColor
        blurMax: bigRoundBtnRoot.embossBlurMax
        visible: bigRoundBtnRoot.enableEffects
    }

    Rectangle {
        id: bigRoundButton
        width: bigRoundBtnRoot.width
        height: width
        radius: width/2
        color: bigRoundBtnRoot.offColor
        border.width: 6
        border.color: bigRoundBtnRoot.baseColor

        ButtonGlow {
            id: upButtonGlow
            // width: bigRoundBtnRoot.width/1.625
            width: bigRoundBtnRoot.width/1.3

            anchors{
                top: bigRoundButton.top
                horizontalCenter: bigRoundButton.horizontalCenter
            }
        }

        ButtonGlow {
            id: downButtonGlow
            width: upButtonGlow.width

            anchors{
                bottom: bigRoundButton.bottom
                horizontalCenter: bigRoundButton.horizontalCenter
            }
        }

        ButtonGlow {
            id: leftButtonGlow
            width: upButtonGlow.width

            anchors{
                left: bigRoundButton.left
                verticalCenter: bigRoundButton.verticalCenter
            }
        }

        ButtonGlow {
            id: rightButtonGlow
            width: upButtonGlow.width

            anchors{
                right: bigRoundButton.right
                verticalCenter: bigRoundButton.verticalCenter
            }
        }

        Rectangle {
            id: buttonHighlight
            width: bigRoundButton.width-bigRoundBtnRoot.innerOffset
            height: width
            radius: width/2

            gradient: Gradient {
                GradientStop { position: 0; color: Qt.tint(bigRoundBtnRoot.highlightColor, Qt.hsla(0,0,1,0.1)) }
                GradientStop { position: 1.0; color: Qt.tint(bigRoundBtnRoot.baseColor, Qt.hsla(0,0,0,0.5)) }
            }

            anchors.centerIn: bigRoundButton

            Rectangle {
                id: buttonOutterEmboss
                width: buttonHighlight.width-bigRoundBtnRoot.outerEmbossOffset
                height: width
                radius: width/2

                gradient: Gradient {
                    GradientStop { position: 0.1; color: Qt.tint(bigRoundBtnRoot.baseColor, Qt.hsla(0,0,1,0.1)) }
                    GradientStop { position: 1.0; color: Qt.tint(bigRoundBtnRoot.baseColor, Qt.hsla(0,0,0,0.2)) }
                }

                anchors.centerIn: buttonHighlight

                Rectangle {
                    id: buttonInnerEmboss
                    width: buttonOutterEmboss.width-bigRoundBtnRoot.innerEmbossOffset
                    height: width
                    radius: width/2

                    gradient: Gradient {
                        GradientStop { position: 0.1; color: Qt.tint(bigRoundBtnRoot.baseColor, Qt.hsla(0,0,0,0.1)) }
                        GradientStop { position: 1.0; color: Qt.tint(bigRoundBtnRoot.baseColor, Qt.hsla(0,0,1,0.15)) }
                    }

                    anchors.centerIn: buttonOutterEmboss
                }

                Shape {
                    id: arrows
                    antialiasing: true
                    asynchronous: true
                    anchors.centerIn: buttonInnerEmboss
                    visible: true

                    // On QT>6.7 use transforms
                    transform: Translate {
                        x: bigRoundBtnRoot.qt_greater_6_5_2 ? arrows.width/2 : 0
                        y: bigRoundBtnRoot.qt_greater_6_5_2 ? arrows.height/2 : 0
                    }

                    ShapePath {
                        id: upArrow
                        fillColor: "transparent"
                        strokeColor: upArrow.selected ? bigRoundBtnRoot.glowBaseColor : bigRoundBtnRoot.arrowsColor
                        strokeWidth: 4

                        property bool selected: false

                        strokeStyle: ShapePath.SolidLine
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.RoundJoin

                        startX: -12
                        startY: -buttonInnerEmboss.height/2+20

                        PathLine { x: upArrow.startX+12; y: upArrow.startY-10 }
                        PathLine { x: upArrow.startX+24; y: upArrow.startY }
                    }

                    ShapePath {
                        id: downArrow
                        fillColor: "transparent"
                        strokeColor: downArrow.selected ? bigRoundBtnRoot.glowBaseColor : bigRoundBtnRoot.arrowsColor
                        strokeWidth: 4

                        property bool selected: false

                        strokeStyle: ShapePath.SolidLine
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.RoundJoin

                        startX: -12
                        startY: buttonInnerEmboss.height/2-20

                        PathLine { x: downArrow.startX+12; y: downArrow.startY+10 }
                        PathLine { x: downArrow.startX+24; y: downArrow.startY }
                    }

                    ShapePath {
                        id: leftArrow
                        fillColor: "transparent"
                        strokeColor: leftArrow.selected ? bigRoundBtnRoot.glowBaseColor : bigRoundBtnRoot.arrowsColor
                        strokeWidth: 4

                        property bool selected: false

                        strokeStyle: ShapePath.SolidLine
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.RoundJoin

                        startX: -buttonInnerEmboss.width/2+20
                        startY: 12

                        PathLine { x: leftArrow.startX-10; y: leftArrow.startY-12 }
                        PathLine { x: leftArrow.startX; y: leftArrow.startY-24 }
                    }

                    ShapePath {
                        id: rightArrow
                        fillColor: "transparent"
                        strokeColor: rightArrow.selected ? bigRoundBtnRoot.glowBaseColor : bigRoundBtnRoot.arrowsColor
                        strokeWidth: 4

                        property bool selected: false

                        strokeStyle: ShapePath.SolidLine
                        capStyle: ShapePath.RoundCap
                        joinStyle: ShapePath.RoundJoin

                        startX: buttonInnerEmboss.width/2-20
                        startY: 12

                        PathLine { x: rightArrow.startX+10; y: rightArrow.startY-12 }
                        PathLine { x: rightArrow.startX; y: rightArrow.startY-24 }
                    }
                }

                Text {
                    text: bigRoundBtnRoot.text
                    font.pixelSize: bigRoundBtnRoot.textSize
                    color: bigRoundBtnRoot.textColor
                    horizontalAlignment: Qt.AlignHCenter
                    anchors.centerIn: buttonInnerEmboss
                }

                MouseArea {
                    id: moveUpArea

                    implicitWidth:  bigRoundBtnRoot.width/4
                    implicitHeight:  width

                    anchors {
                        top: buttonOutterEmboss.top
                        horizontalCenter: buttonOutterEmboss.horizontalCenter
                    }

                    onPressed: {
                        upButtonGlow.glowEnable = bigRoundBtnRoot.enableEffects
                        upArrow.selected = true
                        pressedUp()
                    }
                    onReleased: {
                        upButtonGlow.glowEnable = false
                        upArrow.selected = false
                    }
                }

                MouseArea {
                    id: moveDownArea

                    implicitWidth:  bigRoundBtnRoot.width/4
                    implicitHeight:  width

                    anchors {
                        bottom: buttonOutterEmboss.bottom
                        horizontalCenter: buttonOutterEmboss.horizontalCenter
                    }

                    onPressed: {
                        downButtonGlow.glowEnable = bigRoundBtnRoot.enableEffects
                        downArrow.selected = true
                        pressedDown()
                    }
                    onReleased: {
                        downButtonGlow.glowEnable = false
                        downArrow.selected = false
                    }
                }

                MouseArea {
                    id: moveLeftArea

                    implicitWidth:  bigRoundBtnRoot.width/4
                    implicitHeight:  width

                    anchors {
                        left: buttonOutterEmboss.left
                        verticalCenter: buttonOutterEmboss.verticalCenter
                    }

                    onPressed: {
                        leftButtonGlow.glowEnable = bigRoundBtnRoot.enableEffects
                        leftArrow.selected = true
                        pressedLeft()
                    }
                    onReleased: {
                        leftButtonGlow.glowEnable = false
                        leftArrow.selected = false
                    }
                }

                MouseArea {
                    id: moveRightArea

                    implicitWidth:  bigRoundBtnRoot.width/4
                    implicitHeight:  width

                    anchors {
                        right: buttonOutterEmboss.right
                        verticalCenter: buttonOutterEmboss.verticalCenter
                    }

                    onPressed: {
                        rightButtonGlow.glowEnable = bigRoundBtnRoot.enableEffects
                        rightArrow.selected = true
                        pressedRight()
                    }
                    onReleased: {
                        rightButtonGlow.glowEnable = false
                        rightArrow.selected = false
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
                brightness: bigRoundBtnRoot.glowBrightness
                blurEnabled: buttonGlowRoot.glowEnable
                blurMax: bigRoundBtnRoot.glowBlurMax
                blur: 1
                opacity: bigRoundBtnRoot.glowEffectOpacity
                visible: buttonGlowRoot.glowEnable
            }

            Rectangle {
                id: glowBase
                width: bigRoundBtnRoot.width
                height: glowBase.width
                radius: glowBase.width/2
                color:  bigRoundBtnRoot.glowBaseColor
                visible: false
                anchors.fill: buttonGlowRoot
            }
        }
    }
}

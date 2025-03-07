import QtQuick
import QtQuick.Effects

Item {
    id: movePage
    anchors.fill: parent

    component ButtonGlow: Item {

    }

    Rectangle{
        width:parent.width
        height:parent.height
        anchors.fill: parent
        border.color: "red"
        border.width: 2
        color: "transparent"
        visible: false
    }

    CustomTumbler {
        id: moveTumbler
        title: "STEPS SIZE"
        model: [1,5,10,25,50]

        effectBlurMax: Style.embossBlurMax
        effectBlurMultiplier: Style.embossBlurMultiplier
        effectBlurEnabled: Style.enableEffects
        effectEmbossBrightness: Style.embossBrightness
        effectShadowColor: Style.shadowColor
        effectShadowOffset: Style.shadowOffset
        textColorHighlight: Style.displayTextAltColor
        textColor: Style.displaySeparatorColor
        titleColor: Style.displayTextAltColor
        backgroundColor: Style.darkBkgColor
        borderColor: Style.baseColor
        highlightBarColor: Style.barSeparatorColor

        anchors {
            right: movePage.right
            bottom: movePage.bottom
            bottomMargin: 50
            rightMargin: 60
        }
    }

    CustomRoundButton {
        id: heatButton
        buttonText: "HEAT"

        buttonColorBase :  Style.baseColor
        borderColorBase : Style.darkBkgColor
        textColorBase: Style.displayTextAltColor
        baseColorHighlight : Style.roundButtonsHighlight
        effectBlurMax: Style.embossBlurMax
        effectBlurEnabled: Style.enableEffects

        anchors {
            bottom: movePage.bottom
            bottomMargin: 170
            horizontalCenter: moveTumbler.horizontalCenter
        }
    }

    CustomRoundButton {
        id: resetButton
        buttonText: "RESET POS."

        buttonColorBase :  Style.baseColor
        borderColorBase : Style.darkBkgColor
        textColorBase: Style.displayTextAltColor
        baseColorHighlight : Style.roundButtonsHighlight
        effectBlurMax: Style.embossBlurMax
        effectBlurEnabled: Style.enableEffects

        anchors {
            bottom: movePage.bottom
            bottomMargin: 250
            horizontalCenter: heatButton.horizontalCenter
        }
    }

    MultiEffect {
        id: bigButtonEmboss
        source:  bigRoundButton
        anchors.fill: bigRoundButton
        blurEnabled: Style.enableEffects
        blur: 1
        blurMax: Style.bigButtonsEmbossBlurMax
        blurMultiplier: Style.embossBlurMultiplier
        brightness: blurEnabled ? Style.embossBrightness : 0
    }

    MultiEffect {
        id: bigButtonDropShadow
        source: bigRoundButton
        anchors.fill: bigRoundButton
        shadowEnabled: Style.enableEffects
        shadowVerticalOffset: Style.shadowOffset
        shadowColor: Style.shadowColor
        blurMax: Style.bigButtonsEmbossBlurMax
    }

    Rectangle {
        id: bigRoundButton
        width: 260
        height: width
        radius: width/2
        color: Style.buttonOffColor
        border.width: 6
        border.color: Style.baseColor

        anchors{
            right: movePage.right
            bottom: movePage.bottom
            bottomMargin: 40
            rightMargin: 280
        }

        Rectangle {
            id: buttonHighlight
            width: bigRoundButton.width-20
            height: width
            radius: width/2

            gradient: Gradient {
                GradientStop { position: 0; color: Qt.tint(Style.baseColorLight, Qt.hsla(0,0,1,0.1)) }
                GradientStop { position: 1.0; color: Qt.tint(Style.baseColor, Qt.hsla(0,0,0,0.5)) }
            }

            anchors.centerIn: bigRoundButton

            Rectangle {
                id: buttonOutterEmboss
                width: buttonHighlight.width-6
                height: width
                radius: width/2

                gradient: Gradient {
                    GradientStop { position: 0.1; color: Qt.tint(Style.baseColor, Qt.hsla(0,0,1,0.1)) }
                    GradientStop { position: 1.0; color: Qt.tint(Style.baseColor, Qt.hsla(0,0,0,0.2)) }
                }

                anchors.centerIn: buttonHighlight

                Rectangle {
                    id: buttonInnerEmboss
                    width: buttonOutterEmboss.width-22
                    height: width
                    radius: width/2

                    gradient: Gradient {
                        GradientStop { position: 0.1; color: Qt.tint(Style.baseColor, Qt.hsla(0,0,0,0.1)) }
                        GradientStop { position: 1.0; color: Qt.tint(Style.baseColor, Qt.hsla(0,0,1,0.15)) }
                    }

                    anchors.centerIn: buttonOutterEmboss
                }
            }
        }
    }
}

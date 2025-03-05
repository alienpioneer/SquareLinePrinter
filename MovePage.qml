import QtQuick

Item {
    id: movePage
    anchors.fill: parent

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
        baseColorHighlight : Style.highlightColor
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
        baseColorHighlight : Style.highlightColor
        effectBlurMax: Style.embossBlurMax
        effectBlurEnabled: Style.enableEffects

        anchors {
            bottom: movePage.bottom
            bottomMargin: 250
            horizontalCenter: heatButton.horizontalCenter
        }
    }

}

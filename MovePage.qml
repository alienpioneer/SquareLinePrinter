import QtQuick
import QtQuick.Effects
import "Components" as Components

Item {
    id: movePage
    anchors.fill: parent

    property vector3d currentPosition : Qt.vector3d(185,250,25)

    Components.CustomTumbler {
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

    Components.CustomRoundButton {
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

    Components.CustomRoundButton {
        id: resetButton
        buttonText: "RESET POS."

        toggle: true

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

        onButtonPressed: {
            movePage.currentPosition = Qt.vector3d(185,250,25)
        }
    }

    Components.BigRoundButton {
        id: moveButton

        anchors{
            right: movePage.right
            bottom: movePage.bottom
            bottomMargin: 40
            rightMargin: 260
        }

        text: "MOVE\nXY"
        textColor: Style.displayTextAltColor
        arrowsColor: Style.displayTextAltColor

        baseColor: Style.baseColor
        highlightColor: Style.baseColorLight
        offColor: Style.buttonOffColor

        enableEffects: Style.enableEffects
        glowBaseColor: Style.roundButtonsHighlight
        glowBlurMax: Style.bigButtonsGlowBlurMax

        embossBlurMax: Style.bigButtonsEmbossBlurMax
        embossBlurMultiplier: Style.embossBlurMultiplier
        embossBrightness: Style.embossBrightness

        shadowColor: Style.shadowColor
        shadowOffset: Style.shadowOffset

        onPressedUp: {
            currentPosition.y +=  parseInt(moveTumbler.currentSelection.modelData)
        }

        onPressedDown: {
            currentPosition.y -= parseInt(moveTumbler.currentSelection.modelData)
        }

        onPressedRight: {
            currentPosition.x +=  parseInt(moveTumbler.currentSelection.modelData)
        }

        onPressedLeft: {
            currentPosition.x -=  parseInt(moveTumbler.currentSelection.modelData)
        }
    }

    Components.BigRectangularButton {
        id: moveZButton

        anchors{
            left: movePage.left
            bottom: movePage.bottom
            bottomMargin: 40
            leftMargin: 40
        }

        buttonRadius: 30

        text: "MOVE\nZ"
        textColor: Style.displayTextAltColor
        arrowsColor: Style.displayTextAltColor

        baseColor: Style.baseColor
        highlightColor: Style.baseColorLight
        offColor: Style.buttonOffColor

        enableEffects: Style.enableEffects
        glowBaseColor: Style.roundButtonsHighlight
        glowBlurMax: Style.bigButtonsGlowBlurMax

        embossBlurMax: Style.bigButtonsEmbossBlurMax
        embossBlurMultiplier: Style.embossBlurMultiplier
        embossBrightness: Style.embossBrightness

        shadowColor: Style.shadowColor
        shadowOffset: Style.shadowOffset

        onPressedUp: {
            currentPosition.z +=  parseInt(moveTumbler.currentSelection.modelData)
        }

        onPressedDown: {
            currentPosition.z -= parseInt(moveTumbler.currentSelection.modelData)
        }
    }

    Components.SpecialDisplay {
        id: xyDisplay

        width: 280
        height: 80

        anchors {
            right: movePage.right
            top: movePage.top
            rightMargin: 240
            topMargin: 75
        }

        leftUpperText: "X Position"
        rightUpperText: "Y Position"
        rightLowerText: `${currentPosition.y}`
        leftLowerText: `${currentPosition.x}`

        backgroundColor: Style.darkBkgColor
        backgroundBorderColor: Style.borderColor
        separatorColor: Style.displaySeparatorColor
        upperTextColor: Style.displayTextColor
        lowerTextColor: Style.displayTextAltColor
    }

    Components.SpecialDisplay {
        id: zDisplay

        width: 120
        height: 80

        anchors {
            left: movePage.left
            top: movePage.top
            leftMargin: 25
            topMargin: 75
        }

        rightUpperText: "Z Position"
        rightLowerText: `${currentPosition.z}`

        backgroundColor: Style.darkBkgColor
        backgroundBorderColor: Style.borderColor
        separatorColor: Style.displaySeparatorColor
        upperTextColor: Style.displayTextColor
        lowerTextColor: Style.displayTextAltColor
    }
}

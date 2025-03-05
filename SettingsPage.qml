import QtQuick
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Effects
import QtQuick.Controls.Basic

pragma ComponentBehavior: Bound

Item {
    id: settingsPage
    anchors.fill: parent

    // Check Rectangle
    Rectangle{
        width:parent.width
        height:parent.height
        anchors.fill: parent
        border.color: "green"
        border.width: 2
        color: "transparent"
        visible: false
    }

    component SpecialSwitch: ColumnLayout {

        id: rootSpecialSwitch

        property string switchText: ""
        property bool switchChecked: false

        Text {
            text: rootSpecialSwitch.switchText
            color: Style.displayTextAltColor
            font.pixelSize: 17
            font.bold: true
            Layout.alignment: Qt.AlignCenter
        }

        Rectangle {
            id: switchBackground
            implicitWidth: 100
            implicitHeight: 40

            radius: 26
            color: Style.darkBkgColor

            // Gradient bkg
            Rectangle {
                width: rootSpecialSwitch.switchChecked ? switchBackground.width-12 : 0
                height: switchBackground.height-10
                radius: switchBackground.radius-6

                visible: width > switchHandle.width/4

                anchors {
                    left: switchBackground.left
                    top: switchBackground.top
                    leftMargin: 6
                    topMargin: 5
                }

                gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0; color: Style.highlightColor }
                            GradientStop { position: 1; color: Style.highlightColorDarker }
                        }

                Behavior on width {
                    NumberAnimation { duration: 100 }
                }
            }

            // Switch Handle
            Rectangle {
                id: switchHandle
                implicitWidth: 30
                implicitHeight: width
                radius: width/2

                anchors.top: switchBackground.top
                anchors.topMargin: 5
                x: rootSpecialSwitch.switchChecked ? switchBackground.width-width-5 : 5

                gradient: Gradient {
                    GradientStop { position: 0; color: Style.baseColorLight }
                    GradientStop { position: 1; color: Style.baseColor }
                }

                Behavior on x {
                    NumberAnimation { duration: 100 }
                }
            }

            MouseArea {
                anchors.fill: switchBackground
                onClicked: {
                    rootSpecialSwitch.switchChecked = !rootSpecialSwitch.switchChecked;
                }
            }
        }
    }

    component CustomTumblerGroup: Item {
        id: groupRootTumbler

        implicitWidth: 150
        implicitHeight: 150

        property string groupTitle: ""
        property variant groupModel: []
        property string groupButtonText : ""

        CustomTumbler {
            id: rootTumbler
            title:  groupRootTumbler.groupTitle
            model:  groupRootTumbler.groupModel

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
        }

        CustomRoundButton {
            id: rootButton
            buttonText:  groupRootTumbler.groupButtonText

            buttonColorBase :  Style.baseColor
            borderColorBase : Style.darkBkgColor
            textColorBase: Style.displayTextAltColor
            baseColorHighlight : Style.highlightColor
            effectBlurMax: Style.embossBlurMax
            effectBlurEnabled: Style.enableEffects

            anchors {
                top: rootTumbler.bottom
                topMargin: 40
                horizontalCenter: rootTumbler.horizontalCenter
            }
        }
    }

    // Tumblers
    Row {
        id: tumblersRow
        spacing: 30

        anchors {
            top: parent.top
            topMargin: 100
            left: parent.left
            leftMargin: 25
        }

        CustomTumblerGroup {
            id: headTemp
            groupTitle: "HEAD TEMP."
            groupModel: ["240°", "255°", "220°", "170°"]
            groupButtonText: "HEAT HEAD"
        }

        CustomTumblerGroup {
            id: bedTemp
            groupTitle: "BED TEMP."
            groupModel: ["60°","75°", "80°", "90°"]
            groupButtonText: "HEAT BED"
        }

        CustomTumblerGroup {
            id: materialTemp
            groupTitle: "MATERIAL"
            groupModel: ["PLA", "ABS", "PETG", "NYL", "FLEX"]
            groupButtonText: "REMOVE\nFILAMENT"
        }
    }

    // Big slider labels
    Text {
        text: "PRINT SPEED"
        color: Style.displayTextAltColor
        font.pixelSize: 18
        font.bold: true
        anchors {
            left: sliderContainer.left
            leftMargin: 10
            bottom: sliderContainer.top
            bottomMargin: 5
        }
    }

    Text {
        text: `${Math.round(printSpeedSlider.value)} %`
        color: Style.displayTextAltColor
        font.pixelSize: 18
        font.bold: true
        anchors {
            right: sliderContainer.right
            rightMargin: 10
            bottom: sliderContainer.top
            bottomMargin: 5
        }
    }

    // Bottom big Slider
    Rectangle{
        id: sliderContainer

        width: 480
        height: 44

        anchors {
            bottom: settingsPage.bottom
            bottomMargin: 40
            left: settingsPage.left
            leftMargin: 40
        }

        border.width: 5
        radius: 24

        border.color: Style.darkBkgColor
        color: Style.sliderBkgColor

        Slider {
            id: printSpeedSlider
            width: 450
            height: sliderContainer.height/3

            from: 0
            to: 100
            value: 70

            anchors.centerIn: sliderContainer

            background: Rectangle {
                anchors.left: parent.left
                height: parent.height
                width: printerSpeedSliderHandle.x + printerSpeedSliderHandle.width/2
                radius: 30
                gradient: Gradient {
                            orientation: Gradient.Horizontal
                            GradientStop { position: 0; color: Style.highlightColor }
                            GradientStop { position: 1; color: Style.highlightColorDarker }
                        }
            }

            handle: Rectangle{
                id: printerSpeedSliderHandle

                x: printSpeedSlider.visualPosition * (printSpeedSlider.width - width)
                y: printSpeedSlider.topPadding + printSpeedSlider.availableHeight/2 - height/2

                implicitHeight: sliderContainer.height-2*sliderContainer.border.width
                implicitWidth: implicitHeight

                radius: width/2
                gradient: Gradient {
                    GradientStop { position: 0; color: Style.baseColorLight }
                    GradientStop { position: 1; color: Style.baseColor }
                }
            }
        }
    }

    // Right side switches
    Column {
        spacing: 33

        anchors {
            right: settingsPage.right
            rightMargin: 40
            bottom: settingsPage.bottom
            bottomMargin: 45
        }

        SpecialSwitch {
            id: materialSwitch
            switchText: "MATERIAL"
        }

        SpecialSwitch {
            id: fan1Switch
            switchText: "FAN 1"
        }

        SpecialSwitch {
            id: fan2Switch
            switchText: "FAN 2"
        }

        SpecialSwitch {
            id: fan3Switch
            switchText: "FAN 3"
        }
    }

}

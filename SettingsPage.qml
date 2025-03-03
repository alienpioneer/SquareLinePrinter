import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Shapes
import QtQuick.Effects

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
        id: rootTumbler

        implicitWidth: 150
        implicitHeight: 150

        property string title: ""
        property variant model: []
        property string buttonText : ""
        property bool selected: false

        MultiEffect {
            id: rootTumblerEmboss
            source:  tumblerContainer
            anchors.fill: tumblerContainer
            blurEnabled: Style.enableEffects
            blur: 1
            blurMax: Style.embossBlurMax
            blurMultiplier: Style.embossBlurMultiplier
            brightness: blurEnabled ? Style.embossBrightness : 0
        }

        MultiEffect {
            id: rootTumblerDropShadow
            source: tumblerContainer
            anchors.fill: tumblerContainer
            shadowEnabled: Style.enableEffects
            shadowColor: Style.shadowColor
            shadowScale: 1
            shadowVerticalOffset: Style.shadowOffset
        }

        Text {
            text: rootTumbler.title
            color: Style.displayTextAltColor
            font.pixelSize: 20
            font.bold: true
            anchors{
                horizontalCenter: tumblerContainer.horizontalCenter
                bottom: tumblerContainer.top
                bottomMargin: 8
            }
        }

        Rectangle {
            id: tumblerContainer

            implicitWidth: rootTumbler.width
            implicitHeight: rootTumbler.height

            radius: 20
            border.width: 5
            border.color: Style.baseColor
            color: Style.darkBkgColor
            clip: true

            Rectangle {
                implicitWidth: tumblerContainer.width-tumblerContainer.border.width*2
                implicitHeight: (tumblerContainer.height-tumblerContainer.border.width*2)/3
                anchors.centerIn: tumblerContainer
                color: Style.barIconColor
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
                    color: Style.displayTextAltColor
                    font.pixelSize: Math.max(0.7, 1 - Math.abs(Tumbler.displacement))*28
                    font.bold: true
                }
            }
        }

        MultiEffect {
            id: iconGlow
            source:  buttonContainer
            anchors.fill: buttonContainer
            brightness: 0.1
            blurEnabled: rootTumbler.selected ? Style.enableEffects : false
            blurMax: Style.embossBlurMax
            blur: 1
            opacity: 1
            visible: rootTumbler.selected
        }

        Rectangle {
            id: buttonContainer

            property int offset: 8

            implicitWidth: rootTumbler.width
            implicitHeight: 60
            radius: 30
            //color: rootTumbler.selected ? Style.highlightColor : Style.darkBkgColor
            color: rootTumbler.selected ? Style.highlightColor : Style.darkBkgColor

            anchors {
                top: tumblerContainer.bottom
                topMargin: 40
                horizontalCenter: tumblerContainer.horizontalCenter
            }

            visible: !rootTumbler.selected
        }

        Rectangle {
            id: innerButton

            implicitWidth: buttonContainer.width-buttonContainer.offset
            implicitHeight: buttonContainer.height-buttonContainer.offset
            radius: buttonContainer.radius+buttonContainer.offset
            color: Style.baseColor
            anchors.centerIn: buttonContainer
            // border.width: buttonContainer.offset
            // border.color: rootTumbler.selected ? Style.highlightColor : Style.darkBkgColor

            gradient: Gradient {
                GradientStop { position: 0.1; color: Qt.tint(innerButton.color, Qt.hsla(220/255,30/255,1,0.2)) }
                GradientStop { position: 1.0; color: Qt.tint(innerButton.color, Qt.hsla(0,0,0,0.1)) }
            }

            Text {
                id: buttonId
                text: rootTumbler.buttonText
                color: selected ? Style.highlightColor : Style.displayTextAltColor
                anchors.centerIn: innerButton
                horizontalAlignment: Qt.AlignHCenter
                font.pixelSize: 16
                font.bold: true
            }

            MouseArea {
                anchors.fill: innerButton
                onClicked: {
                    rootTumbler.selected = !rootTumbler.selected
                }
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
            title: "HEAD TEMP."
            model:["170°", "220°", "240°","255°"]
            buttonText: "HEAT HEAD"
        }

        CustomTumblerGroup {
            id: bedTemp
            title: "BED TEMP."
            model:["60°","75°", "80°", "90°"]
            buttonText: "HEAT BED"
        }

        CustomTumblerGroup {
            id: materialTemp
            title: "MATERIAL"
            model:["PLA","ABS", "PETG", "NYL", "FLEX"]
            buttonText: "REMOVE\nFILAMENT"
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

        width:480
        height:44

        anchors {
            bottom: settingsPage.bottom
            bottomMargin: 40
            left: settingsPage.left
            leftMargin: 40
        }

        border.width: 5
        radius:24

        border.color: Style.darkBkgColor
        color: "#2A3342"

        Slider {
            id: printSpeedSlider
            width: 450
            height: sliderContainer.height/3

            from: 0
            to: 100

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

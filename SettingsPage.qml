import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: settingsPage
    anchors.fill: parent

    component SpecialSwitch: ColumnLayout {

        id: rootSpecialSwitch

        property string switchText: "TEST"
        property bool switchChecked: false

        Text {
            text: rootSpecialSwitch.switchText
            color: Style.displayTextAltColor
            font.pixelSize: 16
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
                width: 30
                height: width
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
        }

        TapHandler {
            onTapped: {
                rootSpecialSwitch.switchChecked = !rootSpecialSwitch.switchChecked;
            }
        }
    }

    component CustomThumbler: Item {
        id: rootThumbler

        property int thumblerWidth: 10
        property int thumblerHeight: 10

        MultiEffect {
            id: rootThumblerEmboss
            source:  rootBackground
            anchors.fill: rootBackground
            blurEnabled: Style.enableEffects
            blur: 1
            blurMax: Style.embossBlurMax
            blurMultiplier: Style.embossBlurMultiplier
            brightness: blurEnabled ? Style.embossBrightness : 0
        }

        MultiEffect {
            id: rootThumblerDropShadow
            source: rootBackground
            anchors.fill: rootBackground
            shadowEnabled: Style.enableEffects
            shadowColor: Style.shadowColor
            shadowScale: 1
            shadowVerticalOffset: Style.shadowOffset
        }

        Rectangle {
            id: rootBackground
            width: rootThumbler.thumblerWidth
            height: rootThumbler.thumblerHeight
            radius: 20
            border.width: 5
            color: Style.darkBkgColor
            border.color: Style.baseColor
        }
    }

    RowLayout {
        spacing: 180

        anchors {
            top: parent.top
            topMargin: parent.height*0.2
            left: parent.left
            leftMargin: 25
        }

        CustomThumbler {
            id: thumblerA
            thumblerWidth: 150
            thumblerHeight: 150
        }

        CustomThumbler {
            id: thumblerB
            thumblerWidth: 150
            thumblerHeight: 150
        }

        CustomThumbler {
            id: thumblerC
            thumblerWidth: 150
            thumblerHeight: 150
        }

    }



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

    // Bottom big Slider
    Rectangle{
        width:480
        height:48

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
            height:16

            from: 0
            to: 100

            anchors.centerIn: parent

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

                // x: printSpeedSlider.visualPosition * (printSpeedSlider.availableWidth - width)
                x: printSpeedSlider.visualPosition * (printSpeedSlider.width - width)
                y: printSpeedSlider.topPadding + printSpeedSlider.availableHeight/2 - height/2

                implicitHeight: parent.height*2.3
                implicitWidth: implicitHeight

                radius: width/2
                gradient: Gradient {
                    GradientStop { position: 0; color: Style.baseColorLight }
                    GradientStop { position: 1; color: Style.baseColor }
                }
            }
        }
    }

    Column {
        spacing: 30

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

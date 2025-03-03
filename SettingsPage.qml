import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
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
        }

        TapHandler {
            onTapped: {
                rootSpecialSwitch.switchChecked = !rootSpecialSwitch.switchChecked;
            }
        }
    }

    component CustomTumbler: Item {
        id: rootTumbler

        implicitWidth: 150
        implicitHeight: 150

        property string title: ""
        property variant model: []

        // MultiEffect {
        //     id: rootTumblerEmboss
        //     source:  tumblerContainer
        //     anchors.fill: tumblerContainer
        //     blurEnabled: Style.enableEffects
        //     blur: 1
        //     blurMax: Style.embossBlurMax
        //     blurMultiplier: Style.embossBlurMultiplier
        //     brightness: blurEnabled ? Style.embossBrightness : 0
        // }

        // MultiEffect {
        //     id: rootTumblerDropShadow
        //     source: tumblerContainer
        //     anchors.fill: tumblerContainer
        //     shadowEnabled: Style.enableEffects
        //     shadowColor: Style.shadowColor
        //     shadowScale: 1
        //     shadowVerticalOffset: Style.shadowOffset
        // }

        Column {
            spacing: 10

            Text {
                text: rootTumbler.title
                color: Style.displayTextAltColor
                font.pixelSize: 20
                font.bold: true
                anchors.horizontalCenter: tumblerContainer.horizontalCenter
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
        }
    }

    // Tumblers
    Row {
        id: tumblersRow
        spacing: 30

        anchors {
            top: parent.top
            topMargin: 70
            left: parent.left
            leftMargin: 25
        }

        CustomTumbler {
            id: headTempTumbler
            title: "HEAD TEMP."
            model:["170°", "220°", "240°","255°"]
        }

        CustomTumbler {
            id: bedTempTumbler
            title: "BED TEMP."
            model:["60°","75°", "80°", "90°"]
        }

        CustomTumbler {
            id: materialTempTumbler
            title: "MATERIAL"
            model:["PLA","ABS", "PETG", "NYL", "FLEX"]
        }
    }

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

// component CustomTumbler: Rectangle {
//     id: rootCustomTumbler

//     property variant model: []

//     implicitWidth: 150
//     implicitHeight: 150
//     radius: 20
//     border.width: 5
//     color: Style.darkBkgColor
//     border.color: Style.baseColor

//     Tumbler {
//         id: rootTumbler
//         anchors.fill: rootCustomTumbler

//         contentItem: ListView {
//             model: rootCustomTumbler.model
//             required property string index
//             anchors.margins: 5

//             delegate: Rectangle {
//                 width: rootCustomTumbler.width-rootCustomTumbler.border*2
//                 height: 50
//                 color: "red"
//             }

//             clip: true
//             snapMode: ListView.SnapToItem
//             spacing: 1


//         }
//         containmentMask: rootCustomTumbler

//     }
// }




// RowLayout {
//     id: thumblersRow
//     spacing: 30

//     anchors {
//         top: parent.top
//         topMargin: parent.height*0.2
//         left: parent.left
//         leftMargin: 25
//     }

//     // Rectangle {
//     //     width: 150
//     //     height: 150
//     //     radius: 20
//     //     border.width: 5
//     //     color: Style.darkBkgColor
//     //     border.color: Style.baseColor
//     // }

//     // Rectangle {
//     //     width: 150
//     //     height: 150
//     //     radius: 20
//     //     border.width: 5
//     //     color: Style.darkBkgColor
//     //     border.color: Style.baseColor
//     // }

//     // Rectangle {
//     //     width: 150
//     //     height: 150
//     //     radius: 20
//     //     border.width: 5
//     //     color: Style.darkBkgColor
//     //     border.color: Style.baseColor
//     // }

//     // Text {
//     //     text: rootCustomTumbler.title
//     //     color: Style.displayTextAltColor
//     //     font.pixelSize: 20
//     //     font.bold: true
//     //     Layout.alignment: Qt.AlignHCenter
//     // }

//     // CustomTumbler {
//     //     id: headTempTumbler
//     //     //title: "HEAD TEMP."
//     //     model:["170", "220", "240","255"]
//     // }

//     // CustomTumbler {
//     //     id: bedTempTumbler
//     //     //title: "BED TEMP."
//     //     model:["60°","75°", "80°", "90°"]
//     // }

//     // CustomTumbler {
//     //     id: materialTempTumbler
//     //     //title: "MATERIAL"
//     //     model:["PLA","ABS", "PETG", "NYL", "FLEX"]
//     // }

//     Tumbler {
//         id: headTempTumbler
//         background: ThumblerBackground { id: headTempTumblerBkg}
//         contentItem: ListView {
//             anchors.fill: headTempTumblerBkg
//             model:["170", "220", "240","255"]

//             delegate: ThumblerDelegate {}

//             clip: true
//             snapMode: ListView.SnapToItem
//             boundsBehavior: Flickable.StopAtBounds
//             // spacing: 1
//             }
//     }

//     Tumbler {
//         id: bedTempTumbler
//         width: 150
//         height: 150
//         visibleItemCount : 3
//         model:["60°","75°", "80°", "90°"]
//         background: ThumblerBackground { id: bedTempTumblerBkg}
//         delegate: ThumblerDelegate {
//             implicitWidth : bedTempTumblerBkg.width-bedTempTumblerBkg.border*2-20
//             implicitHeight: bedTempTumblerBkg.height/3-bedTempTumblerBkg.border*2
//         }
//     }

//     Tumbler {
//         id: materialTempTumbler
//         visibleItemCount : 3
//         model:["PLA","ABS", "PETG", "NYL", "FLEX"]
//         background: ThumblerBackground { id: materialTempTumblerBkg}
//     }
// }

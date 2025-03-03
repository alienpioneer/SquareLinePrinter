import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Effects

pragma ComponentBehavior: Bound

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

    component CustomTumbler: Tumbler {
        id: rootCustomTumbler

        background: Rectangle {
            id: bkgRect
            implicitWidth: 150
            implicitHeight: 150
            radius: 20
            border.width: 5
            color: Style.darkBkgColor
            border.color: Style.baseColor
            clip: true
        }

        contentItem: ListView {
            id: listView
            model: rootCustomTumbler.model

            //delegate:

            clip: true
            snapMode: ListView.SnapToItem
            boundsBehavior: Flickable.StopAtBounds
            // spacing: 1
        }
    }

    component ThumblerBackground: Rectangle {
        implicitWidth: 150
        implicitHeight: 150
        radius: 20
        border.width: 5
        color: Style.darkBkgColor
        border.color: Style.baseColor
    }

    component ThumblerDelegate: Rectangle {
        id: thumblerDelegate

        required property int index
        required property string modelData

        implicitWidth: 150
        implicitHeight: 40
        border.width: 5
        border.color: "black"
        color: "transparent"
        clip: true

        Text {
            anchors.fill: thumblerDelegate
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: thumblerDelegate. modelData
            color: Style.displayTextAltColor
            font.pixelSize: 16
            font.bold: true
        }
    }

    Rectangle {
        id: thumblerBkg

        anchors {
            top: parent.top
            topMargin: parent.height*0.2
            left: parent.left
            leftMargin: 25
        }

        implicitWidth: 150
        implicitHeight: 150
        radius: 20
        border.width: 5
        border.color: Style.baseColor
        color: Style.darkBkgColor
        clip: true

        Rectangle {
            width: thumblerBkg.implicitWidth-thumblerBkg.border.width*2
            height: (thumblerBkg.height-thumblerBkg.border.width*2)/3
            anchors.centerIn: thumblerBkg
            color: Style.baseColorLight
        }

        Tumbler {
            id: bedTempTumbler
            anchors.centerIn: thumblerBkg

            implicitWidth: thumblerBkg.width
            implicitHeight: thumblerBkg.height-thumblerBkg.border.width*2

            //Background+borders dictates the implicit size !!!
            visibleItemCount : 3
            model:["60°","75°", "80°", "90°"]

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

// MultiEffect {
//     id: rootThumblerEmboss
//     source:  thumblersRow
//     anchors.fill: thumblersRow
//     blurEnabled: Style.enableEffects
//     blur: 1
//     blurMax: Style.embossBlurMax
//     blurMultiplier: Style.embossBlurMultiplier
//     brightness: blurEnabled ? Style.embossBrightness : 0
// }

// MultiEffect {
//     id: rootThumblerDropShadow
//     source: thumblersRow
//     anchors.fill: thumblersRow
//     shadowEnabled: Style.enableEffects
//     shadowColor: Style.shadowColor
//     shadowScale: 1
//     shadowVerticalOffset: Style.shadowOffset
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

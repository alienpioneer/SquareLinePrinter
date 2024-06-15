import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Window {
    id: mainWindow
    width: 800
    height: 480
    visible: true
    title: qsTr("Printer")
    color: "#586E95"
    //flags: Qt.FramelessWindowHint

    Rectangle {
        id: leftBar
        width: 80
        height: parent.height
        color: "#2A3342"
        anchors.left: parent.left

        Rectangle {
            id: leftBarSeparator
            width: 5
            height: leftBar.height
            anchors.right: leftBar.right
            color: "#7F99C5"
        }
    }

    Item {
        id: mainViewItem
        anchors.top: parent.top
        anchors.topMargin: parent.height*0.25/2+parent.height*0.05
        anchors.left: leftBar.right
        anchors.leftMargin: 20

        Rectangle {
            id: mainView
            z: 10
            width: 300
            height: mainWindow.height*0.75
            radius: 20
            border.color: "#7F99C5"
            border.width: 5
            color: "#2A3342"
            gradient: Gradient {
                        GradientStop { position: 0.3; color: "#6D82A5" }
                        GradientStop { position: 1.0; color: "#2A3342" }
                    }
        }

        MultiEffect {
            id: mainViewDropShadow
            z: 3
            source: mainView
            anchors.fill: mainView
            shadowEnabled: true
            shadowColor: "#191F2A"
            blurMultiplier: 1.2
            shadowVerticalOffset: 14
            visible: true
        }

        MultiEffect {
            id: mainViewEmboss
            z: 2
            source:  mainView
            anchors.fill: mainView
            brightness: 0.3
            blurEnabled: true
            blurMax: 32
            blur: 1
            visible: true
        }
    }

    component SpecialButton: Item {

        height: width
        property alias shadowVisible: buttonDropShadow.visible
        property alias embossVisible: buttonEmboss.visible
        property bool showBorders: checker.visible = false

        Rectangle{
            id: checker
            width:parent.width
            height:parent.height
            anchors.fill: parent
            border.color: "red"
            border.width: 1
            z: 1
            color: "transparent"
        }

        Rectangle {
            id: buttonOuter
            z: 4
            width: parent.width
            height: width
            radius: 30
            color: "#586E95"
            anchors.centerIn: parent

            RoundButton {
                id: buttonContour
                z: 5
                width: buttonOuter.width*0.91
                height: buttonOuter.height*0.91
                radius: buttonOuter.radius-buttonOuter.radius*0.1
                anchors.centerIn: buttonOuter
                onPressed : {console.log("Button Pressed")}
                onReleased : {console.log("Button Released")}
                background: Rectangle {
                    id: buttonContourBkg
                    radius: parent.radius
                    anchors.fill: parent
                    color: buttonContour.down ? "#7AEFFF" : "#161A23"
                }
            }

            Rectangle {
                id: buttonBevel
                z: 6
                width: buttonContour.width*0.92
                height: buttonContour.height*0.92
                anchors.centerIn: buttonContour
                radius: buttonContour.radius - buttonContour.radius*0.1
                gradient: Gradient {
                    GradientStop { position: 0.1; color: "#8CA1C6" }
                    GradientStop { position: 1.0; color: "#354158" }
                }
                visible: true
            }

            Rectangle {
                id: buttonInner
                z: 7
                width: buttonBevel.width*0.92
                height: buttonBevel.height*0.92
                anchors.centerIn: buttonBevel
                radius: buttonBevel.radius - buttonBevel.radius*0.1
                gradient: Gradient {
                    GradientStop { position: 0.1; color: "#61779D" }
                    GradientStop { position: 1.0; color: "#455572" }
                }
            }
        }

        MultiEffect {
            id: buttonDropShadow
            z: 3
            source: buttonOuter
            anchors.fill: buttonOuter
            shadowEnabled: true
            shadowColor: "#10131A"
            blurMultiplier: 1.2
            shadowVerticalOffset: 14
            visible: true
        }

        MultiEffect {
            id: buttonEmboss
            z: 2
            source:  buttonOuter
            anchors.fill: buttonOuter
            brightness: 0.5
            blurEnabled: true
            blurMax: 36
            blur: 1
            blurMultiplier: 2
            visible: true
        }
    }

    SpecialButton{
        id: stopButton
        width:110
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 160
        anchors.bottomMargin: 160
        // showBorders: true

        Rectangle {
            id: stopButtonIcon
            z:11
            width: stopButton.width*0.38
            height: width
            anchors.centerIn: parent
            radius: 6
            border.color: "#B4CBF5"
            border.width: 5
            color: "transparent"
        }
    }

    // Item {
    //     id: stopButton
    //     anchors.right: parent.right
    //     anchors.bottom: parent.bottom
    //     anchors.rightMargin: 160
    //     anchors.bottomMargin: 160

    //     Rectangle {
    //         id: stopButtonOuter
    //         width: 110
    //         height: 110
    //         z:7
    //         radius: 30
    //         color: "#586E95"

    //         RoundButton {
    //             id: stopButtonContour
    //             width: stopButtonOuter.width*0.91
    //             height: stopButtonOuter.height*0.91
    //             z:8
    //             radius: stopButtonOuter.radius-stopButtonOuter.radius*0.1
    //             anchors.centerIn: stopButtonOuter
    //             onPressed : {console.log("Button Pressed")}
    //             onReleased : {console.log("Button Released")}
    //             background: Rectangle {
    //                 id: stopButtonContourBkg
    //                 radius: parent.radius
    //                 anchors.fill: parent
    //                 color: stopButtonContour.down ? "#7AEFFF" : "#161A23"
    //             }
    //         }

    //         Rectangle {
    //             id: stopButtonBevel
    //             width: stopButtonContour.width*0.92
    //             height: stopButtonContour.height*0.92
    //             z:9
    //             anchors.centerIn: stopButtonContour
    //             radius: stopButtonContour.radius-stopButtonContour.radius*0.1
    //             gradient: Gradient {
    //                 GradientStop { position: 0.1; color: "#8CA1C6" }
    //                 GradientStop { position: 1.0; color: "#354158" }
    //             }
    //             visible: true
    //         }

    //         Rectangle {
    //             id: stopButtonInner
    //             width: stopButtonBevel.width*0.92
    //             height: stopButtonBevel.height*0.92
    //             z:10
    //             anchors.centerIn: stopButtonBevel
    //             radius: stopButtonBevel.radius - stopButtonBevel.radius*0.1
    //             gradient: Gradient {
    //                 GradientStop { position: 0.1; color: "#61779D" }
    //                 GradientStop { position: 1.0; color: "#455572" }
    //             }
    //         }

    //         Rectangle {
    //             id: stopButtonIcon
    //             width: stopButtonInner.width*0.38
    //             height: stopButtonInner.height*0.38
    //             z:11
    //             anchors.centerIn: stopButtonInner
    //             radius: 6
    //             border.color: "#B4CBF5"
    //             border.width: 5
    //             gradient: Gradient {
    //                 GradientStop { position: 0.1; color: "#61779D" }
    //                 GradientStop { position: 1.0; color: "#455572" }
    //             }
    //         }
    //     }

    //     MultiEffect {
    //         id: stopButtonDropShadow
    //         z: 6
    //         source: buttonOuter
    //         anchors.fill: buttonOuter
    //         shadowEnabled: true
    //         shadowColor: "#10131A"
    //         blurMultiplier: 1.2
    //         shadowVerticalOffset: 14
    //         visible: true
    //     }

    //     MultiEffect {
    //         id: stopButtonEmboss
    //         z: 5
    //         source:  buttonOuter
    //         anchors.fill: buttonOuter
    //         brightness: 0.5
    //         blurEnabled: true
    //         blurMax: 36
    //         blur: 1
    //         blurMultiplier: 2
    //         visible: true
    //     }
    // }

}

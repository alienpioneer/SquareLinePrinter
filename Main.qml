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

    Item {
        id: stopButton
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 160
        anchors.bottomMargin: 160

        Rectangle {
            id: stopButtonOuter
            width: 110
            height: 110
            z:7
            radius: 30
            color: "#586E95"

            RoundButton {
                id: stopButtonContour
                width: stopButtonOuter.width*0.91
                height: stopButtonOuter.height*0.91
                z:8
                radius: stopButtonOuter.radius-stopButtonOuter.radius*0.1
                anchors.centerIn: stopButtonOuter
                onPressed : {console.log("Button Pressed")}
                onReleased : {console.log("Button Released")}
                background: Rectangle {
                    id: stopButtonContourBkg
                    radius: parent.radius
                    anchors.fill: parent
                    color: stopButtonContour.down ? "#7AEFFF" : "#161A23"
                }
            }

            Rectangle {
                id: stopButtonBevel
                width: stopButtonContour.width*0.92
                height: stopButtonContour.height*0.92
                z:9
                anchors.centerIn: stopButtonContour
                radius: stopButtonContour.radius-stopButtonContour.radius*0.1
                gradient: Gradient {
                    GradientStop { position: 0.1; color: "#8CA1C6" }
                    GradientStop { position: 1.0; color: "#354158" }
                }
                visible: true
            }

            Rectangle {
                id: stopButtonInner
                width: stopButtonBevel.width*0.92
                height: stopButtonBevel.height*0.92
                z:10
                anchors.centerIn: stopButtonBevel
                radius: stopButtonBevel.radius - stopButtonBevel.radius*0.1
                gradient: Gradient {
                    GradientStop { position: 0.1; color: "#61779D" }
                    GradientStop { position: 1.0; color: "#455572" }
                }
            }

            Rectangle {
                id: stopButtonIcon
                width: stopButtonInner.width*0.38
                height: stopButtonInner.height*0.38
                z:11
                anchors.centerIn: stopButtonInner
                radius: 6
                border.color: "#B4CBF5"
                border.width: 5
                gradient: Gradient {
                    GradientStop { position: 0.1; color: "#61779D" }
                    GradientStop { position: 1.0; color: "#455572" }
                }
            }
        }

        MultiEffect {
            id: stopButtonDropShadow
            z: 6
            source: stopButtonOuter
            anchors.fill: stopButtonOuter
            shadowEnabled: true
            shadowColor: "#10131A"
            blurMultiplier: 1.2
            shadowVerticalOffset: 14
            visible: true
        }

        MultiEffect {
            id: stopButtonEmboss
            z: 5
            source:  stopButtonOuter
            anchors.fill: stopButtonOuter
            brightness: 0.5
            blurEnabled: true
            blurMax: 36
            blur: 1
            blurMultiplier: 2
            visible: true
        }
    }

}

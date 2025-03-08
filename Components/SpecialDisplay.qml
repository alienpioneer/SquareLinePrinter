import QtQuick
import QtQuick.Shapes
import QtQuick.Layouts

Item {
    id: specialDisplayRoot

    implicitWidth: 300
    implicitHeight: 80

    property color backgroundColor
    property color backgroundBorderColor

    property color separatorColor

    property color upperTextColor
    property color lowerTextColor

    property alias leftUpperText: leftUpperText.text
    property alias leftLowerText: leftLowerText.text
    property alias rightUpperText: rightUpperText.text
    property alias rightLowerText: rightLowerText.text

    // Indicator used for debug
    Rectangle{
        width: parent.width
        height: parent.height
        anchors.fill: parent
        border.color: "red"
        border.width: 1
        color: "transparent"
        visible: false
    }

    // Background rectangle
    Rectangle {
        id: dispayBkg
        width: specialDisplayRoot.width
        height: specialDisplayRoot.heigh
        anchors.fill: specialDisplayRoot
        radius: 16

        border.width: 3
        color: specialDisplayRoot.backgroundColor
        border.color: specialDisplayRoot.backgroundBorderColor

        Rectangle {
            id: displaySeparator
            anchors.centerIn: dispayBkg
            width: 2
            height: specialDisplayRoot.height - specialDisplayRoot.height*0.4
            color: specialDisplayRoot.separatorColor
            visible: leftUpperText.text === "" ? false : true
        }

        RowLayout {
            anchors.centerIn: dispayBkg
            spacing: 60

            ColumnLayout {
                spacing: 2
                visible: leftUpperText.text === "" ? false : true

                Text {
                    id: leftUpperText
                    font.pixelSize: 18
                    font.bold: true
                    color: specialDisplayRoot.upperTextColor
                    Layout.alignment: Qt.AlignCenter
                }

                Text {
                    id: leftLowerText
                    font.pixelSize: 26
                    color: specialDisplayRoot.lowerTextColor
                    Layout.alignment: Qt.AlignCenter
                }
            }

            ColumnLayout {
                spacing: 2

                Text {
                    id: rightUpperText
                    font.pixelSize: 18
                    font.bold: true
                    color: specialDisplayRoot.upperTextColor
                    Layout.alignment: Qt.AlignCenter
                }

                Text {
                    id: rightLowerText
                    font.pixelSize: 26
                    color: specialDisplayRoot.lowerTextColor
                    Layout.alignment: Qt.AlignCenter
                }
            }
        }
    }
}

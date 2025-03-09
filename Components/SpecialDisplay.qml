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

    property color titleColor
    property color valueColor
    property color valueAltColor

    property bool hasLeftIcon: false
    property bool hasRightIcon: false
    property bool checkLeftIcon: false
    property bool checkRightIcon: false
    property alias leftIconItem: displayLeftIcon.data
    property alias rightIconItem: displayRightIcon.data

    // If there is no left text, the screen has only one column !
    property alias leftTitleText: leftTitleText.text
    property alias leftValueText: leftValueText.text
    property alias leftValueAltText: leftValueAltText.text

    property alias rightTitleText: rightTitleText.text
    property alias rightValueText: rightValueText.text
    property alias rightValueAltText: rightValueAltText.text

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
            visible: leftTitleText.text === "" ? false : true
        }

        RowLayout {
            anchors.centerIn: dispayBkg
            spacing: leftValueAltText.text === "" ? 60 : 30

            ColumnLayout {
                spacing: 2
                visible: leftTitleText.text === "" ? false : true

                Text {
                    id: leftTitleText
                    font.pixelSize: 18
                    font.bold: true
                    color: specialDisplayRoot.titleColor
                    Layout.alignment: Qt.AlignCenter
                }

                RowLayout {
                    Layout.alignment: Qt.AlignCenter
                    spacing: leftValueAltText.text === "" ? 10 : 6

                    Item {
                        id: displayLeftIcon

                        implicitWidth: 20
                        implicitHeight: 20

                        visible: specialDisplayRoot.hasLeftIcon

                        Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "transparent"
                            border.width: 1
                            border.color: "red"
                            visible: specialDisplayRoot.checkLeftIcon
                        }
                    }

                    Text {
                        id: leftValueText
                        font.pixelSize: 26
                        color: specialDisplayRoot.valueColor
                        Layout.alignment: Qt.AlignCenter
                    }

                    Text {
                        id: leftValueAltText
                        font.pixelSize: 20
                        color: specialDisplayRoot.valueAltColor
                        Layout.alignment: Qt.AlignCenter
                        visible: leftValueAltText.text === "" ? false : true
                    }
                }
            }

            ColumnLayout {
                spacing: 2

                Text {
                    id: rightTitleText
                    font.pixelSize: 18
                    font.bold: true
                    color: specialDisplayRoot.titleColor
                    Layout.alignment: Qt.AlignCenter
                }

                RowLayout {
                    Layout.alignment: Qt.AlignCenter
                    spacing: rightValueAltText.text === "" ? 10 : 6

                    Item {
                        id: displayRightIcon

                        implicitWidth: 20
                        implicitHeight: 20

                        visible: specialDisplayRoot.hasRightIcon

                        Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "transparent"
                            border.width: 1
                            border.color: "red"
                            visible: specialDisplayRoot.checkRightIcon
                        }
                    }

                    Text {
                        id: rightValueText
                        font.pixelSize: 26
                        color: specialDisplayRoot.valueColor
                        Layout.alignment: Qt.AlignCenter
                    }

                    Text {
                        id: rightValueAltText
                        font.pixelSize: 20
                        color: specialDisplayRoot.valueAltColor
                        Layout.alignment: Qt.AlignCenter
                        visible: rightValueAltText.text === "" ? false : true
                    }
                }
            }
        }
    }
}

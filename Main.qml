import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Shapes

Window {
    id: mainWindow
    width: 800
    height: 480
    visible: true
    title: qsTr("Printer")
    color: Style.baseColor
    //flags: Qt.FramelessWindowHint

    component BarSelector: Item{
        property alias barColor: selectorBarHighlight.color
        property alias barWidth: selectorBarHighlight.width
        property alias text: selectorText.text
        property alias textColor: selectorText.color
        property alias textSize: selectorText.font.pixelSize
        property alias iconItem: selectorIcon.data

        property bool active: false
        property int selectorId: 0

        signal pressed()

        Rectangle{
            id: selectorHightlight
            width: parent.width - selectorBarHighlight.width
            height: parent.height
            color: Qt.tint(leftBar.color, Qt.rgba(0.4,0.4,1,0.1));
            opacity: 0.7
            visible: active
        }

        Rectangle{
            id: selectorBarHighlight
            x: selectorHightlight.width
            height: parent.height
            visible: active
        }

        MultiEffect {
            id: iconGlow
            source:  iconColumn
            anchors.fill: iconColumn
            brightness: 0.5
            blurEnabled: true
            blurMax: 64
            blur: 1
            opacity: 0.8
            visible: active
        }

        Column {
            id: iconColumn
            anchors.centerIn: selectorHightlight
            spacing: 8
            Item{
                id:selectorIcon
                width: selectorHightlight.width/2
                height: selectorHightlight.width/2
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text{
                id: selectorText
                font.bold: true
            }
        }

        TapHandler {
            id: tapHandler
            onTapped: {
                parent.pressed();
            }
        }
    }

    Rectangle {
        id: leftBar
        width: 80
        height: parent.height
        color: Style.barColor
        anchors.left: parent.left

        property int currentSelection: 1

        Rectangle {
            id: leftBarSeparator
            width: 5
            height: leftBar.height
            anchors.right: leftBar.right
            color: "#687DA2"
        }

        BarSelector{
            id: printSelector
            selectorId: 1
            active: leftBar.currentSelection === selectorId

            width: parent.width
            height: parent.height/3
            barWidth: leftBarSeparator.width
            anchors.left: parent.left
            barColor: Style.highlightColor

            iconItem: Rectangle{
                width: 40
                height: width
                color: printSelector.active ? Style.highlightColor : Style.barIconColor
            }

            text: "PRINT"
            textColor: active ? Style.highlightColor : Style.barIconColor
            textSize: Style.textSize

            onPressed: {
                parent.currentSelection = Qt.binding(function() { return selectorId });
                // console.log("printSelector Button Pressed, current selection: ", parent.currentSelection);

            }
        }

        BarSelector{
            id: moveSelector
            selectorId: 2
            active: leftBar.currentSelection === selectorId

            y: parent.height/3
            width: parent.width
            height: parent.height/3
            barWidth: leftBarSeparator.width
            anchors.left: parent.left
            barColor: Style.highlightColor

            iconItem: Rectangle{
                width: 40
                height: width
                color: moveSelector.active ? Style.highlightColor : Style.barIconColor
            }

            text: "MOVE"
            textColor: active ? Style.highlightColor : Style.barIconColor
            textSize: Style.textSize

            onPressed: {
                parent.currentSelection = Qt.binding(function() { return selectorId });
            }
        }

        BarSelector{
            id: settingsSelector
            selectorId: 3
            active: leftBar.currentSelection === selectorId

            y: parent.height/3*2
            width: parent.width
            height: parent.height/3
            barWidth: leftBarSeparator.width
            anchors.left: parent.left
            barColor: Style.highlightColor

            iconItem: Rectangle{
                width: 40
                height: width
                color: settingsSelector.active ? Style.highlightColor : Style.barIconColor
            }

            text: "SETTINGS"
            textColor: active ? Style.highlightColor : Style.barIconColor
            textSize: 13

            onPressed: {
                parent.currentSelection = Qt.binding(function() { return selectorId });
            }
        }
    }

    Loader{
        id: mainLoader
        anchors.right: parent.right
        anchors.left:leftBar.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        source: {
            switch(leftBar.currentSelection){
                case 1:
                    return "PrinterPage.qml";
                case 2:
                    return "MovePage.qml";
                case 3:
                    return "SettingsPage.qml";
                default:
                    return "";
            }
        }
    }
}

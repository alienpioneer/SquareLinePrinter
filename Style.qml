pragma Singleton
import QtQuick

QtObject {
    property int textSize: 13

    property color baseColor: "#45506C"
    property color baseColorLight: "#7E92B9"

    property color barColor: "#191D26"
    property color barSeparatorColor: "#46536E"
    property color barIconColor: "#546286"

    property color buttonIconColor: "#B4CBF5"
    property color buttonOffColor: "#161A23"

    property color highlightColor: "#00D2ff"

    property color darkBkgColor: "#191D26"

    property color shadowColor: "#202634"
    property int shadowOffset: 14

    property double embossBrightness: 0.6
    property int embossBlurMax: 38
    property double embossBlurMultiplier: 1.3
}

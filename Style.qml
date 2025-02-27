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
    property color highlightColorDarker: "#0f8fcf"

    property color darkBkgColor: "#191D26"
    property color borderColor: "#576683"
    property color displaySeparatorColor: "#2F343F"
    property color displayTextColor: "#777F8F"
    property color displayTextAltColor: "#C5CFE7"

    property bool enableEffects: true

    // Drop shadow effects
    property color shadowColor: "#202634"
    property int shadowOffset: 14
    // Glow effects
    property double embossBrightness: 0.6
    property int embossBlurMax: 22
    property double embossBlurMultiplier: 1.3
}

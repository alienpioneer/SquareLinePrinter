pragma Singleton
import QtQuick

QtObject {

    readonly property int textSize: 13

    readonly property color baseColor: "#45506C"
    readonly property color baseColorLight: "#7E92B9"

    readonly property color barColor: "#191D26"
    readonly property color barSeparatorColor: "#46536E"
    readonly property color barIconColor: "#546286"

    readonly property color buttonIconColor: "#B4CBF5"
    readonly property color buttonOffColor: "#161A23"

    readonly property color highlightColor: "#00D2ff"
    readonly property color highlightColorDarker: "#0f8fcf"

    readonly property color darkBkgColor: "#191D26"
    readonly property color borderColor: "#576683"
    readonly property color displaySeparatorColor: "#2F343F"
    readonly property color displayTextColor: "#777F8F"
    readonly property color displayTextAltColor: "#C5CFE7"

    readonly property bool enableEffects: true

    // Drop shadow effects
    readonly property color shadowColor: "#202634"
    readonly property int shadowOffset: 14

    // Glow effects
    readonly property double embossBrightness: 0.6
    readonly property int embossBlurMax: 22
    readonly property double embossBlurMultiplier: 1.3
}

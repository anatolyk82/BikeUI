import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import styles 1.0

Label {
    id: root
    property bool highlightingEnable: true

    property int radius: 50
    property real spred: 0.6
    property color glowColor: "#00aaff" //StyleModel.highlightingFontColor //TODO

    color: StyleModel.primaryFontColor

    layer.enabled: highlightingEnable && StyleModel.allowGlowing
    layer.effect: Glow {
        id: glow
        color: root.glowColor
        radius: root.radius
        samples: 2*radius
        spread: root.spred

    }
}

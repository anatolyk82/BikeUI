pragma Singleton
import QtQuick 2.7

import styles 1.0

QtObject {
    id: root

    property int spacingByDefault: 10
    property int marginByDefault: 10

    readonly property string font7Segments: Qt.resolvedUrl("../assets/fonts/Segment7Standard.otf")

    function icon(name) {
        return Qt.resolvedUrl("../assets/icons/"+ StyleModel.iconsDirectory + "/" + name+".png")
    }

    function background(name) {
        return Qt.resolvedUrl("../assets/backgrounds/"+name+".jpg")
    }

    function font(name) {
        return Qt.resolvedUrl("../assets/fonts/"+name)
    }
}

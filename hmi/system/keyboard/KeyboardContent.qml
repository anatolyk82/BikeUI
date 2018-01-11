import QtQuick 2.9

import QtQuick.VirtualKeyboard 2.2
import QtQuick.VirtualKeyboard.Settings 2.2
import QtQuick.VirtualKeyboard.Styles 2.2

InputPanel {
    id: root

    y: Qt.inputMethod.visible ? parent.height - root.height : parent.height
    Behavior on y { NumberAnimation { duration: 200 } }
    anchors.left: parent.left
    anchors.right: parent.right

    visible: y !== parent.height

    Component.onCompleted: {
        VirtualKeyboardSettings.fullScreenMode = true
        //VirtualKeyboardSettings.styleName = "dark"
    }
}

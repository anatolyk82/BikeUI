import QtQuick 2.9
import "."

import QtQuick.VirtualKeyboard 2.2
import QtQuick.VirtualKeyboard.Settings 2.2
import QtQuick.VirtualKeyboard.Styles 2.2

Loader {
    id: root

    width: parent.width
    height: parent.height

    y: Qt.inputMethod.visible ? parent.height - root.height : parent.height
    Behavior on y { NumberAnimation { duration: 200 } }
    anchors.left: parent.left
    anchors.right: parent.right

    active: Qt.inputMethod.visible

    //source: "KeyboardContent.qml"
    sourceComponent: InputPanel {
        anchors.fill: root
        //Component.onCompleted: VirtualKeyboardSettings.fullScreenMode = true
    }

    onLoaded: {
        //VirtualKeyboardSettings.fullScreenMode = true
        //VirtualKeyboardSettings.styleName = "retro"
    }

    Component.onCompleted: {
        //VirtualKeyboardSettings.fullScreenMode = true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: console.log("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz")
    }
}


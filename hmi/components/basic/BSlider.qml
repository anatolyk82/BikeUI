import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import styles 1.0

Slider {
    id: root

    property int bubbleSize: 70
    property bool bubbleOnTop: true
    property bool bubbleVisible: false

    property bool glowEnabled: true
    property int glowRadius: 50
    property real glowSpred: root.pressed ? 0.3 : 0
    property color glowColor: "#00aaff" //StyleModel.highlightingFontColor //TODO: put in a style

    Behavior on glowSpred { NumberAnimation { duration: 300 } }

    background: Rectangle {
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: 6
        width: root.availableWidth
        height: implicitHeight
        radius: implicitHeight/2
        color: StyleModel.secondaryFontColor

        Rectangle {
            width: root.visualPosition * parent.width
            height: parent.height
            color: root.enabled ? StyleModel.primaryFontColor : StyleModel.secondaryFontColor//StyleModel.primaryFontColor
            radius: 2
        }
    }

    handle: Rectangle {
        id: handle
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 32//root.pressed ? 48 : 32
        implicitHeight: implicitWidth
        radius: implicitWidth/2
        color: root.enabled ? StyleModel.primaryFontColor : StyleModel.secondaryFontColor
        border.color: StyleModel.secondaryFontColor
        Behavior on implicitWidth { NumberAnimation { duration: 300 } }

        layer.enabled: (root.glowSpred != 0) && glowEnabled && StyleModel.allowGlowing
        layer.effect: Glow {
            id: glow
            color: root.glowColor
            radius: root.glowRadius
            samples: 2*glowRadius
            spread: root.glowSpred

        }
    }

    Rectangle {
        id: bubble
        x: handle.x - bubbleSize/2+handle.width/2
        y: handle.y + (bubbleOnTop ? (-bubbleSize - 10) : (bubbleSize + 20 - handle.height))//root.pressed ? (handle.y + (bubbleOnTop ? (-bubbleSize - 10) : (bubbleSize + 20 - handle.height))) : root.y
        width: bubbleSize
        height: bubbleSize
        radius: 10
        opacity: root.pressed ? 1 : 0
        visible: bubbleVisible && (opacity > 0)
        scale: root.pressed ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 300 } }
        Behavior on scale { NumberAnimation { duration: 300 } }

        BLabel {
            anchors.centerIn: parent
            text: Math.round(value)
            color: StyleModel.inverseFontColor
            font.pixelSize: bubbleSize/2
        }
    }


}

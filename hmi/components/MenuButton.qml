import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import utils 1.0
import components 1.0

Button {
    id: root
    width: Utils.appButtonWidth
    height: Utils.appButtonHeight

    property url iconSource: ""

    topPadding: 30

    background: Rectangle {
        radius: 10
        color: "transparent"
    }

    contentItem: Column {
        spacing: 10
        Item {
            id: iconImgWrapper
            anchors.horizontalCenter: parent.horizontalCenter
            width: iconImg.width
            height: iconImg.height
            Image {
                id: iconImg
                anchors.centerIn: parent
                source: root.iconSource
                visible: progress == 1.0
                antialiasing: true
            }
            InnerShadow {
                anchors.fill: iconImg
                radius: 2
                samples: 4
                horizontalOffset: 1.0
                verticalOffset: 1.0
                color: "grey" //"#b0000000"
                source: iconImg
                enabled: iconImg.visible
            }
        }
        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 64
            height: 64
            visible: !iconImg.visible
        }
        BLabel {
            id: label
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 20
            text: root.text
        }
    }
}

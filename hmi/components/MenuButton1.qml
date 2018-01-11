import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.2

import utils 1.0
import components 1.0

Button {
    id: root
    width: Utils.appButtonWidth
    height: Utils.appButtonHeight
    //anchors.centerIn: parent

    property url icon: ""

    //TODO: replace by Ripple {} when I port it to hmi_utils
    // take Ripple from Qt/5.9.1/Src/qtquickcontrols2/src/imports/controls/material
    background: MenuItem {
    }

    contentItem: Item {
        id: content

        Column {
            anchors.fill: parent
            spacing: 10
            //topPadding: 50
            //Rectangle { height: 15; width: height }
            Image {
                id: iconImg
                anchors.horizontalCenter: parent.horizontalCenter
                source: root.icon
                visible: progress == 1.0
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
            Item {
                anchors.horizontalCenter: parent.horizontalCenter
                width: 64
                height: 64
                visible: !iconImg.visible
            }

            BLabel {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 20
                text: root.text
            }
        }
    }
}

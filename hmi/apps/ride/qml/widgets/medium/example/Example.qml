import QtQuick 2.8
import QtQuick.Controls 2.1

import utils 1.0
import common 1.0

import "../.."

MediumWidget {
    id: root

    plusVisible: false
    Column {
        spacing: 10
        anchors.centerIn: parent
        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: Utils.icon("ic_map")
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 26
            text: "Medium widget"
        }
    }
}

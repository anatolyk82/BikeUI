import QtQuick 2.8
import QtQuick.Controls 2.2

import utils 1.0
import common 1.0

import "../.."

BigWidget {
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
            font.pixelSize: 30
            text: "Big widget"
        }
    }
}

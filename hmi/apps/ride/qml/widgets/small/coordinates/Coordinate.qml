import QtQuick 2.9

import utils 1.0
import common 1.0
import components 1.0

import "../.."

SmallWidget {
    id: root

    name: "Coordinate"
    plusVisible: false

    property int labelWidth: 125

    Row {
        anchors.fill: parent
        anchors.margins: 15
        spacing: 10
        Image {
            anchors.verticalCenter: parent.verticalCenter
            source: Utils.icon("ic_map")
        }
        Column {
            spacing: 10
            anchors.verticalCenter: parent.verticalCenter
            Row {
                BLabel {
                    width: root.labelWidth
                    text: qsTr("Latitude") + ":"
                }
                BLabel {
                    text: GPSModel.latitudeDMS()
                }
            }
            Row {
                BLabel {
                    width: root.labelWidth
                    text: qsTr("Longitude") + ":"
                }
                BLabel {
                    text: GPSModel.longitudeDMS()
                }
            }
        }
    }
}

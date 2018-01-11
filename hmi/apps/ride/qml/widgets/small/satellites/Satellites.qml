import QtQuick 2.8
import QtQuick.Controls 2.1

import utils 1.0
import common 1.0
import components 1.0

import "../.."

SmallWidget {
    id: root

    name: "Satellites"
    plusVisible: false

    property real r_inuse: 0x7D/255
    property real g_inuse: 0xC2/255
    property real b_inuse: 0x4b/255

    property real r_inview: 0xFF/255
    property real g_inview: 0x00/255
    property real b_inview: 0x00/255

    BLabel {
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Satellites")
    }

    Row {
        anchors.fill: parent
        Repeater {
            model: GPSModel.satelliteModel
            delegate: Item {
                width: GPSModel.satelliteModel.entryCount > 0 ? root.width/GPSModel.satelliteModel.entryCount : 0
                height: root.height-2
                anchors.verticalCenter: parent.verticalCenter
                Item {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: root.height*signalStrength/100
                    width: parent.width-2
                    Behavior on height { NumberAnimation { duration: 5000 } } //FIXME: it's not working
                    //onHeightChanged: console.log(satelliteIdentifier+" h: " + height)
                    Rectangle {
                        id: topping
                        anchors.top: parent.top
                        anchors.left: parent.left
                        width: parent.width
                        height: 2
                        color: isInUse ? "#7DC24B" : "red"
                    }
                    Rectangle {
                        id: filling
                        opacity: 0.75
                        anchors.fill: parent
                        color: isInUse ? "#7DC24B" : "red"
                        /*gradient: Gradient {
                            GradientStop { position: 1; color: "transparent" }
                            GradientStop {
                                position: 0
                                color: isInUse ?
                                           Qt.rgba(r_inuse, g_inuse, b_inuse, 0.5+signalStrength/100 ) :
                                           Qt.rgba(r_inview, r_inview, r_inview, 0.5+signalStrength/100 )
                            }
                        }*/
                    }
                }
                Label {
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: satelliteIdentifier
                }
            }
        }
    }
}

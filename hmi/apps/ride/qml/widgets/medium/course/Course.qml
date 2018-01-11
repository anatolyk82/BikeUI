import QtQuick 2.9

import utils 1.0
import common 1.0
import components 1.0
import styles 1.0

import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

import "../.."

MediumWidget {
    id: root

    name: "Course"
    plusVisible: false

    Item {
        id: leftPane
        width: parent.width/2
        height: parent.height
        anchors.left: parent.left
        anchors.top: parent.top

        CircularGauge {
            id: gauge
            anchors.centerIn: parent
            height: Math.min(parent.height, parent.width)-20
            width: height
            minimumValue: 0
            maximumValue: 360
            antialiasing: true

            style: CircularGaugeStyle {
                id: gaugeStyle
                minimumValueAngle: 0
                maximumValueAngle: 360

                tickmarkStepSize: 30

                needle: null

                background: Item {
                    id: background
                    readonly property int fontSizeNESW: 16
                    BLabel {
                        text: "N"
                        color: StyleModel.primaryFontColor
                        font.pixelSize: background.fontSizeNESW
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    BLabel {
                        text: "S"
                        color: StyleModel.primaryFontColor
                        font.pixelSize: background.fontSizeNESW
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    BLabel {
                        text: "E"
                        color: StyleModel.primaryFontColor
                        font.pixelSize: background.fontSizeNESW
                        anchors.right: parent.right
                        anchors.rightMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    BLabel {
                        text: "W"
                        color: StyleModel.primaryFontColor
                        font.pixelSize: background.fontSizeNESW
                        anchors.left: parent.left
                        anchors.leftMargin: 30
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                tickmarkLabel: BLabel {
                    color: StyleModel.primaryFontColor
                    text: styleData.value
                    font.pixelSize: 12
                }
                tickmark: Rectangle {
                    color: StyleModel.primaryFontColor
                    width: 2
                    height: 7
                    antialiasing: true
                }
                minorTickmark: Rectangle {
                    color: StyleModel.primaryFontColor
                    width: 1
                    height: 4
                    antialiasing: true
                }
            }
            Image {
                anchors.centerIn: parent
                opacity: 0.9
                source: Utils.icon("l_compass_arrow")
                rotation: GPSModel.course
                Behavior on rotation { NumberAnimation { duration: 1000; easing.type: Easing.OutBack } }
            }
        }
    }

    Item {
        id: rightPane
        width: parent.width/2
        height: parent.height
        anchors.right: parent.right
        anchors.top: parent.top

        BLabel {
            anchors.centerIn: parent
            text: isNaN(GPSModel.course) ? "--" : Math.round(GPSModel.course)
            font.pixelSize: 116
            font.family: segmentIndicatorFont.name
        }
        FontLoader {
            id: segmentIndicatorFont
            source: Utils.font7Segments
        }
    }
}

import QtQuick 2.8
import QtQuick.Controls 2.1
import QtCharts 2.0
import Qt.labs.settings 1.0

import utils 1.0
import common 1.0
import components 1.0
import styles 1.0

import "../.."

import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

SmallWidget {
    id: root

    name: "Simple speedometer"
    plusVisible: false

    widgetSettings: widgetSettingsComponent
    widgetSettingsDialogTitle: ""

    readonly property Settings settings: Settings {
        category: root.name
        property alias animationSpeed: root.animationSpeed
        property alias warningSpeedPercentage: root.warningSpeedPercentage
        property alias speedLimit: root.speedLimit
        property alias maxSpeed: root.maxSpeed
    }

    property int animationSpeed: 800
    property int warningSpeedPercentage: 75
    property int speedLimit: 40 // km/h
    property real maxSpeed: 0

    readonly property int speedLimit_m_s: speedLimit*1000/3600

    Connections {
        target: GPSModel
        onSpeedChanged: {
            if (GPSModel.speed > maxSpeed) {
                maxSpeed = GPSModel.speed
            }
        }
    }

    Row {
        anchors.fill: parent
        spacing: 0

        ChartView {
            id: sliceSpeed
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: -10
            height: 1.1*parent.height
            width: height
            antialiasing: true
            backgroundColor: "transparent"
            legend.visible: false
            PieSeries {
                startAngle: 135
                endAngle: -135
                size: 0.95
                holeSize: 0.6
                PieSlice {
                    borderColor: StyleModel.secondaryFontColor
                    color: "transparent"
                    value: isNaN(GPSModel.speed) ? 100 : GPSModel.speed > speedLimit_m_s ? 0 : 100-(GPSModel.speed/speedLimit_m_s)*100
                    Behavior on value {NumberAnimation { duration: animationSpeed } }
                }
                PieSlice {
                    borderColor: StyleModel.primaryFontColor
                    color: value > warningSpeedPercentage ? "red" : "#7DC24B"
                    value: isNaN(GPSModel.speed) ? 0 : GPSModel.speed > speedLimit_m_s ? 100 : GPSModel.speed*100/speedLimit_m_s
                    Behavior on value { NumberAnimation { duration: animationSpeed } }
                    Behavior on color { ColorAnimation { duration: animationSpeed } }
                }
            }
            BLabel {
                anchors.centerIn: parent
                text: speedLimit
                font.pixelSize: 22
            }
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            anchors.verticalCenterOffset: -15
            BLabel {
                anchors.verticalCenter: parent.verticalCenter
                text: isNaN(GPSModel.speed) ? "00.0" : BMath.ms2kmh(GPSModel.speed)
                font.pixelSize: 96
                font.family: segmentIndicatorFont.name
            }
            FontLoader {
                id: segmentIndicatorFont
                source: Utils.font7Segments
            }
            BLabel {
                anchors.verticalCenter: parent.verticalCenter
                text: "km/h"
                font.pixelSize: 20
            }
        }
    }

    BLabel {
        anchors.horizontalCenter: root.horizontalCenter
        anchors.horizontalCenterOffset: 40
        anchors.bottom: root.bottom
        anchors.bottomMargin: 15
        text: qsTr("Max") + ": " + (maxSpeed*3600/1000).toFixed(1) + " " + qsTr("km/h")
        //text: (isNaN(GPSModel.speed) ? 0 : GPSModel.speed.toFixed(2)) + " " + qsTr("m/s")
        font.pixelSize: 24
    }

    Component {
        id: widgetSettingsComponent
        Item {
            id: widgetSettings
            anchors.fill: parent

            Column {
                anchors.centerIn: parent
                spacing: 0
                BLabel {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Speed limit, km/h") + ": " + speedLimit
                }
                BSlider {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: widgetSettings.width*0.9
                    from: 10
                    to: 80
                    stepSize: 1
                    value: speedLimit
                    onValueChanged: speedLimit = value
                }
                BLabel {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Warning, %") + ": " + warningSpeedPercentage
                }
                BSlider {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: widgetSettings.width*0.9
                    from: 0
                    to: 100
                    stepSize: 1
                    value: warningSpeedPercentage
                    onValueChanged: warningSpeedPercentage = value
                }
                BLabel {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Animation, sec") + ": " + animationSpeed
                }
                BSlider {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: widgetSettings.width*0.9
                    from: 0
                    to: 1500
                    stepSize: 100
                    value: animationSpeed
                    onValueChanged: animationSpeed = value
                }
                BButton {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: qsTr("Reset max. speed")
                    width: parent.width/2
                    onClicked: maxSpeed = 0
                }
            }
        }
    }
}

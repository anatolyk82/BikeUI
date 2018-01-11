import QtQuick 2.8
import QtQuick.Controls 2.2

import utils 1.0
import common 1.0
import styles 1.0
import components 1.0

import "../.."

import Qt.labs.settings 1.0
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

BigWidget {
    id: root

    plusVisible: false
    name: "Big speedometer"

    widgetSettings: widgetSettingsComponent
    widgetSettingsDialogButtons: Dialog.Ok
    widgetSettingsDialogTitle: ""

    readonly property Settings settings: Settings {
        category: root.name
        property alias speedLimit: root.speedLimit
    }

    property color gaugeColor: StyleModel.primaryFontColor

    property int speedLimit: 50 // km/h

    readonly property int speedLimit_m_s: speedLimit*1000/3600

    property real speedValue: isNaN(GPSModel.speed) ? 0 : GPSModel.speed > speedLimit_m_s ? speedLimit : BMath.ms2kmh(GPSModel.speed,1,false)

    CircularGauge {
        id: gauge
        anchors.centerIn: parent

        height: 0.9*Math.min( parent.height, parent.width)
        width: height

        minimumValue: 0
        maximumValue: speedLimit
        value: speedValue

        Behavior on value { NumberAnimation { duration: 1000; easing.type: Easing.OutBack } }

        style: CircularGaugeStyle {
            id: gaugeStyle

            function toPixels(percentage) {
                return percentage * gaugeStyle.outerRadius
            }

            tickmarkStepSize: 5

            background: Item {
                BLabel {
                    id: speedText
                    font.pixelSize: toPixels(0.4)
                    text: speedValue
                    color: root.gaugeColor
                    horizontalAlignment: Text.AlignRight
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.verticalCenter
                    anchors.topMargin: toPixels(0.1)
                    font.family: segmentIndicatorFont.name
                }
                BLabel {
                    text: qsTr("km/h")
                    color: root.gaugeColor
                    font.pixelSize: toPixels(0.12)
                    anchors.top: speedText.bottom
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                FontLoader {
                    id: segmentIndicatorFont
                    source: Utils.font("Segment7Standard.otf")
                }
            }

            tickmarkLabel: BLabel {
                color: root.gaugeColor
                text: styleData.value
                font.pixelSize: 26
            }
            tickmark: Rectangle {
                color: root.gaugeColor
                width: 4
                height: 14
                antialiasing: true
            }
            minorTickmark: Rectangle {
                color: root.gaugeColor
                width: 2
                height: 7
                antialiasing: true
            }
        }
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
                Slider { //TODO: BSilder
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: widgetSettings.width
                    from: 10
                    to: 80
                    stepSize: 1
                    value: speedLimit
                    onValueChanged: speedLimit = value
                }
            }

            function accepted() {
            }
        }
    }
}

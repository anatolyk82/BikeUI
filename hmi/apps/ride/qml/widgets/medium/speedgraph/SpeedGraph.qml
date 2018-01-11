import QtQuick 2.10
//import QtQuick.Controls 2.2

import utils 1.0
import common 1.0
import components 1.0
import styles 1.0

import "../.."

import QtCharts 2.2

MediumWidget {
    id: root
    plusVisible: false

    widgetSettingsDialogButtons: 0
    widgetSettings: speedGraphSettingsComponent

    property int timeDepthSeconds: speedGraphSettings.timeDepth
    property int maxSpeed: speedGraphSettings.maxSpeed
    property alias autoScaleSpeed: speedGraphSettings.autoScale
    property bool gridVisible: speedGraphSettings.gridVisible

    readonly property var tempBuffToDisplay: []
    readonly property int labelsFontSize: 16
    readonly property string seriesName: "Speed"

    BLabel {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: qsTr("Speed, kph")
    }

    ChartView {
        id: chartView
        anchors.fill: parent
        backgroundColor: "transparent"
        animationDuration: 1000 //TODO: Shall it coincide with the GPS update interval ?
        antialiasing: true
        legend.visible : false
        margins.bottom: 0
        margins.left: 0
        margins.right: 0
    }

    property int currentIndex: 0

    Connections {
        id: connectionToGPS
        target: GPSModel
        onPositionUpdated: {
            var lineSeries = chartView.series(seriesName)

            var speed = BMath.ms2kmh(GPSModel.speed)

            if (!lineSeries) {
                chartView.animationOptions = ChartView.AllAnimations
                chartView.createSeries(ChartView.SeriesTypeLine,seriesName)
                chartView.axisX().labelsColor = StyleModel.primaryFontColor
                chartView.axisX().gridLineColor = StyleModel.secondaryFontColor
                chartView.axisX().labelsVisible = false

                chartView.axisY().labelsColor = StyleModel.primaryFontColor
                chartView.axisY().tickCount = 3
                chartView.axisY().gridLineColor = StyleModel.secondaryFontColor
                chartView.axisY().labelsFont.pixelSize = labelsFontSize
            } else {
                chartView.animationOptions = ChartView.SeriesAnimations
            }

            chartView.axisY().gridVisible = root.gridVisible
            chartView.axisY().min = 0
            if (root.autoScaleSpeed) {
                if (tempBuffToDisplay.length > timeDepthSeconds) {
                    tempBuffToDisplay.shift()
                }

                tempBuffToDisplay.push(speed)
                var mSpeed = BMath.maxOfArray(tempBuffToDisplay)
                //console.log(mSpeed+"|"+tempBuffToDisplay)
                chartView.axisY().max = Math.ceil(mSpeed/10.0)*10
            } else {
                chartView.axisY().max = root.maxSpeed
            }

            chartView.axisX().gridVisible = root.gridVisible
            chartView.axisX().min = (currentIndex > timeDepthSeconds) ? (currentIndex - timeDepthSeconds) : 0
            chartView.axisX().max = (currentIndex+1)

            if (lineSeries) {
                lineSeries.append(currentIndex, speed)
                currentIndex++;
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onPressAndHold: root.optionsActivated(widgetType, widgetRow, widgetColumn)
    }

    Component {
        id: speedGraphSettingsComponent
        SpeedGraphSettings {
            id: speedGraphSettings
            onResetData: {
                connectionToGPS.enabled = false
                chartView.series(seriesName).removePoints(0, currentIndex)
                chartView.axisY().max = 0
                currentIndex = 0
                connectionToGPS.enabled = true
            }
        }
    }
}

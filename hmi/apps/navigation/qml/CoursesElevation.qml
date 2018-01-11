import QtQuick 2.7
import QtQuick.Controls 2.0

import QtCharts 2.0

import utils 0.1
import components 0.1
import common 0.1

import "./"

Pane {
    id: root
    padding: 0

    property alias distanceMin: axisDistance.min
    property alias distanceMax: axisDistance.max

    property alias altitudeMin: axisElevation.min
    property alias altitudeMax: axisElevation.max

    function addPoint(distance, altitude) {
        lineSeries.append(distance,altitude)
    }

    ChartView {
        id: chartViewElevation
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width
        height: width
        title: qsTr("Elevation")
        legend.visible: false

        ValueAxis {
            id: axisDistance
        }

        ValueAxis {
            id: axisElevation
        }

        LineSeries {
            id: lineSeries
            axisX: axisDistance
            axisY: axisElevation
            color: "blue"
            width: 1
            useOpenGL: true
        }

        property int posX1
        MouseArea {
            anchors.fill: parent
            enabled: !swipePagesEnabled
            onPressedChanged: {
                chartViewElevation.posX1 = mouseX
            }
            onPositionChanged: {
                var shiftPixels = Math.abs(mouseX - chartViewElevation.posX1)/10
                if (mouseX > chartViewElevation.posX1) {
                    if (axisDistance.min >= root.xMin) {
                        chartViewElevation.scrollLeft(shiftPixels)
                    } else {
                        axisDistance.min = root.xMin
                    }
                } else {
                    if(axisDistance.max <= root.xMax) {
                        chartViewElevation.scrollRight(shiftPixels)
                    } else {
                        axisDistance.max = root.xMax
                    }
                }
            }
        }
    }

    Connections {
        target: CoursesModel
        onAltitudePointAdded: {
            addPoint(distance,altitude)
        }
    }

    MapButton {
        id: buttonZoomIn
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        iconSource: Utils.icon("zoom_in")
        onClicked: axisDistance.max = axisDistance.max/2
    }
    MapButton {
        id: buttonZoomOut
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        iconSource: Utils.icon("zoom_out")
        onClicked: axisDistance.max = axisDistance.max*2
    }
    MapButton {
        id: buttonMoveMap
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        iconSource: !swipePagesEnabled ? Utils.icon("hand_cancel") : Utils.icon("hand")
        onClicked: {
            swipePagesEnabled = !swipePagesEnabled
            if(swipePagesEnabled) {
                chartViewElevation.zoomReset()
            }
        }
    }

}

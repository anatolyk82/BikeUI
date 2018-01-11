import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

import "./"

import common 1.0
import utils 1.0
import components 1.0
import styles 1.0

import QtCharts 2.2

Item {
    //background: StyleModel.background

    Item {
        id: leftPane
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width*0.5
        height: parent.height

        PolarChartView {
            id: constellation
            title: qsTr("Satellite constellation")
            titleColor: StyleModel.primaryFontColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            width: parent.width*0.9
            height: width
            backgroundColor: "transparent"
            antialiasing: true

            ValueAxis {
                id: axisAngular
                min: 0
                max: 360
                minorTickCount: 3
                labelsVisible: false
                color: StyleModel.primaryFontColor
                gridLineColor: "blue"
                minorGridLineColor: "lightgrey"
            }

            ValueAxis {
                id: axisRadial
                min: 0
                max: 90
                tickCount: 4
                gridLineColor: "grey"
            }

            ScatterSeries {
                id: scatterSeriesUsed
                axisAngular: axisAngular
                axisRadial: axisRadial
                name: qsTr("Used")

                markerSize: 16
                color: GpsPageModel.usedSatelliteColor
                borderColor: StyleModel.primaryFontColor
                onClicked: {
                    timerRowClickedSatellite.restart()
                    rowClickedSatellite.opacity = 1
                    GpsPageModel.getSatellite(point.x, point.y)
                }
            }

            ScatterSeries {
                id: scatterSeriesUnused
                axisAngular: axisAngular
                axisRadial: axisRadial
                name: qsTr("Visible")

                markerSize: 16
                color: GpsPageModel.visibleSatelliteColor
                borderColor: StyleModel.primaryFontColor //"black"
                onClicked: {
                    timerRowClickedSatellite.restart()
                    rowClickedSatellite.opacity = 1
                    GpsPageModel.getSatellite(point.x, point.y)
                }
            }
        }

        //----

        Rectangle {
            id: areaSignalStrength
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            color: "transparent"
            border.color: StyleModel.primaryFontColor
            width: parent.width*0.8
            height: 80

            Row {
                anchors.fill: parent
                Repeater {
                    model: GPSModel.satelliteModel
                    delegate: Item {
                        width: GPSModel.satelliteModel.entryCount > 0 ? areaSignalStrength.width/GPSModel.satelliteModel.entryCount : 0
                        height: areaSignalStrength.height-2
                        anchors.verticalCenter: parent.verticalCenter
                        Rectangle {
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: parent.height*signalStrength/100
                            color: isInUse ? GpsPageModel.usedSatelliteColor : GpsPageModel.visibleSatelliteColor
                            width: parent.width*0.9
                            Behavior on height { NumberAnimation { duration: 200 } }
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
    }



    Row {
        id: rowClickedSatellite
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        opacity: 0
        Behavior on opacity { NumberAnimation { duration: 200 } }
        Rectangle {
            width: 16
            height: width
            radius: width/2
            anchors.verticalCenter: parent.verticalCenter
            color: GpsPageModel.clickedSatelliteUsed ? GpsPageModel.usedSatelliteColor : GpsPageModel.visibleSatelliteColor
        }
        Label {
            anchors.verticalCenter: parent.verticalCenter
            text: GpsPageModel.clickedSatellite
            onTextChanged: {
                timerRowClickedSatellite.start()
            }
        }
    }

    Timer {
        id: timerRowClickedSatellite
        interval: 5000
        triggeredOnStart: false
        repeat: false
        onTriggered: rowClickedSatellite.opacity = 0
    }

    Connections {
        target: GPSModel
        onConstellationUpdated: {
            scatterSeriesUnused.clear()
            scatterSeriesUsed.clear()
            for (var j=0; j<GPSModel.satelliteModel.entryCount; j++) {
                var n = GPSModel.satelliteModel.data(GPSModel.satelliteModel.index(j,0), GPSModel.satelliteIdentifierRole)
                var a = GPSModel.satelliteModel.data(GPSModel.satelliteModel.index(j,0), GPSModel.satelliteAzimuthRole)
                var e = GPSModel.satelliteModel.data(GPSModel.satelliteModel.index(j,0), GPSModel.satelliteElevationRole)
                var u = GPSModel.satelliteModel.data(GPSModel.satelliteModel.index(j,0), GPSModel.satelliteInUseRole)

                if(u) {
                    scatterSeriesUsed.append(a,90-e)
                } else {
                    scatterSeriesUnused.append(a,90-e)
                }
            }
        }
    }

    //-------------------------------------------

    GpsInformation {
        id: rightPane
        anchors.right: parent.right
        anchors.top: parent.top
        width: parent.width/2
        height: width
    }

}

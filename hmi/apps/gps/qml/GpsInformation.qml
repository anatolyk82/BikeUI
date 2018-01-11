import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

import "./"

import common 1.0
import utils 1.0

import components 1.0

Item {
    id: root
/*
    property int point: 0
    CourseCreator {
        id: courseCreator
        trackAuthor: "Anatoly"
        trackName: "Example"
        gpxFile: "/home/anatoly/Projects/Bike/BikeComputer/gpxExample.gpx"
        onErrorMessageChanged: console.log("Error:"+errorMessage)
    }

    Component.onCompleted: {
        courseCreator.open()
    }

    property real lat: 0
    property real lon: 0
    Timer {
        repeat: true
        running: true
        interval: 2000
        onTriggered: {
            if ((lat != GPSModel.latitude)&&(lon != GPSModel.longitude)) {
                var s = "Point_"+point
                point += 1
                courseCreator.addPoint(s,GPSModel.latitude,GPSModel.longitude,GPSModel.altitude,"",GPSModel.gpsTime)

                lat = GPSModel.latitude
                lon = GPSModel.longitude
            }
        }
    }
*/
    //--------------------------

    property int primaryFontSize: 20

    ColumnLayout {
        spacing: 10

        Item {
            width: parent.width
            height: 1
        }

        //Visible satellites
        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: Utils.icon("w_satellite")
            }
            BLabel {
                Layout.minimumWidth: GpsPageModel.labelWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.visibleSatellitesLabel
            }
            BLabel {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GPSModel.visibleSatellites
            }
        }

        // Used satellites
        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: Utils.icon("w_satellite")
            }
            BLabel {
                Layout.minimumWidth: GpsPageModel.labelWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.usedSatelliteLabel
            }
            BLabel {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GPSModel.usedSatellites
            }
        }

        // Latitude
        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: Utils.icon("w_location")
            }
            BLabel {
                Layout.minimumWidth: GpsPageModel.labelWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.latitudeDMSLabel
            }
            BLabel {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GPSModel.latitudeDMS()
            }
        }

        // Longitude
        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: Utils.icon("w_location")
            }
            BLabel {
                Layout.minimumWidth: GpsPageModel.labelWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.longitudeDMSLabel
            }
            BLabel {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GPSModel.longitudeDMS()
            }
        }

        // Accuaracy
        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: Utils.icon("w_accuaracy")
            }
            BLabel {
                Layout.minimumWidth: GpsPageModel.labelWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.accuaracyLabel
            }
            BLabel {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.accuaracyValue
            }
        }

        //Altitude
        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: Utils.icon("w_altitude")
            }
            BLabel {
                Layout.minimumWidth: GpsPageModel.labelWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.altitudeLabel
            }
            BLabel {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.altitudeValue
            }
        }

        // Speed
        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: Utils.icon("w_speed")
            }
            BLabel {
                Layout.minimumWidth: GpsPageModel.labelWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.speedLabel
            }
            BLabel {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.speedValue
            }
        }

        //Course
        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: Utils.icon("w_compass")
            }
            BLabel {
                Layout.minimumWidth: GpsPageModel.labelWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.gpsCourseLabel
            }
            BLabel {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.gpsCourseValue
            }
        }

        // Vertical Speed
        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: Utils.icon("w_speed")
            }
            BLabel {
                Layout.minimumWidth: GpsPageModel.labelWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.verticalSpeedLabel
            }
            BLabel {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.verticalSpeedValue
            }
        }

        //GPS Time
        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: Utils.icon("w_clock")
            }
            BLabel {
                Layout.minimumWidth: GpsPageModel.labelWidth
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.gpsTimeLabel
            }
            BLabel {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: root.primaryFontSize
                text: GpsPageModel.gpsTime
            }
        }

    }
}

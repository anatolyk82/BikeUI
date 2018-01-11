pragma Singleton
import QtQuick 2.7

import QtPositioning 5.5
import QtLocation 5.6

import courses 1.0

QtObject {
    id: root

    readonly property Courses courses: Courses {}

    readonly property int numPoints: courses.gpxData.count
    readonly property real entireDistance: courses.gpxData.distance
    readonly property real altitudeMax: courses.gpxData.maxAltitude
    readonly property real altitudeMin: courses.gpxData.minAltitude

    readonly property real altitudeStart: Math.round(altitude(0))
    readonly property real altitudeEnd: numPoints > 0 ? Math.round(altitude(numPoints-1)) : 0

    //property string distanceUnit: qsTr("m") //TODO: add some logic

    property MapPolyline track: Qt.createQmlObject('import QtLocation 5.6; MapPolyline {}', root)

    readonly property Connections pluginConnections: Connections {
        target: courses
        onGpxDataChanged: {
            gpxTrackReady()
        }
        onGpxPointAdded: {
            root.track.addCoordinate(point)
            root.altitudePointAdded(distance, point.altitude)
        }
    }

    signal gpxTrackReady()
    signal altitudePointAdded(real distance, real altitude)

    function setTrackWidth(width) {
        track.line.width = width
    }

    function setTrackColor(color) {
        track.line.color = color
    }

    function latitude(i) {
        return courses.gpxData.data(courses.gpxData.index(i,0),TrackDataListModel.Latitude)
    }

    function longitude(i) {
        return courses.gpxData.data(courses.gpxData.index(i,0),TrackDataListModel.Longitude)
    }

    function altitude(i) {
        return courses.gpxData.data(courses.gpxData.index(i,0),TrackDataListModel.Altitude)
    }

    function distance(i) {
        return courses.gpxData.data(courses.gpxData.index(i,0),TrackDataListModel.Distance)
    }

    function position(i) {
        var lat = latitude(i)
        var lon = longitude(i)
        var alt = altitude(i)
        return QtPositioning.coordinate(lat, lon, alt)
    }

    function setGPXFile(gpxFile) {
        courses.gpxFile = gpxFile
        courses.parseGPXFile()
    }
}

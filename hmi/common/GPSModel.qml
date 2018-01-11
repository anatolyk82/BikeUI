pragma Singleton
import QtQuick 2.9
import QtQuick.Controls 2.2
import QtPositioning 5.9

import satellites 1.0
import system.settings 1.0

import utils 1.0

QtObject {
    id: root

    signal positionUpdated()
    signal constellationUpdated()

    readonly property PositionSource positionSource: PositionSource {
        updateInterval: SettingsModel.gpsIntervalUpdate
        onSourceErrorChanged: {
            if (sourceError === PositionSource.AccessError) {
                gpsErrorString = qsTr("The connection setup to the remote positioning backend failed because the application lacked the required privileges.")
            } else if (sourceError === PositionSource.ClosedError) {
                gpsErrorString = qsTr("The positioning backend closed the connection. As soon as the location service is re-enabled regular updates will resume.")
            } else if (sourceError === PositionSource.UnknownSourceError) {
                gpsErrorString = qsTr("An unidentified error occurred.")
            } else if (sourceError === PositionSource.SocketError) {
                gpsErrorString = qsTr("An error occurred while connecting to an nmea source using a socket.")
            }
            console.log(gpsErrorString)
        }
        onPositionChanged: {
            root.positionUpdated()
        }

        Component.onCompleted: start()
    }

    readonly property SatelliteModel satelliteModel: SatelliteModel {
        running: true
        onErrorFound: console.warning("SatelliteModel: Error: %1").arg(code)
    }

    readonly property int satelliteIdentifierRole: SatelliteModel.IdentifierRole
    readonly property int satelliteAzimuthRole: SatelliteModel.AzimuthRole
    readonly property int satelliteElevationRole: SatelliteModel.ElevationRole
    readonly property int satelliteInUseRole: SatelliteModel.InUseRole
    readonly property int satelliteSignalStrengthRole: SatelliteModel.SignalStrengthRole


    property int gpsError: positionSource.sourceError
    property string gpsErrorString: ""

    readonly property Position position: positionSource.position
    readonly property var coordinate: position.coordinate

    readonly property real latitude: coordinate.latitude
    readonly property bool latitudeValid: position.latitudeValid

    readonly property real longitude: coordinate.longitude
    readonly property bool longitudeValid: position.longitudeValid

    readonly property real altitude: coordinate.altitude
    readonly property bool altitudeValid: position.altitudeValid

    readonly property real speed: position.speed
    readonly property bool speedValid: position.speedValid

    readonly property real verticalSpeed: position.verticalSpeed
    readonly property bool verticalSpeedValid: position.verticalSpeedValid

    readonly property real course: position.direction
    readonly property bool courseValid: position.directionValid

    readonly property real horizontalAccuracy: position.horizontalAccuracy
    readonly property real horizontalAccuracyValid: position.horizontalAccuracyValid

    readonly property real verticalAccuracy: position.verticalAccuracy
    readonly property real verticalAccuracyValid: position.verticalAccuracyValid

    readonly property bool isMoving: speed > 0 //TODO: make it more precise


    readonly property bool gpsTimeValid: !isNaN(gpsTime.getSeconds())
    readonly property date gpsTime: position.timestamp
    readonly property string gpsTimeYear: gpsTime.getFullYear()
    readonly property string gpsTimeMonth: gpsTime.getMonth() < 10 ? "0" + gpsTime.getMonth() : gpsTime.getMonth()
    readonly property string gpsTimeDay: gpsTime.getDate() < 10 ? "0" + gpsTime.getDate() : gpsTime.getDate()

    readonly property string gpsTimeHours: gpsTime.getHours() < 10 ? "0" + gpsTime.getHours() : gpsTime.getHours()
    readonly property string gpsTimeMinutes: gpsTime.getMinutes() < 10 ? "0" + gpsTime.getMinutes() : gpsTime.getMinutes()
    readonly property string gpsTimeSeconds: gpsTime.getSeconds() < 10 ? "0" + gpsTime.getSeconds() : gpsTime.getSeconds()

    readonly property int visibleSatellites: satelliteModel.satellitesInView
    readonly property int usedSatellites: satelliteModel.satellitesInUse
    readonly property int fixStatus: 0//GPS.fixStatus
    readonly property string gpsFixIcon: {
        if (!isNaN(altitude)) {
            return Utils.icon("tb_gps3d")
        } else if ((!isNaN(longitude))&&(!isNaN(latitude))) {
            return Utils.icon("tb_gps2d")
        } else if (isNaN(longitude)&&isNaN(latitude)&&isNaN(altitude)) {
            return Utils.icon("tb_gps0d")
        } else {
            return Utils.icon("tb_nogps")
        }
    }

    readonly property real hDOP: 0//GPS.dop.hdop
    readonly property string hDOPText: {
        if (hDOP === 0) {
            return qsTr("Unknown")
        } else if (hDOP <= 1) {
            return qsTr("Ideal")
        } else if (hDOP <= 2) {
            return qsTr("Excellent")
        } else if (hDOP <= 5) {
            return qsTr("Good")
        } else if (hDOP <= 10) {
            return qsTr("Moderate")
        } else if (hDOP <= 20) {
            return qsTr("Fair")
        } else {
            return qsTr("Poor")
        }
    }

    readonly property real vDOP: 0//GPS.dop.vdop
    readonly property string vDOPText: {
        if (vDOP === 0) {
            return qsTr("Unknown")
        } else if (vDOP <= 1) {
            return qsTr("Ideal")
        } else if (vDOP <= 2) {
            return qsTr("Excellent")
        } else if (vDOP <= 5) {
            return qsTr("Good")
        } else if (vDOP <= 10) {
            return qsTr("Moderate")
        } else if (vDOP <= 20) {
            return qsTr("Fair")
        } else {
            return qsTr("Poor")
        }
    }

    readonly property real tDOP: 0//GPS.dop.tdop
    readonly property string tDOPText: {
        if (tDOP === 0) {
            return qsTr("Unknown")
        } else if (tDOP <= 1) {
            return qsTr("Ideal")
        } else if (tDOP <= 2) {
            return qsTr("Excellent")
        } else if (tDOP <= 5) {
            return qsTr("Good")
        } else if (tDOP <= 10) {
            return qsTr("Moderate")
        } else if (tDOP <= 20) {
            return qsTr("Fair")
        } else {
            return qsTr("Poor")
        }
    }


    //TODO: move to GpsPageModel
    readonly property Timer timerSatellites: Timer {
        running: true
        interval: 5000 //TODO: Settings
        repeat: true
        onTriggered: root.constellationUpdated()
    }

    function latitudeDMS(value) {
        var lat = coordinate.toString().split(",")
        return lat.length > 1 ? lat[0] : qsTr("Unknown")
    }

    function longitudeDMS(value) {
        var lon = coordinate.toString().split(",")
        return lon.length > 1 ? lon[1].substring(1) : qsTr("Unknown")
    }

    function altitudeM(value) {
        var alt = coordinate.toString().split(",")
        return lon.length > 2 ? lon[2] : qsTr("Unknown")
    }
}

pragma Singleton
import QtQuick 2.9
import QtPositioning 5.9

import common 1.0

QtObject {
    id: root

    property bool isRunning: false
    property bool isReseted: meters === 0

    property real meters: 0
    property real prevLatitude: 0
    property real prevLongitude: 0
    readonly property string meters_fmt: {
        if (meters < 10) {
            return "0000" + meters.toFixed(2)
        } else if (meters < 100) {
            return "000" + meters.toFixed(2)
        } else if (meters < 1000) {
            return "00" + meters.toFixed(2)
        } else if (meters < 10000) {
            return "0" + meters.toFixed(2)
        } else {
            return meters.toFixed(2)
        }


    }

    property Connections gpsModelConnection: Connections {
        target: GPSModel
        enabled: isRunning
        onPositionUpdated: {
            if (GPSModel.coordinate.isValid) {
                if ((prevLatitude == 0)&&(prevLongitude == 0) ) {
                    prevLatitude = GPSModel.latitude
                    prevLongitude = GPSModel.longitude
                } else {
                    meters += GPSModel.coordinate.distanceTo(QtPositioning.coordinate(prevLatitude, prevLongitude))
                    //console.log("meters:"+meters+" lat1:"+prevLatitude+" lat2:"+GPSModel.latitude)
                    prevLatitude = GPSModel.latitude
                    prevLongitude = GPSModel.longitude
                }
            }
        }
    }

    function start() {
        isRunning = true
    }

    function stop() {
        isRunning = false
    }

    function reset() {
        meters = 0
        prevLatitude = 0
        prevLongitude = 0
    }
}

pragma Singleton
import QtQuick 2.7
//import Qt.labs.settings 1.0

import common 1.0

QtObject {
    id: root

    property int labelWidth: 150

    property string header: qsTr("Current position")

    property color usedSatelliteColor: "#7DC24B"
    property color visibleSatelliteColor: "red"

    property string usedSatelliteLabel: qsTr("Used")+":"
    property string visibleSatellitesLabel: qsTr("Visible")+":"

    property string latitudeDMSLabel: qsTr("Latitude")+":"
    property string longitudeDMSLabel: qsTr("Longitude")+":"

    property string accuaracyLabel: qsTr("Accuaracy")+", "+qsTr("m")+":"
    property string accuaracyValue: {
        if (GPSModel.horizontalAccuracyValid) {
            return " ± " + GPSModel.horizontalAccuracy
        } else {
            return undefinedText
        }
    }

    property string altitudeLabel: qsTr("Altitude")+", "+qsTr("m")+":"
    property string altitudeValue: GPSModel.altitude.toFixed(2) +  " ± " + GPSModel.verticalAccuracy

    property string speedLabel: qsTr("Speed")+", " + qsTr("m/s")+":"
    property string speedValue: {
        if (GPSModel.speedValid) {
            return GPSModel.speed.toFixed(2)
        } else {
            return undefinedText
        }
    }

    property string verticalSpeedLabel: qsTr("V. speed")+", " + qsTr("m/s")+":"
    property string verticalSpeedValue: {
        if (GPSModel.verticalSpeedValid) {
            return GPSModel.verticalSpeed.toFixed(2)
        } else {
            return undefinedText
        }
    }

    property string gpsTimeLabel: qsTr("GPS Time") + ":"
    property string gpsTime: GPSModel.gpsTimeValid ? (GPSModel.gpsTimeYear + "-" +
                             GPSModel.gpsTimeMonth + "-" +
                             GPSModel.gpsTimeDay + " " +
                             GPSModel.gpsTimeHours + ":" +
                             GPSModel.gpsTimeMinutes + ":" +
                             GPSModel.gpsTimeSeconds) : undefinedText

    property string gpsCourseLabel: qsTr("Course")+", °:"
    property string gpsCourseValue: {
        if (GPSModel.courseValid) {
            return GPSModel.course.toFixed(2)
        } else {
            return undefinedText
        }
    }

    readonly property string undefinedText: qsTr("Undefined")


    property bool clickedSatelliteUsed: false
    property int clickedSatelliteNumber: 0
    property int clickedSatelliteAzimuth: 0
    property int clickedSatelliteElevation: 0
    property real clickedSatelliteSignalToNoiseRatio: 0.0
    readonly property string clickedSatellite: qsTr("Satellite") + ": " +
                                               clickedSatelliteNumber + " ("+clickedSatelliteAzimuth+", " +
                                               clickedSatelliteElevation + ") SNR: " + clickedSatelliteSignalToNoiseRatio + " dB"
    function getSatellite(x,y) {
        for (var j=0; j<GPSModel.satelliteModel.entryCount; j++) {
            var n = GPSModel.satelliteModel.data(GPSModel.satelliteModel.index(j,0), GPSModel.satelliteIdentifierRole)
            var a = GPSModel.satelliteModel.data(GPSModel.satelliteModel.index(j,0), GPSModel.satelliteAzimuthRole)
            var e = GPSModel.satelliteModel.data(GPSModel.satelliteModel.index(j,0), GPSModel.satelliteElevationRole)
            var u = GPSModel.satelliteModel.data(GPSModel.satelliteModel.index(j,0), GPSModel.satelliteElevationRole)
            var s = GPSModel.satelliteModel.data(GPSModel.satelliteModel.index(j,0), GPSModel.satelliteSignalStrengthRole)

            if ( (a === x)&&(e === (90-y)) ) {
                clickedSatelliteUsed = u
                clickedSatelliteNumber = n
                clickedSatelliteAzimuth = a
                clickedSatelliteElevation = e
                clickedSatelliteSignalToNoiseRatio = s
                break
            }
        }
    }

    //@depricated
    function buildConstellation(width,cntx) {
        var satRadius = 5
        var delta = 10
        var radius = width/2-delta
        var x_center = radius+delta
        var y_center = radius+delta
        cntx.moveTo(x_center+radius, y_center)
        cntx.beginPath()
        cntx.arc(x_center, y_center, radius, 0, 2*Math.PI, true)
        cntx.arc(x_center, y_center, 2*radius/3, 0, 2*Math.PI, true)
        cntx.arc(x_center, y_center, radius/3, 0, 2*Math.PI, true)

        cntx.moveTo(x_center,delta)
        cntx.lineTo(x_center,2*radius+delta)

        cntx.moveTo(delta,y_center)
        cntx.lineTo(2*radius+delta,y_center)

        cntx.textAlign = "center"
        cntx.fillText("N",x_center,delta)
        cntx.fillText("S",x_center,2*radius+2*delta)
        cntx.fillText("W",delta/2,y_center)
        cntx.fillText("E",2*radius+3*delta/2,y_center)

        cntx.strokeStyle = "black"
        cntx.lineWidth = 1
        cntx.closePath()
        cntx.stroke()

        cntx.beginPath()
        for (var j=0; j<GPSModel.satelliteList.length; j++) {
            var a = GPSModel.satelliteList[j].azimuth
            var e = GPSModel.satelliteList[j].elevation
            var u = GPSModel.satelliteList[j].isUsed

            if (u) {
                var x = radius + (radius-radius*e/90)*Math.sin((a*Math.PI/180)) + delta
                var y = radius - (radius-radius*e/90)*Math.cos((a*Math.PI/180)) + delta
                cntx.fillStyle = "#7DC24B"
                cntx.moveTo(x+satRadius,y)
                cntx.arc(x,y,satRadius,0,2*Math.PI, true)
            }
        }
        cntx.fill()

        cntx.beginPath()
        for (var j=0; j<GPSModel.satelliteList.length; j++) {
            var a = GPSModel.satelliteList[j].azimuth
            var e = GPSModel.satelliteList[j].elevation
            var u = GPSModel.satelliteList[j].isUsed

            if (!u) {
                var x = radius + (radius-radius*e/90)*Math.sin((a*Math.PI/180)) + delta
                var y = radius - (radius-radius*e/90)*Math.cos((a*Math.PI/180)) + delta
                cntx.fillStyle = "red"
                cntx.moveTo(x+satRadius,y)
                cntx.arc(x,y,satRadius,0,2*Math.PI, true)
            }
        }
        cntx.fill()

        cntx.beginPath()
        cntx.textAlign = "start"
        for (var j=0; j<GPSModel.satelliteList.length; j++) {
            var n = GPSModel.satelliteList[j].number
            var a = GPSModel.satelliteList[j].azimuth
            var e = GPSModel.satelliteList[j].elevation

            var x = radius + (radius-radius*e/90)*Math.sin((a*Math.PI/180)) + delta
            var y = radius - (radius-radius*e/90)*Math.cos((a*Math.PI/180)) + delta
            cntx.fillStyle = "black"
            cntx.moveTo(x+satRadius,y)
            cntx.fillText(n,x+satRadius,y+satRadius)
        }
        cntx.fill()
    }
}

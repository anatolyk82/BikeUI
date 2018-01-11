pragma Singleton
import QtQuick 2.7
import QtQuick.Controls 2.0

QtObject {
    id: root

    property var systemTime: new Date()

    readonly property string hours: {
        if (systemTime.getHours() < 10) {
            return "0"+systemTime.getHours()
        } else {
            return systemTime.getHours()
        }
    }
    readonly property string minutes: {
        if (systemTime.getMinutes() < 10) {
            return "0"+systemTime.getMinutes()
        } else {
            return systemTime.getMinutes()
        }
    }
    readonly property string seconds: {
        var sec = systemTime.getSeconds()
        if (sec < 10) {
            return "0"+sec
        } else {
            return sec
        }
    }

    readonly property string fullYear: systemTime.getFullYear()
    readonly property string month: {
        var m = systemTime.getMonth()
        if (m < 10) {
            return "0"+m
        } else {
            return m
        }
    }
    readonly property string day: {
        var d = systemTime.getDate()
        if (d < 10) {
            return "0"+d
        } else {
            return d
        }
    }

    readonly property Timer timerTime: Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            systemTime = new Date()
        }
    }
}

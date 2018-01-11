pragma Singleton
import QtQuick 2.9

QtObject {
    id: root

    readonly property bool isRunning: timerOfStopwatch.running

    property int mseconds: 0
    property int seconds: 0
    property int minutes: 0
    property int hours: 0

    property bool isReseted: (mseconds === 0) && (seconds === 0) && (minutes === 0) && (hours === 0)

    property string mseconds_fmt: mseconds < 10 ? "0" + mseconds : mseconds
    property string seconds_fmt: seconds < 10 ? "0" + seconds : seconds
    property string minutes_fmt: minutes < 10 ? "0" + minutes : minutes
    property string hours_fmt: hours < 10 ? "0" + hours : hours
    property string time_fmt: hours_fmt+"."+minutes_fmt+"."+seconds_fmt+"."+mseconds_fmt

    readonly property Timer timerOfStopwatch: Timer {
        triggeredOnStart: false
        interval: 10
        repeat: true
        onTriggered: {
            mseconds += 1

            if (mseconds === 100) {
                mseconds = 0
                seconds += 1
            }

            if (seconds === 60) {
                seconds = 0
                minutes += 1
            }

            if (minutes === 60) {
                minutes = 0
                hours += 1
            }
        }
    }

    function start() {
        reset()
        timerOfStopwatch.start()
    }

    function resume() {
        timerOfStopwatch.start()
    }

    function stop() {
        timerOfStopwatch.stop()
    }

    function reset() {
        mseconds = 0
        seconds = 0
        minutes = 0
        hours = 0
    }
}

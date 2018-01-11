pragma Singleton
import QtQuick 2.9

import system.notifications 1.0

QtObject {
    id: root

    readonly property bool isRunning: timerOfTimer.running
    property bool isBeingSet: false

    property int seconds: 0
    property int minutes: 0
    property int hours: 0

    property bool isReseted: (seconds === 0) && (minutes === 0) && (hours === 0)

    property string seconds_fmt: seconds < 10 ? "0" + seconds : seconds
    property string minutes_fmt: minutes < 10 ? "0" + minutes : minutes
    property string hours_fmt: hours < 10 ? "0" + hours : hours

    property string presetTimeInterval: ""

    readonly property Notification timerNotification: Notification {
        primaryText: "The time interval " + presetTimeInterval + " is over now."
        secondaryText: new Date()
        onTriggered: {
            //TODO: open the timer ?
            console.log("!!! Timer notification has been triggered")
        }
    }

    readonly property Timer timerOfTimer: Timer {
        triggeredOnStart: false
        interval: 1000
        repeat: true
        onTriggered: {
            seconds -= 1

            if (seconds === -1) {
                seconds = 59
                minutes -= 1
            }

            if (minutes === -1) {
                minutes = 59
                hours -= 1
            }

            if (hours === -1) {
                hours = 59
            }

            if ((seconds == 0)&&(minutes == 0)&&(hours == 0)) {
                timerOfTimer.stop()
                timerNotification.send()
            }
        }
    }

    function start() {
        presetTimeInterval = hours_fmt + ":" + minutes_fmt + ":" + seconds_fmt
        timerOfTimer.start()
    }

    function resume() {
        timerOfTimer.start()
    }

    function stop() {
        timerOfTimer.stop()
    }

    function reset() {
        presetTimeInterval = ""
        seconds = 0
        minutes = 0
        hours = 0
    }
}

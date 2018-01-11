import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import common 1.0
import components 1.0
import styles 1.0
import utils 1.0
import "."

Item {
    id: root

    property int primaryFontSize: 170
    property int secondaryFontSize: 170

    ActivityLabel {
        id: header
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 26
        text: qsTr("Timer")
        running: TimerModel.isRunning
    }
    BLabel {
        anchors.top: header.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        visible: TimerModel.isBeingSet
        text: qsTr("Swipe up and down on the digits to set the timer")
    }

    FontLoader {
        id: segmentIndicatorFont
        source: Utils.font("Segment7Standard.otf")
    }

    Row {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        spacing: -15
        BLabel {
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            opacity: 0.2
            text: "88"
        }
        BLabel {
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.secondaryFontSize
            opacity: 0.2
            text: "."
        }
        BLabel {
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            opacity: 0.2
            text: "88"
        }
        BLabel {
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.secondaryFontSize
            opacity: 0.2
            text: "."
        }
        BLabel {
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            opacity: 0.2
            text: "88"
        }
    }
    Row {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        spacing: -15
        HighlightedLabel {
            id: indicatorHours
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            radius: 30
            spred: 0.1
            text: TimerModel.hours_fmt
            Behavior on opacity { NumberAnimation { duration: 100 } }
            SwipeArea {
                anchors.fill: parent
                enabled: TimerModel.isBeingSet
                onSwipe: {
                    switch (direction) {
                        case "up":
                            TimerModel.hours += 1
                            if (TimerModel.hours == 100) {
                                TimerModel.hours = 99
                            }
                            break
                        case "down":
                            TimerModel.hours -= 1
                            if (TimerModel.hours == -1) {
                                TimerModel.hours = 99
                            }
                            break
                    }
                }
            }
        }
        HighlightedLabel {
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.secondaryFontSize
            radius: 30
            spred: 0.1
            text: "."
        }
        HighlightedLabel {
            id: indicatorMinutes
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            radius: 30
            spred: 0.1
            text: TimerModel.minutes_fmt
            Behavior on opacity { NumberAnimation { duration: 100 } }
            SwipeArea {
                anchors.fill: parent
                enabled: TimerModel.isBeingSet
                onSwipe: {
                    switch (direction) {
                        case "up":
                            TimerModel.minutes += 1
                            if (TimerModel.minutes == 60) {
                                TimerModel.minutes = 0
                            }
                            break
                        case "down":
                            TimerModel.minutes -= 1
                            if (TimerModel.minutes == -1) {
                                TimerModel.minutes = 59
                            }
                            break
                    }
                }
            }
        }
        HighlightedLabel {
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.secondaryFontSize
            radius: 30
            spred: 0.1
            text: "."
        }
        HighlightedLabel {
            id: indicatorSeconds
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            radius: 30
            spred: 0.1
            text: TimerModel.seconds_fmt
            Behavior on opacity { NumberAnimation { duration: 100 } }
            SwipeArea {
                anchors.fill: parent
                enabled: TimerModel.isBeingSet
                onSwipe: {
                    switch (direction) {
                        case "up":
                            TimerModel.seconds += 1
                            if (TimerModel.seconds == 60) {
                                TimerModel.seconds = 0
                            }
                            break
                        case "down":
                            TimerModel.seconds -= 1
                            if (TimerModel.seconds == -1) {
                                TimerModel.seconds = 59
                            }
                            break
                    }
                }
            }
        }
    }

    Timer {
        id: timerBlinking
        interval: 500
        repeat: true
        running: TimerModel.isBeingSet
        onTriggered: {
            indicatorHours.opacity = indicatorHours.opacity ? 0 : 1
            indicatorMinutes.opacity = indicatorMinutes.opacity ? 0 : 1
            indicatorSeconds.opacity = indicatorSeconds.opacity ? 0 : 1
        }
        onRunningChanged: {
            if (!running) {
                indicatorHours.opacity = 1
                indicatorMinutes.opacity = 1
                indicatorSeconds.opacity = 1
            }
        }
    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.7
        Button {
            id: btSet
            text: TimerModel.isBeingSet ? qsTr("Done") : qsTr("Set")
            visible: !TimerModel.isRunning
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: {
                TimerModel.isBeingSet = !TimerModel.isBeingSet
            }
        }
        Button {
            id: btStart
            text: qsTr("Start")
            enabled: !TimerModel.isReseted && (!TimerModel.isBeingSet)
            visible: !TimerModel.isRunning
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: TimerModel.start()
        }
        Button {
            id: btStop
            text: qsTr("Stop")
            visible: TimerModel.isRunning
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: TimerModel.stop()
        }
        Button {
            id: btReset
            text: qsTr("Reset")
            visible: (!TimerModel.isReseted)&&(!TimerModel.isRunning)
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: TimerModel.reset()
        }
    }

    Connections {
        target: TimerModel
        onIsBeingSetChanged: {
            SystemModel.verticalMainSwipeEnabled = !TimerModel.isBeingSet
        }
    }

}


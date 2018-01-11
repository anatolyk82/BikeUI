import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import components 1.0
import styles 1.0
import utils 1.0

import "."

Item {
    id: root

    ActivityLabel {
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 26
        text: qsTr("Stopwatch")
        running: StopwatchModel.isRunning
    }

    FontLoader {
        id: segmentIndicatorFont
        source: Utils.font("Segment7Standard.otf")
    }

    property int primaryFontSize: 140
    property int secondaryFontSize: 90

    BLabel {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        font.pixelSize: root.primaryFontSize
        font.family: segmentIndicatorFont.name
        opacity: 0.2
        text: "88.88.88.88"
    }

    HighlightedLabel {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        font.pixelSize: root.primaryFontSize
        font.family: segmentIndicatorFont.name
        radius: 30
        spred: 0.1
        text: StopwatchModel.time_fmt
    }

    /*Row {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        spacing: 0
        BLabel {
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            opacity: 0.2
            text: "88"
        }
        BLabel {
            font.pixelSize: root.primaryFontSize - 20
            opacity: 0.2
            text: "."
        }
        BLabel {
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            opacity: 0.2
            text: "88"
        }
        BLabel {
            font.pixelSize: root.primaryFontSize
            opacity: 0.2
            text: "."
        }
        BLabel {
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            opacity: 0.2
            text: "88"
        }
        BLabel {
            font.pixelSize: root.primaryFontSize
            opacity: 0.2
            text: " "
        }
        BLabel {
            font.pixelSize: root.secondaryFontSize
            font.family: segmentIndicatorFont.name
            opacity: 0.2
            text: "88"
        }
    }
    Row {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        spacing: 0
        HighlightedLabel {
            id: indicatorHours
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            radius: 30
            spred: 0.1
            text: StopwatchModel.hours_fmt
        }
        HighlightedLabel {
            font.pixelSize: root.primaryFontSize
            radius: 30
            spred: 0.1
            text: "."
        }
        HighlightedLabel {
            id: indicatorMinutes
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            radius: 30
            spred: 0.1
            text: StopwatchModel.minutes_fmt
        }
        HighlightedLabel {
            font.pixelSize: root.primaryFontSize
            radius: 30
            spred: 0.1
            text: "."
        }
        HighlightedLabel {
            id: indicatorSeconds
            font.pixelSize: root.primaryFontSize
            font.family: segmentIndicatorFont.name
            radius: 30
            spred: 0.1
            text: StopwatchModel.seconds_fmt
        }
        BLabel {
            font.pixelSize: root.primaryFontSize
            text: " "
        }
        HighlightedLabel {
            id: indicatorMSeconds
            font.pixelSize: root.secondaryFontSize
            font.family: segmentIndicatorFont.name
            radius: 30
            spred: 0.1
            text: StopwatchModel.mseconds_fmt
        }
    }*/


    RowLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.7
        Button {
            id: btStart
            text: qsTr("Start")
            visible: StopwatchModel.isReseted
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: StopwatchModel.start()
        }
        Button {
            id: btResume
            text: qsTr("Resume")
            visible: !StopwatchModel.isReseted
            enabled: !StopwatchModel.isRunning
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: StopwatchModel.resume()
        }
        Button {
            id: btStop
            text: qsTr("Stop")
            visible: (!StopwatchModel.isReseted) && (StopwatchModel.isRunning)
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: StopwatchModel.stop()
        }
        Button {
            id: btReset
            text: qsTr("Reset")
            visible: (!StopwatchModel.isReseted)&&(!StopwatchModel.isRunning)
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: StopwatchModel.reset()
        }
    }

    Component.onCompleted: {
    }
}


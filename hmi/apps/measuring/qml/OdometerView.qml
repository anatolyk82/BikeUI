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

    property int primaryFontSize: 140
    property int secondaryFontSize: 120

    ActivityLabel {
        id: header
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        font.pixelSize: 26
        text: qsTr("Odometer")
        running: OdometerModel.isRunning
    }

    FontLoader {
        id: segmentIndicatorFont
        source: Utils.font7Segments
    }

    BLabel {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        font.pixelSize: root.primaryFontSize
        font.family: segmentIndicatorFont.name
        opacity: 0.2
        text: "88888.88"
    }
    HighlightedLabel {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -40
        font.pixelSize: root.primaryFontSize
        font.family: segmentIndicatorFont.name
        radius: 30
        spred: 0.1
        text: OdometerModel.meters_fmt
    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width*0.7
        Button {
            id: btStart
            text: qsTr("Start")
            visible: !OdometerModel.isRunning
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: OdometerModel.start()
        }
        Button {
            id: btStop
            text: qsTr("Stop")
            visible: OdometerModel.isRunning
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: OdometerModel.stop()
        }
        Button {
            id: btReset
            text: qsTr("Reset")
            visible: (!OdometerModel.isReseted)&&(!OdometerModel.isRunning)
            Layout.fillWidth: true
            Layout.minimumHeight: StyleModel.buttonHeight
            Layout.minimumWidth: 140
            onClicked: OdometerModel.reset()
        }
    }
}

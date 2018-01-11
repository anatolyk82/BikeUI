import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

import QtPositioning 5.5
import QtLocation 5.6

import utils 1.0
import components 1.0
import common 1.0

import "./"

//qsTr("Distance")
//qsTr("Max. altitude")
//qsTr("Min. altitude")
//qsTr("Altitude at the start")
//qsTr("Altitude at the end")

Pane {
    property int labelWidth: 160
    Column {
        anchors.fill: parent
        spacing: 10

        Image {
            source: Utils.icon("w_distance")
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Item { width: 24; height: width }
            Label {
                Layout.minimumWidth: labelWidth
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Distance") + ":"
            }
            Label {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                text: Math.round(CoursesModel.entireDistance)
            }
        }

        //----

        Image {
            source: Utils.icon("w_altitude")
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Item { width: 24; height: width }
            Label {
                Layout.minimumWidth: labelWidth
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Max. altitude") + ":"
            }
            Label {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                text: CoursesModel.altitudeMax
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Item { width: 24; height: width }
            Label {
                Layout.minimumWidth: labelWidth
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Min. altitude") + ":"
            }
            Label {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                text: CoursesModel.altitudeMin
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Item { width: 24; height: width }
            Label {
                Layout.minimumWidth: labelWidth
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Altitude at the start") + ":"
            }
            Label {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                text: CoursesModel.altitudeStart
            }
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: Utils.spacingByDefault
            Item { width: 24; height: width }
            Label {
                Layout.minimumWidth: labelWidth
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Altitude at the end") + ":"
            }
            Label {
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
                text: CoursesModel.altitudeEnd
            }
        }

    }
}

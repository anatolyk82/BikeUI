import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import utils 1.0
import common 1.0
import styles 1.0

import system.notifications 1.0
import system.settings 1.0

ToolBar {
    id: root

    signal topBarClicked()
    height: StyleModel.toolbarHeight

    RowLayout {
        id: mainRow
        spacing: 10
        anchors.fill: parent
        anchors.leftMargin: spacing
        anchors.rightMargin: spacing

        /* Title */
        Item {
            id: titleContainer
            anchors.verticalCenter: parent.verticalCenter
            height: root.height
            width: 300
            clip: true
            BLabel {
                id: labelPage1
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: SystemModel.activeScreenNumber === 0 ? 0 : -1*parent.height
                Behavior on anchors.verticalCenterOffset { SpringAnimation { spring: 3; damping: 0.2 } }
                elide: Text.ElideRight
                text: qsTr("Menu")
            }
            BLabel {
                id: labelPage2
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: SystemModel.activeScreenNumber === 1 ? 0 : 1*parent.height
                Behavior on anchors.verticalCenterOffset { SpringAnimation { spring: 3; damping: 0.2 } }
                elide: Text.ElideRight
                text: SystemModel.currentApplicationTitle
            }
        }


        Item {
            id: notificationContainer
            height: parent.height
            Layout.minimumWidth: height
            Layout.fillWidth: true
            Row {
                spacing: mainRow.spacing
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.left: parent.left
                layoutDirection: Qt.RightToLeft
                Repeater {
                    model: NotificationCenter.toolBarNotificationList
                }
            }
        }

        //Speed
        BLabel {
            text: isNaN(GPSModel.speed) ? "00" : BMath.ms2kmh(GPSModel.speed,0,true)
            font.pixelSize: 32
            anchors.verticalCenter: parent.verticalCenter
            visible:  SettingsModel.toolbarDisplaysSpeed
            opacity: isNaN(GPSModel.course) ? 0.5 : 1
            font.family: segmentIndicatorFont.name
            FontLoader {
                id: segmentIndicatorFont
                source: Utils.font7Segments
            }
        }

        /* Course */
        Image {
            fillMode: Image.Pad
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            source: Utils.icon("w_course")
            rotation: isNaN(GPSModel.course) ? 0 : GPSModel.course
            opacity: isNaN(GPSModel.course) ? 0.5 : 1
            Behavior on rotation { NumberAnimation { duration: 1000; easing.type: Easing.OutBack } }
            visible: SettingsModel.toolbarDisplaysCourse
        }

        /* Movement status */
        Image {
            fillMode: Image.Pad
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            source: GPSModel.isMoving ? Utils.icon("w_ride") : Utils.icon("w_stand")
            visible: SettingsModel.toolbarDisplaysMovements
        }

        /* GPS status indicator */
        Image {
            fillMode: Image.Pad
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            source: GPSModel.gpsFixIcon
        }

        /* Battery level indicator */
        Image {
            fillMode: Image.Pad
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            source: BatteryModel.batteryIcon
        }
        Label {
            text: BatteryModel.batteryPercentage
            font.pixelSize: StyleModel.toolbarFontSize
            verticalAlignment: Qt.AlignVCenter
            //visible:  //TODO: Settings
        }

        //TODO: Add date format in settings
        /* Date */
        Label {
            text: DateTimeModel.day + "." + DateTimeModel.month + "." + DateTimeModel.fullYear
            visible: SettingsModel.toolbarDisplaysDate
            font.pixelSize: StyleModel.toolbarFontSize
            elide: Label.ElideRight
            verticalAlignment: Qt.AlignVCenter
        }

        /* Time */
        Label {
            text: {
                if (SettingsModel.toolbarDisplaysSeconds) {
                    return DateTimeModel.hours + ":" + DateTimeModel.minutes+ ":" + DateTimeModel.seconds
                } else {
                    return DateTimeModel.hours + ":" + DateTimeModel.minutes
                }
            }
            visible: SettingsModel.toolbarDisplaysTime
            font.pixelSize: StyleModel.toolbarFontSize
            elide: Label.ElideRight
            verticalAlignment: Qt.AlignVCenter
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: root.topBarClicked()
    }
}

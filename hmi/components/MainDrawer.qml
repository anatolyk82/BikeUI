import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

import utils 1.0
import styles 1.0
import common 1.0
import system.notifications 1.0

import screen 1.0

Drawer {
    id: drawer

    background: Rectangle {
        width: parent.width
        height: parent.height
        gradient: Gradient {
            GradientStop { position: 1; color: "#01008a" } //TODO: move to Style
            GradientStop { position: 0; color: "#000106" } //TODO: move to Style
        }
    }

    dragMargin: StyleModel.toolbarHeight
    height: window.height*0.9
    width: window.width

    edge: Qt.TopEdge

    signal poweroff()
    signal reboot()
    signal stopwatch()
    signal odometer()
    signal settings()

    ListView {
        width: parent.width*0.95
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.bottom: rowButtons.top
        anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        model: NotificationCenter.notificationList
    }

    RowLayout {
        id: rowButtons
        width: parent.width*0.95
        anchors.bottom: rowScreenBrightness.top
        anchors.horizontalCenter: parent.horizontalCenter
        BButton {
            id: buttonSettings
            iconSource: Utils.icon("ic_settings")
            enabled: SystemModel.verticalMainSwipeEnabled
            Layout.fillWidth: true
            onClicked: {
                settings()
            }
        }
        BButton {
            id: buttonReboot
            iconSource: Utils.icon("ic_reboot")
            Layout.fillWidth: true
            onClicked: {
                reboot()
            }
        }
        BButton {
            id: buttonShutdown
            iconSource: Utils.icon("ic_shutdown")
            Layout.fillWidth: true
            onClicked: {
                poweroff()
            }
        }
    }

    RowLayout {
        id: rowScreenBrightness
        width: parent.width*0.95
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        Image {
            anchors.verticalCenter: parent.verticalCenter
            source: Utils.icon("ic_brightness")
        }
        BSlider {
            id: brightnessSlider
            width: parent.width*0.95
            anchors.verticalCenter: parent.verticalCenter
            Layout.fillWidth: true
            from: 0
            to: 100
            stepSize: 1
            snapMode: Slider.SnapAlways
            value: Screen.brightness
            onValueChanged: {
                if (value !== Screen.brightness) {
                    Screen.brightness = value
                }
            }
            bubbleVisible: true
        }
        BLabel {
            text: Math.round(brightnessSlider.value) + "%"
        }
    }
}

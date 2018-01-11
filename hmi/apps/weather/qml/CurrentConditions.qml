import QtQuick 2.10
import QtQuick.Controls 2.3

import components 1.0
import common 1.0
import styles 1.0

import "."

Item {
    id: root

    BLabel {
        id: locationNameLabel
        anchors.horizontalCenter: root.horizontalCenter
        anchors.top: root.top
        anchors.topMargin: 10
        text: WeatherModel.locationName
        visible: WeatherModel.locationName !== ""
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: WeatherModel.gettingData
    }
    BLabel {
        id: watingText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: busyIndicator.bottom
        visible: WeatherModel.gettingData
        text: WeatherModel.statusText
    }

    Rectangle {
        id: daylightPane
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: locationNameLabel.bottom
        color: "transparent"
        border.color: "white"
        width: parent.width
        height: 100

        Rectangle {
            id: daylightProgress
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            color: "transparent"
            border.color: StyleModel.primaryFontColor
            width: parent.width*0.8
            height: 40

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 1
                width: (parent.width-1)*0.6
                height: 38
                gradient: Gradient {
                    GradientStop { position: 0; color: StyleModel.primaryFontColor }
                    GradientStop { position: 1; color: StyleModel.secondaryFontColor }
                }
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
            }

            BLabel {
                id: labelSunrise
                anchors.top: daylightProgress.bottom
                anchors.left: daylightProgress.left
                anchors.leftMargin: -labelSunrise.paintedWidth/2
                text: WeatherModel.timeSunriseString
            }

            BLabel {
                id: labelSunset
                anchors.top: daylightProgress.bottom
                anchors.right: daylightProgress.right
                anchors.rightMargin: -labelSunset.paintedWidth/2
                text: WeatherModel.timeSunsetString
            }
        }
    }
}

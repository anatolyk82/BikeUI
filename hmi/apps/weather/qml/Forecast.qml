import QtQuick 2.10
import QtQuick.Controls 2.3

import components 1.0
import utils 1.0
import common 1.0

import "."

Item {
    id: root

    Carousel {
        anchors.fill: root
        visible: !WeatherModel.gettingData
        model: WeatherModel.weatherModel
        pageIndicatorVisible: false
        delegate: Item {
            width: 300
            height: parent.height
            Column {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -10
                spacing: 10
                Item {
                    width: 128
                    height: 128
                    anchors.horizontalCenter: parent.horizontalCenter
                    Image {
                        id: weatherPicture
                        anchors.centerIn: parent
                        source: WeatherModel.getWeatherIcon(model.symbolNumber)
                        visible: source != ""
                    }
                    BLabel {
                        text: model.symbolName
                        anchors.centerIn: parent
                        visible: !weatherPicture.visible
                    }
                }
                BLabel {
                    font.pixelSize: 64
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: WeatherModel.getCelsiusFromKelvin(model.temperatureValue) + " °C"
                }
                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        source: Utils.icon("w_course")
                        rotation: parseInt(model.windDirectionDeg)
                    }
                    BLabel {
                        anchors.verticalCenter: parent.verticalCenter
                        text: WeatherModel.getWindInfo(model.windSpeedValue, model.windSpeedName)
                    }
                }
                BLabel {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: WeatherModel.getForecastTime(model.from, model.to)
                }
            }
        }
    }

    BLabel {
        anchors.horizontalCenter: root.horizontalCenter
        anchors.top: root.top
        anchors.topMargin: 10
        text: WeatherModel.locationName
        visible: WeatherModel.locationName !== ""
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: root
        visible: WeatherModel.gettingData
    }
    BLabel {
        id: watingText
        anchors.horizontalCenter: root.horizontalCenter
        anchors.top: busyIndicator.bottom
        visible: WeatherModel.gettingData
        text: WeatherModel.statusText
    }
}

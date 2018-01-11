import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import QtQuick.VirtualKeyboard 2.2
import QtQuick.VirtualKeyboard.Settings 2.2

import components 1.0
import utils 1.0
import system.keyboard 1.0
import common 1.0

import "."

Item {
    id: root

    GroupBox {
        id: leftPane
        anchors.left: parent.left
        anchors.top: parent.top
        width: 250
        height: parent.height
        Column {
            spacing: 10
            anchors.fill: parent
            anchors.margins: 5
            Button { //TODO: BButton
                text: qsTr("Current conditions")
                width: parent.width
                enabled: rightPane.status !== Loader.Loading
                onClicked: WeatherModel.applicationState = WeatherModel.currentConditionsState
            }
            Button { //TODO: BButton
                text: qsTr("Forecast")
                width: parent.width
                enabled: rightPane.status !== Loader.Loading
                onClicked: WeatherModel.applicationState = WeatherModel.forecastState
            }
        }

        BLabel {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            font.pixelSize: 14
            text: WeatherModel.lastWeatherUpdateText
            visible: WeatherModel.lastWeatherUpdateText !== ""
        }
    }

    DynamicContentPage {
        id: rightPane
        anchors.left: leftPane.right
        anchors.top: parent.top
        width: parent.width - leftPane.width
        height: parent.height

        clip: true
    }

    //state: WeatherModel.applicationState

    states: [
        State {
            name: WeatherModel.currentConditionsState
            when: WeatherModel.applicationState === WeatherModel.currentConditionsState
            PropertyChanges {
                target: rightPane
                sourceComponent: componentCurrentConditions
            }
        },
        State {
            name: WeatherModel.forecastState
            when: WeatherModel.applicationState === WeatherModel.forecastState
            PropertyChanges {
                target: rightPane
                sourceComponent: componentForecast
            }
        }
    ]


    Component {
        id: componentCurrentConditions
        CurrentConditions { }
    }

    Component {
        id: componentForecast
        Forecast { }
    }


    Component.onCompleted: {
        WeatherModel.updateWeather()
    }
}

import QtQuick 2.9
import components 1.0

ApplicationBase {
    id: root

    appId: "org.bike.weather"
    enabled: true
    appName: qsTr("Weather")
    appIcon: "apps/weather/weather.png"
    mainFile: "apps/weather/qml/WeatherView.qml"
}

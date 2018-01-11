pragma Singleton
import QtQuick 2.10
import QtQuick.XmlListModel 2.0

import common 1.0

//api.openweathermap.org/data/2.5/weather?q=London,uk&APPID=1731e254ab7e1eec4bb1578f8c5ae3fc
//api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&APPID=1731e254ab7e1eec4bb1578f8c5ae3fc
//charts/qmlweather/qml/qmlweather/main.qml

/*

<time from="2018-01-03T18:00:00" to="2018-01-03T21:00:00">
   <symbol number="500" name="light rain" var="10n"/>
   <precipitation unit="3h" value="0.785" type="rain"/>
   <windDirection deg="101" code="E" name="East"/>
   <windSpeed mps="4.31" name="Gentle Breeze"/>
   <temperature unit="kelvin" value="275.88" min="275.88" max="276.183"/>
   <pressure unit="hPa" value="987.53"/>
   <humidity value="100" unit="%"/>
   <clouds value="overcast clouds" all="92" unit="%"/>
</time>

*/

QtObject {
    id: root

    signal weatherUpdated()

    readonly property string apiKey: "1731e254ab7e1eec4bb1578f8c5ae3fc"

    readonly property var weatherIcons: {
        "500" : "./icons/tick/light_rain.png", //light rain
        "600" : "./icons/tick/snow1.png",   //light snow
        "800" : "./icons/tick/sunny.png",   //clear sky
        "801" : "./icons/tick/cloudy2.png", //few clouds
        "802" : "./icons/tick/cloudy3.png", //scattered clouds
        "803" : "./icons/tick/cloudy4.png", //broken clouds
    }

    readonly property string currentConditionsState: "current conditions"
    readonly property string forecastState: "forecast"
    property string applicationState: currentConditionsState

    property var timeSunrise: new Date("2018-01-11T09:11:27") //TODO: get from json
    readonly property string timeSunriseString: timeSunrise.getHours() + ":" + timeSunrise.getMinutes()
    property var timeSunset: new Date("2018-01-11T16:28:56")  //TODO: get from json
    readonly property string timeSunsetString: timeSunset.getHours() + ":" + timeSunset.getMinutes()
    property real currentSuntime: {
        var curTime = new Date()

    }

    property var lastWeatherUpdate: null
    property string lastWeatherUpdateText: {
        if (lastWeatherUpdate == null) {
            return ""
        } else {
            return qsTr("Last update") + ": "
            + lastWeatherUpdate.getHours() + ":" + (lastWeatherUpdate.getMinutes() < 10 ? "0"+lastWeatherUpdate.getMinutes() : lastWeatherUpdate.getMinutes())
            + ":" + (lastWeatherUpdate.getSeconds() < 10 ? "0"+lastWeatherUpdate.getSeconds() : lastWeatherUpdate.getSeconds())
        }
    }

    readonly property ListModel weatherModel: ListModel {}

    property string statusText: ""
    property bool gettingData: true
    readonly property XmlListModel weatherXMLModel: XmlListModel {
        query: "/weatherdata/forecast/time"

        onStatusChanged: {
            if (weatherXMLModel.status == XmlListModel.Ready) {
                weatherModel.clear()
                for (var j=0; j<6; j++) {
                    if (weatherXMLModel.get(j) !== undefined)
                        weatherModel.append( weatherXMLModel.get(j) )
                }

                statusText = qsTr("Ready")
                gettingData = false
                root.weatherUpdated()
                lastWeatherUpdate = new Date()
            }
        }

        XmlRole { name: "from"; query: "@from/string()" }
        XmlRole { name: "to"; query: "@to/string()" }
        XmlRole { name: "symbolVar"; query: "symbol/@var/string()" }
        XmlRole { name: "symbolNumber"; query: "symbol/@number/string()" }
        XmlRole { name: "symbolName"; query: "symbol/@name/string()" }
        XmlRole { name: "precipitationUnit"; query: "precipitation/@unit/string()" }
        XmlRole { name: "precipitationValue"; query: "precipitation/@value/string()" }
        XmlRole { name: "precipitationType"; query: "precipitation/@type/string()" }
        XmlRole { name: "windDirectionDeg"; query: "windDirection/@deg/string()" }
        XmlRole { name: "windDirectionName"; query: "windDirection/@name/string()" }
        XmlRole { name: "windSpeedValue"; query: "windSpeed/@mps/string()" }
        XmlRole { name: "windSpeedName"; query: "windSpeed/@name/string()" }
        XmlRole { name: "temperatureValue"; query: "temperature/@value/string()" }
    }

    property string locationName: ""

    readonly property XmlListModel locationXMLModel: XmlListModel {
        xml: weatherXMLModel.xml
        query: "/weatherdata/location"
        XmlRole { name: "locationName"; query: "name/string()" }

        onStatusChanged: {
            if (weatherXMLModel.status == XmlListModel.Ready) {
                if (locationXMLModel.count > 0) {
                    locationName = locationXMLModel.get(0).locationName
                }
            }
        }
    }

    readonly property Connections connectionToUpdateLocation: Connections {
        target: GPSModel
        onPositionUpdated: {
            if ( (!isNaN(GPSModel.latitude)) && (!isNaN(GPSModel.longitude)) ) {
                updateWeather()
            }
        }
    }

    function updateWeather() {
        var weatherNeedstoUpdate = true
        if (lastWeatherUpdate !== null) {
            var diffSecs = Math.abs(new Date() - lastWeatherUpdate) / 1000;
            if (diffSecs < 1800) {
                weatherNeedstoUpdate = false
            }
        }

        if (weatherNeedstoUpdate) {
            gettingData = true
            statusText = qsTr("Acquiring position")
            if ( (!isNaN(GPSModel.latitude)) && (!isNaN(GPSModel.longitude)) ) {
                requestWeather()
            }
        }
    }

    function getWeatherIcon(weatherNumber) {
        //return "http://openweathermap.org/img/w/"+weatherNumber+".png"
        var icon = ""
        if (weatherIcons.hasOwnProperty(weatherNumber)) {
            icon = weatherIcons[weatherNumber]
        }
        return icon
    }

    function getForecastTime(fromTime, toTime) {
        var fT = new Date(fromTime)
        var tT = new Date(toTime)
        var s = fT.getHours() + ":" + (fT.getMinutes() < 10 ? "0"+fT.getMinutes() : fT.getMinutes()) + " - "
                + tT.getHours() + ":" + (tT.getMinutes() < 10 ? "0"+tT.getMinutes() : tT.getMinutes())
        s += " ("+(fT.getDate() < 10 ? "0"+fT.getDate() : fT.getDate())+"."
                +(fT.getMonth() < 9 ? "0"+(fT.getMonth()+1) : (fT.getMonth()+1))+")"
        return s
    }

    function getCelsiusFromKelvin(kelvinTemperature) {
        return Math.round(kelvinTemperature-273.15)
    }

    function getWindInfo(speedValue, speedName) {
        return speedValue+" m/s" //speedName + " ("+speedValue+" m/s)"
    }

    function requestWeather() {
        weatherXMLModel.xml = ""
        var weatherRequest = new XMLHttpRequest
        if (isNaN(GPSModel.latitude) || isNaN(GPSModel.longitude)) {
            console.warn("WeatherModel::requestWeather(): Cannot determine the location")
            return
        }

        statusText = qsTr("Receiving data")
        var weatherURL = "http://api.openweathermap.org/data/2.5/forecast?mode=xml&lat="+GPSModel.latitude+"&lon="+GPSModel.longitude+"&APPID="+apiKey
        weatherRequest.open("GET", weatherURL)
        console.log(weatherURL)
        weatherRequest.onreadystatechange = function() {
            if (weatherRequest.readyState === XMLHttpRequest.DONE) {
                statusText = qsTr("Parsing data")
                weatherXMLModel.xml = weatherRequest.responseText
            }
        }

        weatherRequest.send()
    }


    function updateCurrentConditions() {
        var currentConditionsRequest = new XMLHttpRequest
        var currentConditionsURL = "http://api.openweathermap.org/data/2.5/weather?lat="+GPSModel.latitude+"&lon="+GPSModel.longitude+"&APPID="+apiKey
        currentConditionsRequest.open("GET", currentConditionsURL)
        console.log(currentConditionsURL)
        currentConditionsRequest.onreadystatechange = function() {
            if (currentConditionsRequest.readyState === XMLHttpRequest.DONE) {
                statusText = qsTr("Parsing data")
                //currentConditionsRequest.responseText
            }
        }

        currentConditionsRequest.send()
    }
}

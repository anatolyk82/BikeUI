import QtQuick 2.9
import components 1.0

ApplicationBase {
    id: root

    appId: "org.bike.gps"
    enabled: true
    appName: qsTr("GPS")
    appIcon: "apps/gps/gps.png" //"ic_gps"
    mainFile: "apps/gps/qml/GpsPage.qml"
}

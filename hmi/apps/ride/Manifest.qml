import QtQuick 2.9
import components 1.0

ApplicationBase {
    id: root

    appId: "org.bike.ride"
    enabled: true
    appName: qsTr("Ride")
    appIcon: "apps/ride/ride.png" //"ic_bike"
    mainFile: "apps/ride/qml/RideView.qml"
}

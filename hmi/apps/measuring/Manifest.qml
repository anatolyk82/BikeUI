import QtQuick 2.9
import components 1.0

ApplicationBase {
    id: root

    appId: "org.bike.measuring"
    enabled: true
    appName: qsTr("Measuring")
    appIcon: "apps/measuring/measuring.png" //"ic_timer"
    mainFile: "apps/measuring/qml/MainView.qml"
}

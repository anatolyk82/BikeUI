import QtQuick 2.9
import components 1.0

ApplicationBase {
    id: root

    appId: "org.bike.engineering"
    enabled: false
    appName: qsTr("Engineering")
    appIcon: "apps/engineering/engineering.png" //"ic_gps"
    mainFile: "apps/engineering/qml/Engineering.qml"
}

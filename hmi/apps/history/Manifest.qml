import QtQuick 2.9
import components 1.0

ApplicationBase {
    id: root

    appId: "org.bike.history"
    enabled: false
    appName: qsTr("History")
    appIcon: "ic_history"
    mainFile: "apps/history/qml/HistoryPage.qml"
}

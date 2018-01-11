import QtQuick 2.9
import components 1.0

ApplicationBase {
    id: root

    appId: "org.bike.navigation"
    enabled: true
    appName: qsTr("Navigation")
    appIcon: "apps/navigation/navigation.png"
    //mainFile: "apps/navigation/qml/NavigationPage.qml"
    mainFile: "apps/navigation/qml/CoursesPage.qml"
}

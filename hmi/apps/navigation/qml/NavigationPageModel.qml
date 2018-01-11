pragma Singleton
import QtQuick 2.7
import QtQuick.Controls 2.0

QtObject {
    id: root

    property ListModel navigationMenuModel: ListModel {
        ListElement {
            labelId: "Map"
            iconId: "ic_gps"
            //page: "components/navigation/"
        }
        ListElement {
            labelId: "Courses"
            iconId: "ic_navigation"
            page: "components/navigation/CoursesPage.qml"
        }
        ListElement {
            labelId: "POI"
            iconId: "ic_pin"
            //page: "components/navigation/"
        }
    }
}

/* Settings
 * - GPS
 * - System
 * --
 *
 */

pragma Singleton
import QtQuick 2.9
import QtQuick.Controls 2.2

import components 1.0
import "."

import common 1.0

QtObject {
    id: root

    signal stepBack()
    signal stepTo(string settingsPage)

    readonly property string applicationId: "org.bike.settings"

    readonly property string titleMain: qsTr("Settings")
    property string settingsTitle: titleMain
    readonly property string settingsMainFile: Qt.resolvedUrl("SettingsMainView.qml")
    property string currentFileToLoad: ""

    property ListModel titleModel: ListModel {
        onCountChanged: {
            settingsTitle = titleMain
            for (var i=0; i<titleModel.count; i++ ) {
                settingsTitle += "/" + titleModel.get(i).title
            }
            SystemModel.currentApplicationTitle = settingsTitle
        }
    }

    readonly property ListModel menuSettings: ListModel {
        /*ListElement {
            icon: "ic_map"
            labelId: "navigation"
            page: ""
        }*/
        ListElement {
            icon: "ic_satellite"
            labelId: "gps"
            page: "GPSSettingsView.qml"
        }
        ListElement {
            icon: "ic_connection"
            labelId: "connection"
            page: "ConnectionSettingsView.qml"
        }
        ListElement {
            icon: "ic_settings"
            labelId: "system"
            page: "SystemSettingsView.qml"
        }
    }

    function goBack() {
        titleModel.remove( (titleModel.count-1) )
        root.stepBack()
    }

    function openSettingsPage(page) {
        root.stepTo(page)
    }

    function addTitle(title) {
        titleModel.append( {"title":title} )
    }

    function itemTranslation(labelId) {
        if (labelId === "navigation") {
            return qsTr("Navigation")
        } else if (labelId === "gps") {
            return qsTr("GPS & Navigation")
        } else if (labelId === "connection") {
            return qsTr("Connection")
        } else if (labelId === "system") {
            return qsTr("System")
        } else {
            return ""
        }
    }


    //TODO: put these properties in Settings {}
    /***************************************************************/
    //Time
    property bool toolbarDisplaysTime: true
    property bool toolbarDisplaysSeconds: true
    property bool toolbarDisplaysDate: false
    /***************************************************************/
    // GPS
    property bool toolbarDisplaysMovements: true
    property bool toolbarDisplaysCourse: true
    property bool toolbarDisplaysSpeed: true

    property int gpsIntervalUpdate: 1000

    /***************************************************************/
}

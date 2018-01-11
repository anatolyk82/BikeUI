import QtQuick 2.9
import QtQuick.Controls 2.2

import components 1.0
import utils 1.0

import "."

SettingsView {
    id: root

    title: qsTr("System")

    ListItem {
        id: timeSettingsItem
        width: root.width
        accessoryIcon: Utils.icon("tb_arrow_right")
        primaryText: qsTr("Time settings")
        onClicked: SettingsModel.openSettingsPage("TimeSettingsView.qml")
    }

    ListItem {
        id: screenSettingsItem
        width: root.width
        accessoryIcon: Utils.icon("tb_arrow_right")
        primaryText: qsTr("Screen configuration")
        onClicked: SettingsModel.openSettingsPage("ScreenSettingsView.qml")
    }
}

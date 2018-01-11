import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import components 1.0
import styles 1.0
import "."

SettingsView {
    id: root

    title: qsTr("Time")

    BCheckBox {
        id: displayTimeCheckbox
        width: root.width
        text: qsTr("Display time in the tool bar")
        checked: SettingsModel.toolbarDisplaysTime
        onCheckedChanged: SettingsModel.toolbarDisplaysTime = displayTimeCheckbox.checked
    }

    BCheckBox {
        id: displaySecondsCheckbox
        width: root.width
        enabled: displayTimeCheckbox.checked
        text: qsTr("Display seconds with time")
        checked: SettingsModel.toolbarDisplaysSeconds
        onCheckedChanged: SettingsModel.toolbarDisplaysSeconds = displaySecondsCheckbox.checked
    }

    BCheckBox {
        id: displayDateCheckbox
        width: root.width
        text: qsTr("Display date in the tool bar")
        checked: SettingsModel.toolbarDisplaysDate
        onCheckedChanged: SettingsModel.toolbarDisplaysDate = displayDateCheckbox.checked
    }

    RowLayout {
        width: root.width
        BLabel {
            Layout.preferredWidth: parent.width/2
            text: qsTr("Time format")
        }
        ComboBox {
            Layout.preferredWidth: parent.width/2
        }
    }
}

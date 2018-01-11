import QtQuick 2.9
import QtQuick.Controls 2.2

import "./"

import utils 1.0
import components 1.0
import styles 1.0
import system.notifications 1.0

Item {
    id: root

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.margins: 15
        initialItem: ListView {
            id: listView
            model: SettingsModel.menuSettings

            delegate: ListItem {
                width: listView.width
                iconSource: Utils.icon(model.icon)
                accessoryIcon: Utils.icon("tb_arrow_right")
                primaryText: SettingsModel.itemTranslation(model.labelId)
                onClicked: {
                    stackView.push(model.page)
                }
            }
        }
        Connections {
            target: SettingsModel
            onStepBack: {
                stackView.pop()
            }
            onStepTo: {
                stackView.push(settingsPage)
            }
        }
    }
}

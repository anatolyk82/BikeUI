import QtQuick 2.9
import QtQuick.Controls 2.2

import utils 1.0
import common 1.0


Item {
    property alias model: gridView.model
    GridView {
        id: gridView
        width: 4*cellWidth
        height: 2.3*cellHeight
        anchors.centerIn: parent
        cellWidth: Utils.appButtonWidth
        cellHeight: Utils.appButtonHeight
        delegate: MenuButton {
            text: model.name
            icon: Utils.icon(model.icon)
            onClicked: {
                SystemModel.runApp(model.mainFile)
            }
        }
    }
}

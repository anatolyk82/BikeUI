import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

import utils 1.0
import components 1.0
import common 1.0

import "./"

Page {
    id: root

    padding: 0

    background: Background { }

    GridView {
        width: 3*cellWidth
        height: 2*cellHeight
        anchors.centerIn: parent
        cellWidth: Utils.appButtonWidth
        cellHeight: Utils.appButtonHeight
        model: NavigationPageModel.navigationMenuModel
        delegate: MenuButton {
            text: labelId
            icon: Utils.icon(iconId)
            onClicked: {
                SystemModel.pushPage(page)
            }
        }
    }
}

import QtQuick 2.9
import QtQuick.Controls 2.2

import "./"

import utils 1.0
import components 1.0
import styles 1.0
import system.notifications 1.0

Item {
    id: root

    default property alias content: settingsColumn.children
    property string title: ""
    property alias spacing: settingsColumn.spacing

    ListItem {
        id: buttonBack
        width: root.width
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        iconSource: Utils.icon("tb_arrow_left")
        primaryText: qsTr("Back")
        onClicked: SettingsModel.goBack()
    }
    Flickable {
        id: settingsFlickable
        anchors.top: buttonBack.bottom
        anchors.topMargin: settingsColumn.spacing
        anchors.bottom: root.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        contentWidth: settingsColumn.width
        contentHeight: settingsColumn.height
        flickableDirection: Flickable.VerticalFlick
        interactive: contentHeight > settingsFlickable.height
        clip: true

        Column {
            id: settingsColumn
            spacing: 10
            width: parent.width
        }

        ScrollIndicator.vertical: ScrollIndicator { }
    }

    Component.onCompleted: {
        SettingsModel.addTitle( root.title )
    }
}

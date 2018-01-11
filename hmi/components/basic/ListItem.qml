import QtQuick 2.9
import QtQuick.Controls 2.3

import utils 1.0
import styles 1.0

MenuItem {
    id: root

    property alias primaryText: primaryText.text
    property alias secondaryText: secondaryText.text

    property alias iconSource: img.source
    property string accessoryIcon: ""

    height: StyleModel.listItemHeight//+10
    Image {
        id: img
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
    }
    Column {
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: img.right
        anchors.leftMargin: 20
        spacing: 5
        BLabel {
            id: primaryText
            width: parent.width
            font.pixelSize: StyleModel.listItemPrimaryFontSize
            elide: Text.ElideRight
        }
        BLabel {
            id: secondaryText
            width: parent.width
            font.pixelSize: StyleModel.listItemSecondaryFontSize
            color: StyleModel.secondaryFontColor
            elide: Text.ElideRight
            visible: text != ""
        }
    }

    Loader {
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        sourceComponent: Image {
            id: imgAccessoryButton
            source: root.accessoryIcon
        }
        active: accessoryIcon !== ""
        asynchronous: true
    }


}

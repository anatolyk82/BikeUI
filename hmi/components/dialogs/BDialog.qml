import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import styles 1.0
//import components 1.0
import "../"

Dialog {
    id: root

    x: (root.parent.width - width)/2
    y: (root.parent.height - height)/2
    width: 500
    height: 250
    modal: true
    focus: true

    signal okClicked()
    signal cancelClicked()

    default property alias bcontent: root.contentItem
    property int animationDuration: 200

    property int dialogButtons: Dialog.Ok | Dialog.Cancel

    /*background: Rectangle {
        gradient: Gradient {
            GradientStop { position: 0; color: "#01008a" } //TODO: move to Style
            GradientStop { position: 1; color: "#000106" } //TODO: move to Style
        }
    }*/

    header: Item {
        visible: root.title != ""
        width: parent.width
        height: root.title != "" ? StyleModel.toolbarHeight : 0
        ColumnLayout {
            anchors.fill: parent
            BLabel {
                Layout.fillWidth: true
                Layout.minimumHeight: 50
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: root.title
            }
            Rectangle {
                id: delimeterLine
                anchors.horizontalCenter: parent.horizontalCenter
                Layout.fillWidth: true
                Layout.minimumHeight: 1
                Layout.maximumWidth: 0.75*root.width
                color: StyleModel.primaryFontColor
            }
        }
    }

    footer: Item {
        visible: dialogButtons != 0
        width: parent.width
        height: StyleModel.buttonHeight + 10
        RowLayout {
            id: rowButtons
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Loader {
                Layout.fillWidth: true
                Layout.minimumHeight: StyleModel.buttonHeight
                Layout.preferredWidth: parent.width/2
                sourceComponent: BButton {
                    id: okButton
                    text: qsTr("Ok")
                    onClicked: root.okClicked()
                }
                visible: root.dialogButtons & Dialog.Ok
                active: visible
                asynchronous: true
            }

            Loader {
                Layout.fillWidth: true
                Layout.minimumHeight: StyleModel.buttonHeight
                Layout.preferredWidth: parent.width/2
                sourceComponent: BButton {
                    id: cancelButton
                    text: qsTr("Cancel")
                    onClicked: root.cancelClicked()
                }
                visible: root.dialogButtons & Dialog.Cancel
                active: visible
                asynchronous: true
            }
        }
    }

    enter: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: animationDuration*0.5; easing.type: Easing.OutQuart }
            NumberAnimation { property: "scale"; from: 0.0; to: 1.0; duration: animationDuration; easing.type: Easing.OutQuart }
        }
    }

    exit: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: animationDuration*0.5 }
            NumberAnimation { property: "scale"; from: 1.0; to: 0.0; duration: animationDuration }
        }
    }
}

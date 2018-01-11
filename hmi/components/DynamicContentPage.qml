import QtQuick 2.9
import QtQuick.Controls 2.2

Item {
    id: root

    property alias asynchronous: loader.asynchronous
    property alias item: loader.item
    property alias status: loader.status
    property alias active: loader.active
    property alias progress: loader.progress
    property alias source: loader.source
    property alias sourceComponent: loader.sourceComponent

    Loader {
        id: loader
        anchors.fill: parent
        asynchronous: true
        opacity: loader.status == Loader.Ready ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 500 } }
        onStatusChanged: {
            if (status === Loader.Error) {
                msgError.open()
            }
        }
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: loader.status == Loader.Loading
    }

    //TODO: create onError and add a popup on a error
    MessageDialog {
        id: msgError
        title: qsTr("Warning")
        text: qsTr("Cannot load the content")
        dialogButtons: Dialog.Ok
        onOkClicked: msgError.close()
    }
}

import QtQuick 2.10
import QtQuick.Controls 2.3


Loader {
    id: root

    signal widgetReady()

    property string containerWidgetType: ""
    property int containerRow: 0
    property int containerColumn: 0

    visible: source != ""
    asynchronous: true

    onLoaded: {
        if (status === Loader.Ready) {
            item.widgetRow = containerRow
            item.widgetColumn = containerColumn
            root.containerWidgetType = item.widgetType
            root.widgetReady()
        }
    }

    onSourceChanged: {
        if (source === "") {
            root.containerWidgetType = ""
        }
    }

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        visible: root.status == Loader.Loading
    }
}

import QtQuick 2.7
import QtQuick.Controls 2.0

Popup {
    x: (parent.width - width)/2
    y: (parent.height - height)/2

    modal: true
    focus: true

    width: 280
    height: 180

    contentItem: Label {
        anchors.centerIn: parent
        //text: "Bike OS 0.1"
    }
}

import QtQuick 2.7

Item {
    id: button
    width: 60
    height: width

    property alias iconSource: imgButton.source

    signal clicked()

    Image {
        id: imgButton
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onClicked: button.clicked()
    }
}

import QtQuick 2.9

Image {
    id: root
    property int notificationId: -1
    fillMode: Image.Pad
    horizontalAlignment: Image.AlignHCenter
    verticalAlignment: Image.AlignVCenter
    source: ""

    Component.onCompleted: {
        console.log("Notification icon: notificationId:"+notificationId+" source:"+source)
    }
}

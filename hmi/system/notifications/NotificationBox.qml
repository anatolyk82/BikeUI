import QtQuick 2.9
import QtQuick.Controls 2.2

import components 1.0

ListItem {
    id: root
    property int notificationId: -1
    property QtObject notificationObject: null
    property bool removeOnClick: true
    width: parent !== null ? parent.width : 800 //TODO: fix 800
    //TODO: Add time of notification
}

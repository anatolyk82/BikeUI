import QtQuick 2.9
import system.notifications 1.0

QtObject {
    id: root

    property int priority: 0 //FIXME: not implemented yet
    property string icon: ""
    property string primaryText: ""
    property string secondaryText: ""
    property string toolbarIcon: ""
    property int timeout: 0
    property bool removeOnClick: true

    //property Component delegate: Component { } //TODO: Add a possibility to define a component how a notification will look like

    signal triggered()

    function send() {
        NotificationCenter.addNotification(root)
    }

    function remove() {
        NotificationCenter.removeNotificationByObject(root)
    }
}

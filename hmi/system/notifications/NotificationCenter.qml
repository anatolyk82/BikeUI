pragma Singleton
import QtQuick 2.9
import QtQml.Models 2.2

import utils 1.0

QtObject {
    id: root

    /* DO NOT CHANGE THIS ID EXTERNALLY! */
    property int notificationIdCounter: 0

    /* This list contains all active notifications */
    readonly property ObjectModel notificationList: ObjectModel {}

    readonly property ObjectModel toolBarNotificationList: ObjectModel {}

    readonly property Component toolbarNotification: Component {
        NotificationToolbarIcon {}
    }

    readonly property Component simpleNotification: Component {
        NotificationBox {
            id: notificationBox
            property alias timeout: notificationTimer.interval
            onTriggered: {
                notificationObject.triggered()
                if (removeOnClick) {
                    removeNotification(notificationBox.notificationId)
                    notificationBox.destroy()
                }
            }
            Timer {
                id: notificationTimer
                interval: 0
                running: notificationTimer.interval > 0
                triggeredOnStart: false
                repeat: false
                onTriggered: {
                    interval = 0
                    removeNotification(notificationId)
                    notificationBox.destroy()
                }
            }
        }
    }

    /* This methods adds a simple notification to the notification list */
    function addNotification( notificationObject ) {
        var notificationIcon = "notification"
        if (notificationObject.icon != "") {
            notificationIcon = notificationObject.icon
        }
        var toolbarNotificationIcon = "w_notification"
        if (notificationObject.toolbarIcon != "") {
            toolbarNotificationIcon = notificationObject.toolbarIcon
        }

        var notification = simpleNotification.createObject(
                    root,
                    {
                        "notificationObject": notificationObject,
                        "removeOnClick": notificationObject.removeOnClick,
                        "primaryText": notificationObject.primaryText,
                        "secondaryText": notificationObject.secondaryText,
                        "iconSource": Utils.icon(notificationIcon),
                        "timeout": notificationObject.timeout,
                        "notificationId": notificationIdCounter
                    })
        if (notification == null) {
            console.warn("WARNING! Cannot create a notification")
        } else {
            notificationList.append(notification)
            if (true) {
                addToolbarNotification(notificationIdCounter, toolbarNotificationIcon)
            }
        }
        notificationIdCounter += 1
    }

    /* This methods removes a notification from the notification center */
    function removeNotification( notificationId ) {
        if (notificationId > -1) {
            for (var i=0; i<notificationList.count; i++) {
                if (notificationList.get(i).notificationId === notificationId) {
                    notificationList.remove(i)
                    removeToolbarNotification(notificationId)
                    break
                }
            }
        }
    }

    /* This methods removes a notification from the notification center */
    function removeNotificationByObject( notificationObject ) {
        for (var i=0; i<notificationList.count; i++) {
            if (notificationList.get(i).notificationObject === notificationObject) {
                var notificationId = notificationList.get(i).notificationId
                notificationList.remove(i)
                removeToolbarNotification(notificationId)
                break
            }
        }
    }


    /* It adds a notification icon to the toolbar */
    function addToolbarNotification(notificationId, toolbarIcon) {
        console.log("***"+toolbarIcon)
        var notification = toolbarNotification.createObject(
                    root,
                    {
                        "notificationId": notificationId,
                        "source": Utils.icon(toolbarIcon)
                    })
        if (notification == null) {
            console.warn("WARNING! Cannot create a toolbar notification")
        } else {
            toolBarNotificationList.append(notification)
        }
    }

    /* It removes a notification icon from the toolbar */
    function removeToolbarNotification( notificationId ) {
        if (notificationId > -1) {
            for (var i=0; i<toolBarNotificationList.count; i++) {
                if (toolBarNotificationList.get(i).notificationId === notificationId) {
                    var notification = toolBarNotificationList.get(i)
                    toolBarNotificationList.remove(i)
                    notification.destroy()
                    break
                }
            }
        }
    }
}

pragma Singleton
import QtQuick 2.9

import system.notifications 1.0

QtObject {
    id: root

    property string appsDirectory: "./apps/"
    property string currentApplicationTitle: ""
    property string currentApplicationId: ""

    //0 - the main carousel;  1 - the screen of an app
    property int activeScreenNumber: 0

    property bool verticalMainSwipeEnabled: true
    readonly property Notification lockNotification: Notification {
        primaryText: qsTr("Main menu swipe is locked")
        removeOnClick: false
        icon: "ic_swipe_disabled"
        toolbarIcon: "tb_swipe_disabled"
    }
    onVerticalMainSwipeEnabledChanged: {
        if (verticalMainSwipeEnabled) {
            lockNotification.remove()
        } else {
            lockNotification.send()
        }
    }

    property string courseToView: "" //TODO: should not be here
}

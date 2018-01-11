//pragma Singleton
import QtQuick 2.10

import system.notifications 1.0

import "."

QtObject {
    id: root

    readonly property QtObject battery: QtObject{

        property bool batteryLowNotificationSent: false
        readonly property Notification ntfBatteryLow: Notification {
            primaryText: qsTr("The battery is low")
        }

        property bool batteryVeryLowNotificationSent: false
        readonly property Notification ntfBatteryVeryLow: Notification {
            primaryText: qsTr("Critical battery level. Please charge it now.")
        }

        readonly property Connections batteryConnection: Connections {
            target: BatteryModel
            onLevelChanged: {
                if ((BatteryModel.level < 0.07)&&(!root.battery.batteryVeryLowNotificationSent)) {
                    battery.ntfBatteryVeryLow.send()
                    root.battery.batteryVeryLowNotificationSent = true
                    root.battery.batteryLowNotificationSent = true
                } else if ((BatteryModel.level < 0.2)&&(!root.battery.batteryLowNotificationSent)) {
                    battery.ntfBatteryLow.send()
                    root.battery.batteryLowNotificationSent = true
                }
            }
            onIsChargingChanged: {
                battery.batteryLowNotificationSent = false
                battery.batteryVeryLowNotificationSent = true
            }
        }
    }
}

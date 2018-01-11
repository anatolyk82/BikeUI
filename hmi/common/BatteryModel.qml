pragma Singleton
import QtQuick 2.9

import power 1.0
import utils 1.0

QtObject {
    id: root

    readonly property QtObject battery: Battery {}

    readonly property real level: battery.level
    readonly property real voltage: battery.voltage
    readonly property bool isCharging: battery.isCharging

    readonly property string batteryIcon: {
        if (isCharging) {
            return Utils.icon("tb_battery_charging")
        } else if (level < 0.2) {
            return Utils.icon("tb_battery_0")
        } else if (level < 0.4) {
            return Utils.icon("tb_battery_20")
        } else if (level < 0.6) {
            return Utils.icon("tb_battery_40")
        } else if (level < 0.8) {
            return Utils.icon("tb_battery_60")
        } else {
            return Utils.icon("tb_battery_100")
        }
    }

    readonly property string batteryPercentage: Math.round(level*100) + "%"
}

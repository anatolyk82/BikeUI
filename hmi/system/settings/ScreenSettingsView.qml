import QtQuick 2.9
import QtQuick.Controls 2.2

import components 1.0
import screen 1.0
import "."

SettingsView {
    id: root

    title: qsTr("Screen")

    BLabel {
        width: root.width
        text: qsTr("Screen brightness") + ": " + Math.round(brightnessSlider.value) + "%"
    }

    BSlider {
        id: brightnessSlider
        width: root.width
        from: 0
        to: 100
        stepSize: 1
        snapMode: Slider.SnapAlways
        value: Screen.brightness
        onValueChanged: {
            if (value !== Screen.brightness) {
                Screen.brightness = value
            }
        }
    }

}

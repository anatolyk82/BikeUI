import QtQuick 2.9
import QtQuick.Controls 2.2

import components 1.0
import utils 1.0
import "."

SettingsView {
    id: root

    title: qsTr("GPS")

    BLabel {
        width: root.width
        text: qsTr("Frequency of GPS data update, sec") + ": " + Math.round(sliderGPSInterval.value*10)/10
    }

    BSlider {
        id: sliderGPSInterval
        width: root.width
        from: 0.5
        to: 5
        stepSize: 0.5
        snapMode: Slider.SnapAlways
        value: SettingsModel.gpsIntervalUpdate/1000
        onValueChanged: SettingsModel.gpsIntervalUpdate = value*1000
    }

    BCheckBox {
        id: displayMovementStatusCheckbox
        width: root.width
        text: qsTr("Display a movement status in the toolbar")
        checked: SettingsModel.toolbarDisplaysMovements
        onCheckedChanged: SettingsModel.toolbarDisplaysMovements = displayMovementStatusCheckbox.checked
    }

    BCheckBox {
        id: displayCourseCheckbox
        width: root.width
        text: qsTr("Display the current course in the toolbar")
        checked: SettingsModel.toolbarDisplaysCourse
        onCheckedChanged: SettingsModel.toolbarDisplaysCourse = displayCourseCheckbox.checked
    }

    BCheckBox {
        id: displaySpeedCheckbox
        width: root.width
        text: qsTr("Display the current speed in the toolbar")
        checked: SettingsModel.toolbarDisplaysSpeed
        onCheckedChanged: SettingsModel.toolbarDisplaysSpeed = displaySpeedCheckbox.checked
    }
}

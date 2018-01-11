import QtQuick 2.9
import QtQuick.Controls 2.2

import utils 1.0
import common 1.0
import components 1.0

import "../.."

BigWidget {
    id: root

    plusVisible: false
    MapView {
        anchors.fill: parent

        //menuButtonVisible: true

        myPositionVisible: true
        myPositionCoordinate: GPSModel.coordinate
        myPositionCourse: {
            if (GPSModel.courseValid) {
                return GPSModel.course
            } else {
                return 0
            }
        }

        onMenuButtonClicked: {
            root.optionsActivated(widgetType, widgetRow, widgetColumn)
        }

        onMapViewEnabledChanged: {
            SystemModel.verticalMainSwipeEnabled = !mapViewEnabled
        }
    }
}

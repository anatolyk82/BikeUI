import QtQuick 2.7

import QtPositioning 5.5
import QtLocation 5.6

import utils 1.0
import common 1.0
import components 1.0

MapView {
    id: root

    clip: true

    myPositionVisible: true
    myPositionCoordinate: GPSModel.coordinate
    myPositionCourse: {
        if (GPSModel.courseValid) {
            return GPSModel.course
        } else {
            return 0
        }
    }
}

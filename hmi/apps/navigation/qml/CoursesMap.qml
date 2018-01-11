import QtQuick 2.7
import QtQuick.Controls 2.0

import QtPositioning 5.5
import QtLocation 5.6

import utils 1.0
import components 1.0
import common 1.0

import "./"

MapView {
    id: root
    padding: 0

    Component {
        id: componentCurrentPosition
        MapQuickItem {
            id: myPosition
            coordinate.latitude: GPSModel.latitude
            coordinate.longitude: GPSModel.longitude
            anchorPoint.x: arrowImg.width/2
            anchorPoint.y: arrowImg.height/2
            sourceItem: Image {
                id: arrowImg
                source: Utils.icon("map_arrow")
            }
        }
    }

    Connections {
        target: GPSModel
        onPositionUpdated: {
            drawCurrentPosition()
        }
    }

    Connections {
        target: CoursesModel
        onGpxTrackReady: {
            root.map.clearMapItems()

            root.map.addMapItem(CoursesModel.track)

            CoursesModel.setTrackColor('blue') //TODO: an option in settings
            CoursesModel.setTrackWidth(3)      //TODO: an option in settings

            setPosition( CoursesModel.position(0) )
        }
    }

    function drawCurrentPosition() {
        var posItem = componentCurrentPosition.createObject(root)
        root.map.addMapItem(posItem)
    }

    function setPosition(coordinate) {
        root.map.center = coordinate
    }

    Component.onCompleted: {
        drawCurrentPosition()
    }
}

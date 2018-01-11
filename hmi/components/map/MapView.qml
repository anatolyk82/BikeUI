import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

//import QtPositioning 5.5
import QtLocation 5.9
import QtGraphicalEffects 1.0

import utils 1.0
import components 1.0

Item {
    id: root

    property bool mapViewEnabled: false
    property int mapSize: 0

    property alias map: map

    readonly property int mapFreeView: 0
    readonly property int mapFollowsMyPosition: 1
    readonly property int mapFollowsMyPositionAndCourse: 2
    property int mapPositoning: mapFollowsMyPosition

    property var myPositionCoordinate: null//myPosition.coordinate
    property real myPositionCourse: 0
    property alias myPositionVisible: myPosition.visible
    property alias myPositionIcon: arrowImg.source

    property alias menuButtonVisible: buttonMenu.visible
    signal menuButtonClicked()

    onMapPositoningChanged: {
        if (mapPositoning === mapFreeView) {
            map.center = null
        } else if (mapPositoning === mapFollowsMyPosition) {
            map.center = Qt.binding(function(){ return root.myPositionCoordinate })
        } else if (mapPositoning === mapFollowsMyPositionAndCourse) {
            map.center = Qt.binding(function(){ return root.myPositionCoordinate })
        }
    }

    Plugin {
        id: pluginOSM
        name: "mapbox"
        PluginParameter { name: "mapbox.map_id"; value: "mapbox.streets" }
        PluginParameter { name: "mapbox.access_token"; value: "pk.eyJ1IjoiYW5hdG9seWsiLCJhIjoiY2l1dm94bjZvMDAxYTJ0bnE0dTFuZzk4ZyJ9.IV2B7PYFR_l5SPUEwBeEUQ" }
    }

    Map {
        id: map
        anchors.fill: parent
        transformOrigin: Item.Center

        bearing: mapPositoning === mapFollowsMyPositionAndCourse ? myPositionCourse : 0

        Behavior on bearing { NumberAnimation { duration: 500 } }

        plugin: pluginOSM
        gesture.enabled: mapViewEnabled

        property MapPolyline track

        MapQuickItem {
            id: myPosition
            coordinate: root.myPositionCoordinate
            anchorPoint.x: arrowImg.width/2
            anchorPoint.y: arrowImg.height/2
            sourceItem: Rectangle {
                id: arrowImg
                property alias source: arrowImgInternal.source
                width: 10
                height: width
                radius: width/2
                color: "blue"
                Image {
                    id: arrowImgInternal
                    anchors.centerIn: parent
                    source: Utils.icon("map_arrow")
                    rotation: mapPositoning === mapFollowsMyPositionAndCourse ? 0 : myPositionCourse
                    Behavior on rotation { NumberAnimation { duration: 300 } }
                    antialiasing: true
                    transformOrigin: Item.Center
                    opacity: 0.7
                }
            }
        }

        gesture.onPanStarted: {
            mapPositoning = mapFreeView
        }
    }

    ColumnLayout {
        anchors.right: parent.right
        anchors.top: parent.top
        height: parent.height

        MapButton {
            id: buttonMenu
            anchors.horizontalCenter: parent.horizontalCenter
            iconSource: Utils.icon("menu")
            onClicked: root.menuButtonClicked()
            visible: false
        }

        MapButton {
            id: buttonMoveMap
            anchors.horizontalCenter: parent.horizontalCenter
            iconSource: mapViewEnabled ? Utils.icon("hand_cancel") : Utils.icon("hand")
            onClicked: mapViewEnabled = !mapViewEnabled
        }

        MapButton {
            id: buttonCourse
            anchors.horizontalCenter: parent.horizontalCenter
            iconSource: mapPositoning === mapFreeView ? Utils.icon("position") : Utils.icon("compass")
            rotation: mapPositoning === mapFollowsMyPositionAndCourse ? -45 : 0
            Behavior on rotation { NumberAnimation {duration: 100} }
            onClicked: {
                if (mapPositoning === mapFreeView) {
                    mapPositoning = mapFollowsMyPosition
                } else if (mapPositoning === mapFollowsMyPosition) {
                    mapPositoning = mapFollowsMyPositionAndCourse
                } else if (mapPositoning === mapFollowsMyPositionAndCourse) {
                    mapPositoning = mapFollowsMyPosition
                }
            }
        }

        //---------- zoom buttons
        MapButton {
            id: buttonZoomIn
            anchors.horizontalCenter: parent.horizontalCenter
            iconSource: Utils.icon("zoom_in")
            onClicked: map.zoomLevel += 0.5
        }

        MapButton {
            id: buttonZoomOut
            anchors.horizontalCenter: parent.horizontalCenter
            iconSource: Utils.icon("zoom_out")
            onClicked: map.zoomLevel -= 0.5

        }
    }



    //------------

    Item {
        anchors.left: parent.left
        anchors.leftMargin: mapViewEnabled ? 0 : -width
        Behavior on anchors.leftMargin { NumberAnimation { duration: 200 } }
        anchors.top: parent.top
        height: parent.height
        width: 58

        MapButton {
            id: buttonRotateCw
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.right: parent.right
            width: 48
            iconSource: Utils.icon("rotate_clockwise")
            onClicked: map.bearing -= 5
        }

        MapButton {
            id: buttonRotateAcw
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            width: 48
            iconSource: Utils.icon("rotate_anticlockwise")
            onClicked: map.bearing += 5
        }
    }

    Component.onCompleted: {
        map.zoomLevel = map.maximumZoomLevel*0.8 //TODO: make somthing better than this
    }
}

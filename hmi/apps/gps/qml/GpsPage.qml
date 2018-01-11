import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import QtQml.Models 2.3

import "./"

import common 1.0
import utils 1.0
import components 1.0


Item {
    id: root

    ListView {
        id: swipeView
        anchors.fill: parent
        snapMode: ListView.SnapOneItem
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        highlightRangeMode: ListView.StrictlyEnforceRange
        preferredHighlightBegin: 0
        preferredHighlightEnd: 0
        highlightMoveDuration: 250

        interactive: !gpsPageLocation.mapViewEnabled

        model: ObjectModel {
            GpsPageConstellation {
                width: swipeView.width
                height: swipeView.height
            }

            GpsPageLocation {
                id: gpsPageLocation
                width: swipeView.width
                height: swipeView.height
                onMapViewEnabledChanged: {
                    SystemModel.verticalMainSwipeEnabled = !mapViewEnabled
                }
            }
        }
    }

    HidingPageIndicator {
        id: pageIndicator
        count: swipeView.count
        currentIndex: swipeView.currentIndex
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

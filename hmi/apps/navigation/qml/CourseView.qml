import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

import QtQml.Models 2.2

import QtPositioning 5.5
import QtLocation 5.6

import utils 1.0
import components 1.0
import common 1.0

import "./"

Item {
    id: root

    property bool swipePagesEnabled: true

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

        interactive: swipePagesEnabled

        model: ObjectModel {
            CoursesMap {
                id: map
                width: swipeView.width
                height: swipeView.height
                mapViewEnabled: !swipePagesEnabled
            }
            CoursesElevation {
                id: elevation
                width: swipeView.width
                height: swipeView.height

                distanceMin: 0
                distanceMax: CoursesModel.entireDistance

                altitudeMin: CoursesModel.altitudeMin
                altitudeMax: CoursesModel.altitudeMax
            }
            CoursesSummary {
                id: summary
                width: swipeView.width
                height: swipeView.height
            }
        }

        onCurrentIndexChanged: {
            pageIndicator.opacity = 1
            timerHidePageIndicatior.stop()
            timerHidePageIndicatior.start()
        }
    }

    PageIndicator {
        id: pageIndicator
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        visible: opacity > 0
        Behavior on opacity { NumberAnimation { duration: 200 } }
        count: swipeView.count
        currentIndex: swipeView.currentIndex
    }

    Timer {
        id: timerHidePageIndicatior
        repeat: false
        triggeredOnStart: false
        interval: 3000
        onTriggered: {
            pageIndicator.opacity = 0
        }
    }


    Component.onCompleted: {
        timerHidePageIndicatior.start()
        CoursesModel.setGPXFile(SystemModel.courseToView)
    }
}

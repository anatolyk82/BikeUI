import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQml.Models 2.2

import styles 1.0
import common 1.0
import components 1.0

import "."

Item {
    id: root

    SwipeView {
        id: swipeView
        anchors.fill: parent
        StopwatchView {
        }
        TimerView {
        }
        OdometerView {
        }
    }

    PageIndicator {
        id: indicator
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        count: swipeView.count
        currentIndex: swipeView.currentIndex
    }
}

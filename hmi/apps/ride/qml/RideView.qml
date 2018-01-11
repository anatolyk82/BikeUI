import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.0
import Qt.labs.settings 1.0

import utils 1.0
import components 1.0
import styles 1.0

import "./"

Item {
    id: root

    SwipeView {
        id: swipeView
        anchors.fill: parent

        WidgetPage {
            id: widgetPage1
            name: "RidePage1"
            width: root.width
            height: root.height
        }

        WidgetPage {
            id: widgetPage2
            name: "RidePage2"
            width: root.width
            height: root.height
        }

        WidgetPage {
            id: widgetPage3
            name: "RidePage3"
            width: root.width
            height: root.height
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

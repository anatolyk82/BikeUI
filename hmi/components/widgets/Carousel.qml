import QtQuick 2.9
import QtQuick.Controls 2.2

ListView {
    id: root

    property int delegateItemWidth: 280
    property alias pageIndicatorVisible: indicator.visible

    orientation: Qt.Horizontal
    displayMarginBeginning: (width - root.delegateItemWidth)/2
    displayMarginEnd: (width + root.delegateItemWidth)/2
    preferredHighlightBegin: (width - root.delegateItemWidth)/2
    preferredHighlightEnd: (width + root.delegateItemWidth)/2
    highlightRangeMode: ListView.StrictlyEnforceRange
    boundsBehavior: Flickable.StopAtBounds

    PageIndicator {
        id: indicator

        count: root.count
        currentIndex: root.currentIndex

        anchors.bottom: root.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

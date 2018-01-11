import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQml.Models 2.2

ListView {
    id: root

    default property alias items: objectModel.children

    orientation: Qt.Vertical
    displayMarginBeginning: 0
    displayMarginEnd: root.height
    preferredHighlightBegin: 0
    preferredHighlightEnd: root.height
    highlightRangeMode: ListView.StrictlyEnforceRange
    boundsBehavior: Flickable.StopAtBounds
    snapMode: ListView.SnapToItem

    model: ObjectModel {
        id: objectModel
    }
}

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import components 1.0

Rectangle {
    id: root

    anchors.left: parent.left
    anchors.top: parent.top
    anchors.leftMargin: -root.width

    function open() {
        root.anchors.leftMargin = 0
    }

    function close() {
        root.anchors.leftMargin = -root.width
    }
}

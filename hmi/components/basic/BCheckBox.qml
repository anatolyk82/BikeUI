import QtQuick 2.9
import QtQuick.Controls 2.3

import components 1.0
import styles 1.0

CheckBox {
    id: root

    indicator: Rectangle {
        implicitWidth: 32
        implicitHeight: 32
        x: root.leftPadding
        y: parent.height / 2 - height / 2
        radius: 4
        border.color: root.enabled ? StyleModel.primaryFontColor : StyleModel.secondaryFontColor
        border.width: 2
        color: "transparent"

        Rectangle {
            width: root.checked ? 18 : 0
            height: root.checked ? 18 : 0
            Behavior on width { NumberAnimation { duration: 150 } }
            Behavior on height { NumberAnimation { duration: 150 } }
            anchors.centerIn: parent
            radius: 2
            color: root.enabled ? StyleModel.primaryFontColor : StyleModel.secondaryFontColor
            visible: width !== 0
        }
    }

    contentItem: BLabel {
        text: root.text
        opacity: enabled ? 1.0 : 0.3
        verticalAlignment: Text.AlignVCenter
        leftPadding: root.indicator.width + root.spacing
    }
}

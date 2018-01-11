import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import styles 1.0

Button {
    id: root

    property string iconSource: ""
    height: StyleModel.buttonHeight
    //Layout.minimumHeight: StyleModel.buttonHeight

    //TODO: https://bugreports.qt.io/browse/QTBUG-50992
    contentItem: RowLayout {
        //implicitHeight: StyleModel.buttonHeight
        //implicitWidth: 200
        Image {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.iconSource !== ""
            fillMode: Image.Pad
            horizontalAlignment: Image.AlignHCenter
            verticalAlignment: Image.AlignVCenter
            source: root.iconSource
            Layout.fillWidth: root.text === "" ? true : false
        }
        BLabel {
            anchors.verticalCenter: parent.verticalCenter
            visible: root.text !== ""
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: root.text
            Layout.fillWidth: true
        }
    }
}

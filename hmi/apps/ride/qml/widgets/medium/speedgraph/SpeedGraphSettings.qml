import QtQuick 2.9
import QtQuick.Controls 2.2

import components 1.0
import styles 1.0

Flickable {
    id: root

    property int maxSpeed: 50
    property bool autoScale: true
    property int timeDepth: 60
    property bool gridVisible: true

    signal resetData()

    anchors.fill: parent
    clip: true

    flickableDirection: Flickable.VerticalFlick
    interactive: contentHeight > height

    contentWidth: content.width
    contentHeight: content.height

    ScrollIndicator.vertical: ScrollIndicator { }

    Column {
        id: content
        anchors.centerIn: parent
        spacing: 0
        BLabel {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Time depth of the graph, sec") + ": " + root.timeDepth
        }
        BSlider {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width
            from: 10
            to: 300
            stepSize: 1
            value: root.timeDepth
            onValueChanged: root.timeDepth = value
        }
        BCheckBox {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width
            checked: autoScale
            onCheckedChanged: root.autoScale = checked
            text: qsTr("Automatic scale")
        }
        BLabel {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Speed limit, km/h") + ": " + root.maxSpeed
        }
        BSlider {
            enabled: !root.autoScale
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width
            from: 10
            to: 80
            stepSize: 1
            value: root.maxSpeed
            onValueChanged: root.maxSpeed = value
        }
        BCheckBox {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width
            checked: gridVisible
            onCheckedChanged: root.gridVisible = checked
            text: qsTr("Display a grid on the graph")
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Reset the graph")
            width: parent.width*0.8
            height: StyleModel.buttonHeight
            onClicked: root.resetData()
        }
    }

    function accepted() {
    }

    function rejected() {
    }
}

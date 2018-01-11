import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import utils 1.0
import components 1.0

/*Item {
    id: root

    signal itemClicked(string mainFile)
    signal itemMoved(int newIndex)

    property bool isCurrentIndex: false
    property alias icon: iconImg.source
    property alias name: label.text
    property int currentIndex: -1
    property int clickAnimationTime: 300
    property bool isHeld: false

    //Behavior on x { NumberAnimation { duration: 500 } }

    Column {
        id: content
        spacing: 20
        anchors.centerIn: parent
        Behavior on opacity { NumberAnimation{ duration: clickAnimationTime*0.8; easing.type: Easing.OutQuart } }
        Behavior on scale { NumberAnimation{ duration: clickAnimationTime } }
        Item {
            id: iconImgWrapper
            anchors.horizontalCenter: parent.horizontalCenter
            width: iconImg.width
            height: iconImg.height
            Image {
                id: iconImg
                anchors.centerIn: parent
                source: root.icon
                visible: progress == 1.0
                antialiasing: true
            }
            InnerShadow {
                anchors.fill: iconImg
                radius: 2
                samples: 4
                horizontalOffset: 1.0
                verticalOffset: 1.0
                color: "grey" //"#b0000000"
                source: iconImg
                enabled: iconImg.visible
            }
        }
        HighlightedLabel {
            id: label
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 22
            text: root.text
            highlightingEnable: isCurrentIndex
        }
    }

    state: isHeld ? "held" : (isCurrentIndex ? "selected" : "normal")
    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: content
                scale: 0.9
                opacity: 1
            }
        },
        State {
            name: "clicked"
            PropertyChanges {
                target: content
                scale: 5.0
                opacity: 0
            }
        },
        State {
            name: "selected"
            PropertyChanges {
                target: content
                scale: 1.3
                opacity: 1
            }
        },
        State {
            name: "held"
            PropertyChanges {
                target: content
                scale: 1.7
                opacity: 1
            }
        }
    ]

    transitions: Transition {
        to: "clicked"
        SequentialAnimation {
            PauseAnimation { duration: clickAnimationTime }
            ScriptAction {
                script: root.itemClicked(model.mainFile)
            }
            PauseAnimation { duration: 100 }
            ScriptAction {
                script: root.state = Qt.binding(function(){ return isCurrentIndex ? "selected" : "normal" })
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        //pressAndHoldInterval: 2000
        drag.target: root.isHeld ? root : undefined
        drag.axis: Drag.XAxis
        onPressAndHold: {
            newIndex = currentIndex
            root.isHeld = true

            console.log("::"+ListView.view.indexAt(mouseX, mouseY))
        }
        onReleased: {
            root.x = newIndex*root.width
            root.isHeld = false
        }
        onPositionChanged: {
            newIndex = root.x < 0 ? 0 : Math.round(root.x/root.width)
            if ((currentIndex != newIndex)&&isHeld) {
                //root.itemMoved(newIndex)
                //screenManager.swapScreens(preIndex, index)
                //preIndex = index
                currentIndex = newIndex
            }
        }
    }
    property int newIndex: -1
}
*/

MouseArea {
    id: root

    signal itemClicked(string mainFile)
    signal itemMoved(int newIndex)

    property bool isCurrentIndex: false
    property alias icon: iconImg.source
    property alias name: label.text
    property int currentIndex: -1
    property int clickAnimationTime: 300
    property bool isHeld: false

    //anchors { left: parent.left; right: parent.right }
    height: content.height

    drag.target: root.isHeld ? root : undefined
    drag.axis: Drag.XAxis

    onPressAndHold: root.isHeld = true
    onReleased: root.isHeld = false
    onClicked: state = "clicked"

    Column {
        id: content
/*
        Drag.active: root.isHeld
        Drag.source: root
        Drag.hotSpot.x: width / 2
        Drag.hotSpot.y: height / 2
*/
        spacing: 20
        anchors.centerIn: parent

        Behavior on opacity { NumberAnimation{ duration: clickAnimationTime*0.8; easing.type: Easing.OutQuart } }
        Behavior on scale { NumberAnimation{ duration: clickAnimationTime } }

        Item {
            id: iconImgWrapper
            anchors.horizontalCenter: parent.horizontalCenter
            width: iconImg.width
            height: iconImg.height
            Image {
                id: iconImg
                anchors.centerIn: parent
                source: root.icon
                visible: progress == 1.0
                antialiasing: true
            }
            InnerShadow {
                anchors.fill: iconImg
                radius: 2
                samples: 4
                horizontalOffset: 1.0
                verticalOffset: 1.0
                color: "grey" //"#b0000000"
                source: iconImg
                enabled: iconImg.visible
            }
        }
        HighlightedLabel {
            id: label
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 22
            text: root.text
            highlightingEnable: isCurrentIndex
        }
    }

    state: isHeld ? "held" : (isCurrentIndex ? "selected" : "normal")
    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: content
                scale: 0.9
                opacity: 1
            }
        },
        State {
            name: "clicked"
            PropertyChanges {
                target: content
                scale: 5.0
                opacity: 0
            }
        },
        State {
            name: "selected"
            PropertyChanges {
                target: content
                scale: 1.3
                opacity: 1
            }
        },
        State {
            name: "held"
            PropertyChanges {
                target: content
                scale: 1.7
                opacity: 1
            }
        }
    ]

    transitions: Transition {
        to: "clicked"
        SequentialAnimation {
            PauseAnimation { duration: clickAnimationTime }
            ScriptAction {
                script: root.itemClicked(model.mainFile)
            }
            PauseAnimation { duration: 100 }
            ScriptAction {
                script: root.state = Qt.binding(function(){ return isCurrentIndex ? "selected" : "normal" })
            }
        }
    }

    DropArea {
        anchors { fill: parent; margins: 10 }

        onEntered: {
            console.log(currentIndex)
            //visualModel.items.move( drag.source.DelegateModel.itemsIndex, root.DelegateModel.itemsIndex)
            //root.itemMoved()
        }
    }
}

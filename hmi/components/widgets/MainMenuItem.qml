import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import utils 1.0
import components 1.0
import styles 1.0

Item {
    id: root

    signal itemClicked(string mainFile)
    signal itemMoved(int oldIndex, int newIndex)
    signal requestToBeCurrentItem(int requestingIndex)

    property bool isCurrentIndex: false
    property alias icon: iconImg.source
    property alias name: label.text
    property int currentIndex: -1
    property int clickAnimationTime: 300
    property bool isHeld: false
    property int count: 0

    property int newIndex: -1

    Behavior on x { NumberAnimation { duration: 500 } }

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
                layer.enabled: root.isCurrentIndex && StyleModel.allowGlowing
                layer.effect: Glow {
                    color: "#00aaff"
                    radius: 40
                    samples: 2*radius
                    spread: 0.25
                }
            }
            ShaderEffect {
                id: reflectionEffect
                readonly property variant mask: ShaderEffectSource {
                    sourceItem: reflectionMask
                    hideSource: true
                }

                readonly property variant source: ShaderEffectSource {
                    sourceItem: iconImg
                    hideSource: false
                }

                width: iconImg.paintedWidth
                height: iconImg.paintedHeight

                anchors.horizontalCenter: iconImg.horizontalCenter
                anchors.verticalCenter: iconImg.verticalCenter
                anchors.verticalCenterOffset: 1.1*iconImg.height

                fragmentShader: "
                    varying highp vec2 qt_TexCoord0;
                    uniform sampler2D source;
                    uniform sampler2D mask;
                    void main(void)
                    {
                        gl_FragColor = texture2D(source, vec2(qt_TexCoord0.s, 1.0 - qt_TexCoord0.t)) * texture2D(mask, qt_TexCoord0).a;
                    }
                "
            }
            Rectangle {
                id: reflectionMask
                visible: false
                width: iconImg.width
                height: iconImg.height
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#20ffffff" }
                    GradientStop { position: 1; color: "transparent" }
                }
            }
        }
        HighlightedLabel {
            id: label
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 24
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
                scale: 1.2
                opacity: 1
            }
        },
        State {
            name: "held"
            PropertyChanges {
                target: content
                scale: 1.0
                opacity: 0.7
            }
        }
    ]

    SequentialAnimation {
        running: root.state == "held"
        alwaysRunToEnd: true
        loops: Animation.Infinite
        PropertyAnimation { target: content; property: "rotation"; to: -5; duration: 50 }
        PropertyAnimation { target: content; property: "rotation"; to: 5; duration: 100 }
        PropertyAnimation { target: content; property: "rotation"; to: 0; duration: 50 }
    }

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
        pressAndHoldInterval: 1000
        drag.target: root.isHeld ? root : undefined
        drag.axis: Drag.XAxis
        onClicked: {
            if (isCurrentIndex) {
                root.state = "clicked"
            } else {
                root.requestToBeCurrentItem(currentIndex) //move the clicked item to current
                timerClickedAsCurrentItem.start()         //wait until the animation is done and run the app
            }
        }
        onPressAndHold: {
            root.z = 1
            newIndex = currentIndex
            root.isHeld = true
        }
        onReleased: {
            if (root.isHeld) {
                root.z = 0
                if (currentIndex != newIndex) {
                    if (newIndex > (count-1)) {
                        newIndex = count - 1
                    }
                    root.itemMoved(currentIndex, newIndex)
                    currentIndex = newIndex
                } else {
                    root.x = currentIndex*root.width
                }
                root.isHeld = false
            }
        }
        onPositionChanged: {
            newIndex = root.x < 0 ? 0 : Math.round(root.x/root.width)
        }
    }

    Timer {
        id: timerClickedAsCurrentItem
        interval: clickAnimationTime
        repeat: false
        onTriggered: root.state = "clicked"
    }
}

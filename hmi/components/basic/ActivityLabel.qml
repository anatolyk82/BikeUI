import QtQuick 2.9
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import styles 1.0

BLabel {
    id: root
    color: StyleModel.primaryFontColor

    opacity: 0.8

    property bool running: true
    property int animationTime: 2000

    Item {
        anchors.fill: parent

        Loader {
            id: loaderMask
            anchors.fill: parent
            active: false

            sourceComponent: LinearGradient {
                id: linearGradient

                property int startingX: -linearGradient.width
                x: startingX
                visible: sequentialAnimationGradient.running

                SequentialAnimation on x {
                    id: sequentialAnimationGradient
                    running: root.running
                    loops: Animation.Infinite
                    NumberAnimation {
                        from: linearGradient.startingX
                        to: root.width
                        duration: root.animationTime
                    }
                    PauseAnimation {
                        duration: root.animationTime
                    }
                }

                width: 2*height
                height: 2*parent.height

                start: Qt.point(0, 0)
                end: Qt.point(width, height)

                gradient: Gradient {
                    GradientStop {
                        position: 0.25
                        color: "#00FFFFFF"
                    }
                    GradientStop {
                        position: 0.5
                        color: StyleModel.primaryFontColor
                    }
                    GradientStop {
                        position: 0.6
                        color: "#00FFFFFF"
                    }
                }
            }
        }

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Item {
                width: root.width
                height: root.height

                Label {
                    anchors.fill: parent
                    font.family: root.font.family
                    font.pixelSize: root.font.pixelSize
                    font.bold: root.font.bold
                    text: root.text
                }
            }
        }

        Component.onCompleted: {
            // NOTE: Load the mask loader after the text has been drawn
            loaderMask.active = true;
        }
    }
}

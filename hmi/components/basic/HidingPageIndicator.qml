import QtQuick 2.10
import QtQuick.Controls 2.3


PageIndicator {
    id: root

    property alias hidingInterval: timerToHidePageIndicator.interval

    opacity: 1
    visible: opacity > 0
    Behavior on opacity {
        id: opacityBehavior
        enabled: false
        SequentialAnimation {
            NumberAnimation { duration: 1000 }
            ScriptAction { script: opacityBehavior.enabled = false }
        }
    }
    onCurrentIndexChanged: {
        root.opacity = 1
        opacityBehavior.enabled = true
        timerToHidePageIndicator.restart()
    }
    Timer {
        id: timerToHidePageIndicator
        interval: 2000
        triggeredOnStart: false
        repeat: false
        onTriggered: root.opacity = 0
    }
    Component.onCompleted: timerToHidePageIndicator.restart()
}

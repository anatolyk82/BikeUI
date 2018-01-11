pragma Singleton
import QtQuick 2.7
import Qt.labs.settings 1.0

import styles 1.0

QtObject {
    id: root

    /* constants of widgets */
    readonly property int widgetBig: StyleModel.screenHeight - StyleModel.toolbarHeight
    readonly property int widgetMiddle: (StyleModel.screenHeight - StyleModel.toolbarHeight)/2
    readonly property int widgetSmall: (StyleModel.screenHeight - StyleModel.toolbarHeight)/3
    readonly property int widgetTiny: (StyleModel.screenHeight - StyleModel.toolbarHeight)/4
    readonly property int widgetWidth: StyleModel.screenWidth/2

    readonly property string widgetBigType: "B"
    readonly property string widgetMediumType: "M"
    readonly property string widgetSmallType: "S"

    readonly property string widgetBigFile: "widgets/BigWidget.qml"
    readonly property string widgetMediumFile: "widgets/MediumWidget.qml"
    readonly property string widgetSmallFile: "widgets/SmallWidget.qml"


    /* The list of available widgets */
    readonly property ListModel modelSmallWidgets: ListModel {
        ListElement {
            icon: "hand_cancel"
            name: "Empty"
            description: "Remove the widget from the choosen position"
            file: ""
        }
        ListElement {
            icon: "compass"
            name: "Coordinates"
            description: "It displays current coordinates"
            file: "widgets/small/coordinates/Coordinate.qml"
        }
        ListElement {
            icon: "ic_satellite"
            name: "Satellites"
            description: "It displays a graph of levels for every satellite in view."
            file: "widgets/small/satellites/Satellites.qml"
        }
        ListElement {
            icon: "ic_speedometer"
            name: "Simple speedometer"
            description: "A simple speedometer which displays the current speed."
            file: "widgets/small/speedometer/SimpleSpeedometer.qml"
        }
    }

    readonly property ListModel modelMediumWidgets: ListModel {
        ListElement {
            icon: "hand_cancel"
            name: "Empty"
            description: "Remove the widget from the choosen position"
            file: ""
        }
        ListElement {
            icon: "compass"
            name: "MWidget"
            description: "This is a sample of a medium widget"
            file: "widgets/medium/example/Example.qml"
        }
        ListElement {
            icon: "compass"
            name: "MWidget"
            description: "Shows a graph of the current speed"
            file: "widgets/medium/speedgraph/SpeedGraph.qml"
        }
        ListElement {
            icon: "ic_arrow"
            name: "Course"
            description: "The widget shows the current course."
            file: "widgets/medium/course/Course.qml"
        }
    }

    readonly property ListModel modelBigWidgets: ListModel {
        ListElement {
            icon: "hand_cancel"
            name: "Empty"
            description: "Remove the widget from the choosen position"
            file: ""
        }
        ListElement {
            icon: "compass"
            name: "BWidget"
            description: "This is a sample of a big widget"
            file: "widgets/big/example/Example.qml"
        }
        ListElement {
            icon: "compass"
            name: "Map"
            description: "This is a sample of a map"
            file: "widgets/big/map/Map.qml"
        }
        ListElement {
            icon: "ic_speedometer"
            name: "Speedometer"
            description: "Big funcy speedometer"
            file: "widgets/big/speedometer/Speedometer.qml"
        }
    }
}




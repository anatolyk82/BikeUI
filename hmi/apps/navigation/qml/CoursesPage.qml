import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls.Material 2.0

import utils 1.0
import components 1.0
import common 1.0

import courses 1.0

import "./"

Item {
    id: root

    TrackFilesModel {
        id: filesSet
        path: "/home/anatoly/Projects/Bike/GPXTracks" //TODO: put in a model
        fileType: TrackFilesModel.GPX
    }

    ListView {
        id: swipeView
        anchors.fill: parent
        anchors.margins: 10

        delegate: ListItem {
            width: swipeView.width
            iconSource: Utils.icon("ic_map")
            primaryText: FileName
            secondaryText: FilePath + "/" + FileName
            onClicked: {
                SystemModel.courseToView = FilePath + "/" + FileName
                SystemModel.pushPage("components/navigation/CourseView.qml")
            }
        }

        model: filesSet
    }

    Component.onCompleted: {
        filesSet.update()
    }
}

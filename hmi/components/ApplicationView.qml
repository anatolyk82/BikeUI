import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import common 1.0
import components 1.0

DynamicContentPage {
    id: root

    property string currentAppTitle: ""

    //TODO: Move these functions to a model/singleton ?
    function runApplicationModel(model) {
        currentAppTitle = model.name
        root.source = Qt.resolvedUrl("../"+model.mainFile)
        SystemModel.currentApplicationId = model.appId
    }

    function runApplication(appId, title, file) {
        currentAppTitle = title
        root.source = Qt.resolvedUrl(file)
        SystemModel.currentApplicationId = appId
    }
}
